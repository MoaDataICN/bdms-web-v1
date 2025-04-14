package com.moadata.bdms.workforce.service;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.model.vo.WorkforceVO;
import com.moadata.bdms.workforce.repository.WorkforceDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service(value = "workforceService")
public class WorkforceServiceImpl implements WorkforceService {

    @Resource(name="workforceDao")
    private WorkforceDao workforceDao;

    @Override
    public String selectMaxWrkfrcId() {
        return workforceDao.selectMaxWrkfrcId();
    }

    @Override
    public List<WorkforceVO> selectWorkforceList(WorkforceVO workforceVO) {
        try {
            if(workforceVO.getWrkfrcMobile() != null && !workforceVO.getWrkfrcMobile().isEmpty()) {
                workforceVO.setWrkfrcMobile(EncryptUtil.encryptText(workforceVO.getWrkfrcMobile()));
            }

            if(workforceVO.getWrkfrcNm() != null && !workforceVO.getWrkfrcNm().isEmpty()) {
                workforceVO.setWrkfrcNm(EncryptUtil.encryptText(workforceVO.getWrkfrcNm()));
            }

            if(workforceVO.getWrkfrcBrthDt() != null && !workforceVO.getWrkfrcBrthDt().isEmpty()) {
                workforceVO.setWrkfrcBrthDt(EncryptUtil.encryptText(workforceVO.getWrkfrcBrthDt()));
            }

            List<WorkforceVO> list = workforceDao.selectWorkforceList(workforceVO);

            if(list.size() > 0) {
                for(WorkforceVO vo : list) {
                    vo.setWrkfrcNm(EncryptUtil.decryptText(vo.getWrkfrcNm()));
                    vo.setWrkfrcBrthDt(EncryptUtil.decryptText(vo.getWrkfrcBrthDt()));
                    vo.setWrkfrcMobile(EncryptUtil.decryptText(vo.getWrkfrcMobile()));
                }
            }
            return list;
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public void insertWorkforce(WorkforceVO workforceVO) {
        try {
            if(workforceVO.getWrkfrcNm() != null && workforceVO.getWrkfrcNm().length() > 0){
                workforceVO.setWrkfrcNm(EncryptUtil.encryptText(workforceVO.getWrkfrcNm()));
            }

            if(workforceVO.getWrkfrcMobile() != null && workforceVO.getWrkfrcMobile().length() > 0){
                workforceVO.setWrkfrcMobile(EncryptUtil.encryptText(workforceVO.getWrkfrcMobile()));
            }

            if(workforceVO.getWrkfrcBrthDt() != null && workforceVO.getWrkfrcBrthDt().length() > 0){
                workforceVO.setWrkfrcBrthDt(EncryptUtil.encryptText(workforceVO.getWrkfrcBrthDt()));
            }

            workforceVO.setWrkfrcId(selectMaxWrkfrcId());

            workforceDao.insertWorkforce(workforceVO);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public WorkforceVO selectWorkforceById(String wrkfrcId) {
        WorkforceVO workforce = workforceDao.selectWorkforceById(wrkfrcId);

        try {
            workforce.setWrkfrcNm(EncryptUtil.decryptText(workforce.getWrkfrcNm()));
            workforce.setWrkfrcMobile(EncryptUtil.decryptText(workforce.getWrkfrcMobile()));
            workforce.setWrkfrcBrthDt(EncryptUtil.decryptText(workforce.getWrkfrcBrthDt()));
        } catch(Exception e) {
            e.printStackTrace();
        }

        return workforce;
    }

    @Override
    public void updateWorkforce(WorkforceVO workforceVO) {
        try {
            if(workforceVO.getWrkfrcNm() != null && workforceVO.getWrkfrcNm().length() > 0){
                workforceVO.setWrkfrcNm(EncryptUtil.encryptText(workforceVO.getWrkfrcNm()));
            }

            if(workforceVO.getWrkfrcMobile() != null && workforceVO.getWrkfrcMobile().length() > 0){
                workforceVO.setWrkfrcMobile(EncryptUtil.encryptText(workforceVO.getWrkfrcMobile()));
            }

            if(workforceVO.getWrkfrcBrthDt() != null && workforceVO.getWrkfrcBrthDt().length() > 0){
                workforceVO.setWrkfrcBrthDt(EncryptUtil.encryptText(workforceVO.getWrkfrcBrthDt()));
            }

            workforceDao.updateWorkforce(workforceVO);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
