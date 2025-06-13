package com.moadata.bdms.checkup.service;

import com.moadata.bdms.admin.service.AdminService;
import com.moadata.bdms.checkup.repository.CheckupDao;
import com.moadata.bdms.checkup.service.CheckupService;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.dto.UserSearchDTO;
import com.moadata.bdms.model.vo.CheckupVO;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.*;

@Service(value = "checkupService")
public class CheckupServiceImpl implements CheckupService {

    @Resource(name="checkupDao")
    private CheckupDao checkupDao;

    @Override
    public List<CheckupVO> selectCheckupList(CheckupVO checkupVO) {
        return checkupDao.selectCheckupList(checkupVO);
    }

    @Override
    public Map<String, Object> getImportMapForBDMSMulti(MultipartFile file, String loginId){

        Map<String, Object> map = new HashMap<>();
        boolean isError = false;
        String errorMessage = null;

        List<CheckupVO> csvList = new ArrayList<CheckupVO>();
        try {
            File nFile = new File(file.getOriginalFilename());
            nFile.createNewFile();
            FileOutputStream fos = new FileOutputStream(nFile);
            fos.write(file.getBytes());
            fos.close();

            BufferedReader br = new BufferedReader(new FileReader(nFile));
            String line;
            while ((line = br.readLine())!= null) {
                if (line.contains("User ID")) {continue;}
                StringTokenizer st = new StringTokenizer(line, ",");
                String[] tValue;
                tValue = new String[st.countTokens()];

                int i = 0;
                while (st.hasMoreTokens()) {
                    String temp = st.nextToken();
                    tValue[i] = temp;
                    i++;
                }
                CheckupVO cvo = new CheckupVO();
                for (int j = 0; j < tValue.length; j++) {
                    if (j == 0) {cvo.setUserId(tValue[j]);
                        String userNm = checkupDao.selectUserName(tValue[j]);
                        cvo.setUserNm(EncryptUtil.decryptText(userNm));
                    }
                    else if (j == 1) {cvo.setMct(tValue[j]);}
                    else if (j == 2) {cvo.setCr(tValue[j]);}
                    else if (j == 3) {cvo.setCc(tValue[j]);}
                    else if (j == 4) {cvo.setChckDctr(tValue[j]);}
                    else if (j == 5) {cvo.setChckDt(tValue[j]);}
                    else if (j == 6) {cvo.setBrthDt(tValue[j]);} //{cvo.setBrthDt(tValue[j].substring(5)); cvo.setBrthYear(tValue[j].substring(0,4));}
                    else if (j == 7) {cvo.setGender(tValue[j]);}
                    else if (j == 8) {cvo.setHght(tValue[j]);}
                    else if (j == 9) {cvo.setWght(tValue[j]);}
                    else if (j == 10) {cvo.setWst(tValue[j]);}
                    else if (j == 11) {cvo.setSbp(tValue[j]);}
                    else if (j == 12) {cvo.setDbp(tValue[j]);}
                    else if (j == 13) {cvo.setFbs(tValue[j]);}
                    else if (j == 14) {cvo.setHba1c(tValue[j]);}
                    else if (j == 15) {cvo.setTc(tValue[j]);}
                    else if (j == 16) {cvo.setHdl(tValue[j]);}
                    else if (j == 17) {cvo.setLdl(tValue[j]);}
                    else if (j == 18) {cvo.setTrgly(tValue[j]);}
                    else if (j == 19) {cvo.setSc(tValue[j]);}
                    else if (j == 20) {cvo.setGfr(tValue[j]);}
                    else if (j == 21) {cvo.setUrAcd(tValue[j]);}
                    else if (j == 22) {cvo.setBun(tValue[j]);}
                    else if (j == 23) {cvo.setAlt(tValue[j]);}
                    else if (j == 24) {cvo.setAst(tValue[j]);}
                    else if (j == 25) {cvo.setGtp(tValue[j]);}
                    else if (j == 26) {cvo.setTprtn(tValue[j]);}
                    else if (j == 27) {cvo.setBlrbn(tValue[j]);}
                    else if (j == 28) {cvo.setAlp(tValue[j]);}
                    else if (j == 29) {cvo.setComment(tValue[j]);}
                    cvo.setValid("failed");
                }
                csvList.add(cvo);
            }
            map.put("isError", isError);
            map.put("resultList", csvList);
            map.put("errorMessage", errorMessage);
            return map;
        }catch(Exception e) {
            e.printStackTrace();
            isError = true;
            map.put("isError", isError);
            map.put("resultList", null);
            map.put("errorMessage", "Excel Import failed。");
            return map;
        }
    }

    public boolean insertCheckupDataList(CheckupVO checkupVO){
        return checkupDao.insertCheckupDataList(checkupVO);
    }
}