package com.moadata.bdms.tracking.controller;

import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.HealthAlertVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.tracking.service.TrackingService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/tracking")
public class TrackingController {

    @Resource(name ="trackingService")
    private TrackingService trackingService;

    @Resource(name = "groupService")
    private GroupService groupService;

    @GetMapping("/userRequests")
    public String userRequests(ModelMap model) {
        // 세션에 저장 된, 사용자의 정보를 바탕으로 조회를 수행
        // GRP_ID, GRP_LV 를 세션에 저장하며, 이를 바탕으로 조회 조건 및 레벨이 달라짐

        String grpId = "G0010";
        String grpLv = "1";

        if(grpLv != null && grpLv.equals("1")) {
            // 최상위 관리자인 경우
            List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
            List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);

            model.addAttribute("groupList", groupList);
            model.addAttribute("inChargeList", inChargeList);

        } else if(grpLv != null && grpLv.equals("2")) {
            // 담당자인 경우
            // 딱히? 넣어줄게 없겠지 ㅇㅇ
            // 일단은 영역만 넣어둠
        }

        return "tracking/userRequests";
    }

    @GetMapping("/healthAlerts")
    public String healthAlerts(ModelMap model) {
        // 세션에 저장 된, 사용자의 정보를 바탕으로 조회를 수행
        // GRP_ID, GRP_LV 를 세션에 저장하며, 이를 바탕으로 조회 조건 및 레벨이 달라짐

        String grpId = "G0010";
        String grpLv = "1";

        if(grpLv != null && grpLv.equals("1")) {
            // 최상위 관리자인 경우
            List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
            List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);

            model.addAttribute("groupList", groupList);
            model.addAttribute("inChargeList", inChargeList);

        } else if(grpLv != null && grpLv.equals("2")) {
            // 담당자인 경우
            // 딱히? 넣어줄게 없겠지 ㅇㅇ
            // 일단은 영역만 넣어둠
        }

        return "tracking/healthAlerts";
    }

    @ResponseBody
    @RequestMapping(value = "/selectUserRequest", method = RequestMethod.POST)
    public Map<String, Object> selectUserRequest(@ModelAttribute UserRequestVO userRequestVO) {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<UserRequestVO> resultList;

        try {
            userRequestVO.setSortColumn(userRequestVO.getSidx());
            userRequestVO.setPageIndex(Integer.parseInt(userRequestVO.getPage()) -1);
            userRequestVO.setRowNo(userRequestVO.getPageIndex() * userRequestVO.getRows());

            resultList = trackingService.selectUserRequest(userRequestVO);
            int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();
            map.put("page", userRequestVO.getPageIndex() + 1);
            map.put("records", records);
            map.put("total", records == 0 ? 1 : Math.ceil(records / (double) userRequestVO.getRows()));
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
    @RequestMapping(value = "/selectHealthAlert", method = RequestMethod.POST)
    public Map<String, Object> selectHealthAlert(@ModelAttribute HealthAlertVO healthAlertVO) {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<HealthAlertVO> resultList;

        try {
            healthAlertVO.setSortColumn(healthAlertVO.getSidx());
            healthAlertVO.setPageIndex(Integer.parseInt(healthAlertVO.getPage()) -1);
            healthAlertVO.setRowNo(healthAlertVO.getPageIndex() * healthAlertVO.getRows());

            resultList = trackingService.selectHealthAlert(healthAlertVO);

            int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();
            map.put("page", healthAlertVO.getPageIndex() + 1);
            map.put("records", records);
            map.put("total", records == 0 ? 1 : Math.ceil(records / (double) healthAlertVO.getRows()));
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
}
