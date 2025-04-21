package com.moadata.bdms.announcement.controller;

import com.moadata.bdms.announcement.service.AnnouncementService;
import com.moadata.bdms.model.vo.AnnouncementVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/announcement")
public class AnnouncementController {

    @Resource(name="announcementService")
    private AnnouncementService announcementService;

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
    public Map<String, Object> selectUserMessage(String userId) {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<AnnouncementVO> resultList;

        try {
            resultList = announcementService.selectUserMessage(userId);
            map.put("messageList", resultList);
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
