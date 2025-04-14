package com.moadata.bdms.dashboard.controller;

import com.moadata.bdms.common.elasticsearch.service.ESService;
import com.moadata.bdms.dashboard.service.DashboardService;
import com.moadata.bdms.group.service.GroupService;
import com.moadata.bdms.model.vo.GroupVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.tracking.service.TrackingService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Resource(name="esService")
    private ESService esService;

    @Resource(name="trackingService")
    private TrackingService trackingService;

    @Resource(name="dashboardService")
    private DashboardService dashboardService;

    @Resource(name="groupService")
    private GroupService groupService;

    @GetMapping("/main")
    public String dashboardMain(Model model, HttpServletRequest request) {

        /*
            해당 사용자가 상위 관리자인 경우, GRP_ID를 넣고
            고객과 바로 이어지는 관리자인 경우, IN_CHARGE_ID 를 넣음
            그에 대한 구분은 로그인 시, 사용자의 GRP_ID를 바탕으로 GRP 테이블을 조회, RANK를 기재해 둔다.
        */

        HttpSession session = request.getSession(false);
        UserVO user = (UserVO) session.getAttribute("user");

        String grpId = user.getGrpId();
        String grpLv = user.getGrpLv();
        String userId = user.getUserId();

        Map<String, Object> param = new HashMap<>();
        if(grpLv != null && grpLv.equals("1")) {
            // 상위 관리자인 경우
            param.put("grpId", grpId);

            List<GroupVO> groupList = groupService.selectLowLevelGroups(grpId);
            List<UserVO> inChargeList = groupService.selectLowLevelAdmins(grpId);

            model.addAttribute("groupList", groupList);
            model.addAttribute("inChargeList", inChargeList);
        } else {
            // 일반 담당자인 경우
            param.put("inChargeId", userId);

            model.addAttribute("inChargeId", userId);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar c1 = Calendar.getInstance();
        String today = sdf.format(c1.getTime());

        //param.put("inChargeId", inChargeId);    // 일반 담당자인 경우의 테스트
        param.put("today", today);

        /** Alert & Request Count S */
        List<Map<String, Object>> healthAlertCntList = trackingService.selectTodayHealthAlertCnt(param);
        List<Map<String, Object>> userRequestCntList = trackingService.selectTodayUserRequestCnt(param);

        Map<String, Map<String, Long>> userRequestCntMap = new HashMap<>();
        for(Map<String, Object> row : userRequestCntList) {
            String reqTp = (String)row.get("REQ_TP");
            String reqStt = (String)row.get("REQ_STT");
            Long reqCount = (Long)row.get("REQ_COUNT");

            userRequestCntMap.putIfAbsent(reqTp, new HashMap<String, Long>());
            userRequestCntMap.get(reqTp).put(reqStt, reqCount);
        }

        Map<String, Map<String, Long>> healthAlertCntMap = new HashMap<>();
        for(Map<String, Object> row : healthAlertCntList) {
            String altTp = (String)row.get("ALT_TP");
            String altStt = (String)row.get("ALT_STT");
            Long altCount = (Long)row.get("ALT_COUNT");

            healthAlertCntMap.putIfAbsent(altTp, new HashMap<String, Long>());
            healthAlertCntMap.get(altTp).put(altStt, altCount);
        }
        /** Alert & Request Count E */

        // Client & In Charge Status
        model.addAttribute("statusList", dashboardService.selectTodayStatus(param));

        model.addAttribute("healthAlertCntMap", healthAlertCntMap);
        model.addAttribute("userRequestCntMap", userRequestCntMap);

        return "dashboard/main";
    }
}
