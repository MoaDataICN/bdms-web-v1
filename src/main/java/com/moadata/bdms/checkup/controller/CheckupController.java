package com.moadata.bdms.checkup.controller;

import com.moadata.bdms.common.base.controller.BaseController;
import com.moadata.bdms.checkup.service.CheckupService;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.vo.CheckupVO;
import com.moadata.bdms.model.vo.UserVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.common.util.StringUtil;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * Checkup
 */
@Controller
@RequestMapping(value = "/checkup")
public class CheckupController extends BaseController {

    @Resource(name = "checkupService")
    private CheckupService checkupService;

    @Value("${file.save.dir.linux}")
    private String linuxPreOpenFilePath;

    @Value("${file.save.dir.windows}")
    private String windowPreOpenFilePath;

    @RequestMapping(value = "/management", method = RequestMethod.GET)
    public String management(HttpServletRequest request, ModelMap model) {

        return "checkup/management";
    }

    /**
     * Check Up Excel Import
     *
     * @param request
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping(value = "/getChckUpExcelImportMulti", method = RequestMethod.POST)
    public  Map<String, Object> getChckUpExcelImportMulti(MultipartHttpServletRequest request) throws Exception {
        Map<String, Object> map = new HashMap<>();
        MultipartFile mf = request.getFile("file[0]");
        UserVO vo = (UserVO) getRequestAttribute("user");
        map = checkupService.getImportMapForBDMSMulti(mf, vo.getUserId());
        return map;
    }

    @ResponseBody
    @RequestMapping(value = "/selectNoneCheckupList", method = RequestMethod.POST)
    public Map<String, Object> selectNoneCheckupList() {
        Map<String, Object> map = new HashMap<>();

        String message = "";
        boolean isError = false;
        List<CheckupVO> resultList = new ArrayList<CheckupVO>();

        try {
            map.put("rows", resultList);
        } catch (Exception e) {
            e.printStackTrace();
            isError = true;
            message = e.getMessage();
        }
        map.put("isError", isError);
        map.put("message", message);

        return map;
    }

    /**
     * downform Data Make
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/downform", produces="application/json;charset=UTF-8")
    public void downform(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String os = System.getProperty("os.name").toLowerCase();
            String path = "";

            System.out.println("###################################");
            System.out.println("###################### downform OS : " + os);
            System.out.println("###################################");

            if (os.contains("window")) {
                path = windowPreOpenFilePath;
            }else{
                path = linuxPreOpenFilePath;
            }

            File dFile = new File(path, "twalk_MultiDownData.csv");
            int fSize = (int)dFile.length();

            if (fSize > 0) {
                String encodedFilename = URLEncoder.encode("twalk_MultiDownData.csv", "UTF-8");
                response.setContentType("text/csv; charset=utf-8");
                response.setHeader("filename", encodedFilename);
                response.setContentLength(fSize);

                BufferedInputStream in = null;
                BufferedOutputStream out = null;

                in  = new BufferedInputStream(new FileInputStream(dFile));
                out = new BufferedOutputStream(response.getOutputStream());

                try {
                    byte[] buffer = new byte[4096];
                    int bytesRead = 0;

                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    out.flush();
                } finally {
                    in.close();
                    out.close();
                }
            } else {
                throw new FileNotFoundException("There is no file.");
            }
        } catch (Exception e) {
            LOGGER.info(e.getMessage());
        }
    }

    /**
     * 저장
     *
     * @param checkupVO
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/checkupSave", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> checkupSave(@ModelAttribute("checkupVO") CheckupVO checkupVO)
            throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();

        boolean isError = false;
        String message = "";

        try {
            List<Map> tempList = checkupVO.getParamList();
            if(tempList.size() > 0) {
                UserVO vo = (UserVO) getRequestAttribute("user");
                for(int i=0; i< tempList.size(); i ++) {
                    tempList.get(i).put("adminId", vo.getUserId());
                }
                checkupVO.setParamList(tempList);
            }
            checkupService.insertCheckupDataList(checkupVO);
            message = "The data has been saved.";

        } catch (Exception e) {
            LOGGER.error(e.toString());
            isError = true;
            map.put("message", e.getMessage());
        }

        map.put("isError", isError);
        map.put("message", message);
        return map;
    }
}