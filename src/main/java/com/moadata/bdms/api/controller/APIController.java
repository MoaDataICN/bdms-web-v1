package com.moadata.bdms.api.controller;

import com.moadata.bdms.common.elasticsearch.service.ESService;
import com.moadata.bdms.model.vo.AttachmentVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/api")
public class APIController {

    private static final Logger LOGGER = LoggerFactory.getLogger(APIController.class);

    @Resource(name = "esService")
    private ESService esService;

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
}
