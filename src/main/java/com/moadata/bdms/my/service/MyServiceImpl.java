package com.moadata.bdms.my.service;

import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.vo.MyVO;
import com.moadata.bdms.my.repository.MyDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service("myService")
public class MyServiceImpl implements MyService {

    @Resource(name="myDao")
    private MyDao myDao;

    @Override
    public MyVO selectUserInfo(String userId) {
        if (userId != null && !userId.isEmpty()) { // null 체크 및 비어있는지 확인
            try {
                MyVO user = myDao.selectUserInfo(userId); // 메서드명 수정
                if (user != null) { // null 체크로 변경
                    // user가 비어있는지 확인할 수 있는 메서드가 없으면 삭제
                    user.setBrthDt(EncryptUtil.decryptText(user.getBrthDt()));
                    user.setUserNm(EncryptUtil.decryptText(user.getUserNm()));
                    user.setMobile(EncryptUtil.decryptText(user.getMobile()));
                    return user;
                }
            } catch (ProcessException e) {
                // e.printStackTrace();
            }
        }
        return null;
    }

	@Override
	public List<Map<String, Object>> selectUserCnt(Map<String, Object> param) {
		return myDao.selectUserCnt(param);
	}

	@Override
	public Map<String, Object> selectUserCntGrp() {
		return myDao.selectUserCntGrp();
	}

	@Override
	public void updateCheckupKey(String userId) {
		myDao.updateCheckupKey(userId);
	}
}
