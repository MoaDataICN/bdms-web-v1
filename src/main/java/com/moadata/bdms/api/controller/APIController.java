package com.moadata.bdms.api.controller;

import com.moadata.bdms.admin.service.AdminService;
import com.moadata.bdms.common.elasticsearch.service.ESService;
import com.moadata.bdms.model.vo.AttachmentVO;
import com.moadata.bdms.model.vo.MyVO;
import com.moadata.bdms.model.vo.UserVO;
import com.moadata.bdms.my.service.MyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class APIController {

    private static final Logger LOGGER = LoggerFactory.getLogger(APIController.class);

    @Resource(name = "esService")
    private ESService esService;

    @Resource(name = "adminService")
    private AdminService adminService;

    @Resource(name = "myService")
    private MyService myService;

    @RequestMapping("/image")
    public @ResponseBody byte[] selectImage(String attchId, HttpServletResponse response) {
        AttachmentVO attach = esService.getAttachImages(attchId);
        String binaryImage = attach.getBinaryImage();

        byte[] decodeBase64 = null;
        if(binaryImage != null) {

            decodeBase64 = java.util.Base64.getDecoder().decode(binaryImage);
        }

        return decodeBase64;
    }

    @ResponseBody
    @RequestMapping(value="/getNamesByIds", method = RequestMethod.POST)
    public Map<String, Object> getNamesByIds(@RequestBody Map<String, Object> param) {
        Map<String, Object> map = new HashMap<>();
        boolean isError = false;
        String message = "";

        try {
            List<String> adminList = (List)param.get("adminList");
            List<String> userList = (List)param.get("userList");

            List<UserVO> adminInfoList = new ArrayList<>();
            List<MyVO> userInfoList = new ArrayList<>();

            if (adminList != null && adminList.size() > 0) {
                for(String admId : adminList) {
                    UserVO user = new UserVO();
                    user.setUserId(admId);

                    adminInfoList.add(adminService.selectAdminList(user).get(0));
                }
            }

            if(userList != null && userList.size() > 0) {
                for(String userId : userList) {
                    userInfoList.add(myService.selectUserInfo(userId));
                }
            }

            map.put("adminList", adminInfoList);
            map.put("userList", userInfoList);
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
