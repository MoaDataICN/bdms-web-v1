package com.moadata.bdms.announcement.controller;

import com.moadata.bdms.announcement.service.AnnouncementService;
import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.vo.AnnouncementVO;
import com.moadata.bdms.model.vo.HealthAlertVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.tracking.service.TrackingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

    @Resource(name="announcementService")
    private AnnouncementService announcementService;

	@Resource(name="trackingService")
	private TrackingService trackingService;

	@Resource(name="groupService")
	private GroupService groupService;

    @GetMapping("/message")
    public String message(){

        return "announcement/message";
    }

    @GetMapping("/history")
    public String history(){

        return "announcement/history";
    }

    @ResponseBody
    @PostMapping("/sendMessage")
    public Map<String, Object> sendMessage(AnnouncementVO announcementVO) {
        Map<String, Object> map = new HashMap<>();
        boolean isError = false;
        String message = "";

        try {
            announcementService.insertAnnouncement(announcementVO);

        } catch(Exception e) {
            e.printStackTrace();
            isError = true;
            message = e.getMessage();
        }

        map.put("isError", isError);
        map.put("message", message);

        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/selectMessageHistory", method = RequestMethod.POST)
    public Map<String, Object> selectUserRequest(@ModelAttribute AnnouncementVO announcementVO) {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<AnnouncementVO> resultList;

        try {
            announcementVO.setSortColumn(announcementVO.getSidx());
            announcementVO.setPageIndex(Integer.parseInt(announcementVO.getPage()) -1);
            announcementVO.setRowNo(announcementVO.getPageIndex() * announcementVO.getRows());

            resultList = announcementService.selectAnnouncementList(announcementVO);
            int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();
            map.put("page", announcementVO.getPageIndex() + 1);
            map.put("records", records);
            map.put("total", records == 0 ? 1 : Math.ceil(records / (double) announcementVO.getRows()));
            map.put("rows", resultList);
        } catch(Exception e) {
            e.printStackTrace();
            isError = true;
            message = e.getMessage();
        }

        map.put("isError", isError);
        map.put("message", message);

        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/selectUserMessage", method = RequestMethod.POST)
    public Map<String, Object> selectUserMessage(String userId, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<AnnouncementVO> resultList;

        try {
            resultList = announcementService.selectUserMessage(userId);
            map.put("messageList", resultList);

			/** Health Alert / Service Request 추가 */
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        Calendar c1 = Calendar.getInstance();
			c1.add(Calendar.DATE, 1);
	        String strToday = sdf.format(c1.getTime());

	        c1.add(Calendar.DATE, -6);
	        String strLastWeek = sdf.format(c1.getTime());

			HealthAlertVO healthAlertVO = new HealthAlertVO();
			UserRequestVO userRequestVO = new UserRequestVO();

	        List<HealthAlertVO> healthAlertList;
			List<UserRequestVO> userRequestList;

	        HttpSession session = request.getSession(false);
	        UserVO user = (UserVO) session.getAttribute("user");

	        healthAlertVO.setSearchEndDe(strToday);
	        healthAlertVO.setSearchBgnDe(strLastWeek);
	        healthAlertVO.setRowNo(0);
	        healthAlertVO.setRows(999);

	        userRequestVO.setSearchEndDe(strToday);
	        userRequestVO.setSearchBgnDe(strLastWeek);
	        userRequestVO.setRowNo(0);
	        userRequestVO.setRows(999);

			if(user.getGrpLv().equals("1")) {
				String inChargeIds = groupService.selectLowLevelAdmins(user.getGrpId()).stream().map(vo -> "'" + vo.getUserId() + "'").collect(Collectors.joining(",", "(", ")"));

				healthAlertVO.setInChargeIds(inChargeIds);
				userRequestVO.setInChargeIds(inChargeIds);

				healthAlertList = trackingService.selectHealthAlert(healthAlertVO);
				userRequestList = trackingService.selectUserRequest(userRequestVO);
			} else {
				healthAlertVO.setInChargeId(user.getUserId());
				userRequestVO.setInChargeId(user.getUserId());

				healthAlertList = trackingService.selectHealthAlert(healthAlertVO);
				userRequestList = trackingService.selectUserRequest(userRequestVO);
			}

			map.put("alertList", healthAlertList);
			map.put("requestList", userRequestList);

        } catch(Exception e) {
            e.printStackTrace();
            isError = true;
            message = e.getMessage();
        }

        map.put("isError", isError);
        map.put("message", message);

        return map;
    }

	@GetMapping("/messagePopup")
	public String messagePopup(ModelMap model, String annId, String userId) {
		Map<String, Object> param = new HashMap<>();
		param.put("annId", annId);
		param.put("userId", userId);

		announcementService.updateAnnouncementSt(param);

		model.addAttribute("message", announcementService.selectAnnouncementByAnnId(annId));
		return "popup/messagePopup";
	}
}
