package com.moadata.bdms.workforce.controller;

import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.model.vo.WorkforceVO;
import com.moadata.bdms.workforce.service.WorkforceService;
import com.sun.corba.se.spi.orbutil.threadpool.Work;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/workforce")
public class WorkforceController {

    @Resource(name = "groupService")
    private GroupService groupService;

    @Resource(name = "workforceService")
    private WorkforceService workforceService;

    @GetMapping("/search")
    public String workforceSearch(ModelMap model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        UserVO user = (UserVO) session.getAttribute("user");

        String grpId = user.getGrpId();
        String grpLv = user.getGrpLv();

        if(grpLv != null && grpLv.equals("1")) {
            // 최상위 관리자인 경우
            List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
            List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);

            model.addAttribute("groupList", groupList);
            model.addAttribute("inChargeList", inChargeList);
        }

        return "workforce/search";
    }

    @GetMapping("/edit")
    public String workforceEdit(ModelMap model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        UserVO user = (UserVO) session.getAttribute("user");

        String grpId = user.getGrpId();
        String grpLv = user.getGrpLv();

        if(grpLv != null && grpLv.equals("1")) {
            // 최상위 관리자인 경우
            List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
            List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);

            model.addAttribute("groupList", groupList);
            model.addAttribute("inChargeList", inChargeList);
        }

        return "workforce/edit";
    }

    @PostMapping("/save")
    public @ResponseBody Map<String, Object> save(@ModelAttribute WorkforceVO workforceVO) {
        Map<String, Object> result = new HashMap<>();
        boolean isError = false;
        String message = "";
        try {
            workforceService.insertWorkforce(workforceVO);
        } catch(Exception e) {
            isError = true;
            message = e.getMessage();
        }

        result.put("isError", isError);
        result.put("message", message);

        return result;
    }

    @PostMapping("/update")
    public @ResponseBody Map<String, Object> update(@ModelAttribute WorkforceVO workforceVO) {
        Map<String, Object> result = new HashMap<>();
        boolean isError = false;
        String message = "";
        try {
            workforceService.updateWorkforce(workforceVO);
        } catch(Exception e) {
            isError = true;
            message = e.getMessage();
        }

        result.put("isError", isError);
        result.put("message", message);

        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/selectWorkforceList", method = RequestMethod.POST)
    public Map<String, Object> selectWorkforceList(@ModelAttribute WorkforceVO workforceVO) {
        Map<String, Object> map = new HashMap<>();
        boolean isError = false;
        String message = "";
        List<WorkforceVO> resultList;

        try {
            workforceVO.setSortColumn(workforceVO.getSidx());
            workforceVO.setPageIndex(Integer.parseInt(workforceVO.getPage()) -1);
            workforceVO.setRowNo(workforceVO.getPageIndex() * workforceVO.getRows());

            resultList = workforceService.selectWorkforceList(workforceVO);
            int records = resultList.size() == 0 ? 0 : resultList.get(0).getCnt();
            map.put("page", workforceVO.getPageIndex() + 1);
            map.put("records", records);
            map.put("total", records == 0 ? 1 : Math.ceil(records / (double) workforceVO.getRows()));
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
    @RequestMapping(value = "/selectWorkforceDetail", method = RequestMethod.POST)
    public Map<String, Object> selectWorkforceDetail(@RequestBody String wrkfrcId) {
        Map<String, Object> map = new HashMap<>();
        boolean isError = false;
        String message = "";

        try {
            map.put("workforce", workforceService.selectWorkforceById(wrkfrcId));
        } catch(Exception e ){
            e.printStackTrace();
            isError = true;
            message = e.getMessage();
        }

        map.put("isError", isError);
        map.put("message", message);

        return map;
    }
}
