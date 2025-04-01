package com.moadata.bdms.tracking.service;

import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.vo.HealthAlertVO;
import com.moadata.bdms.model.vo.UserRequestVO;
import com.moadata.bdms.tracking.repository.TrackingDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Tracking Service 구현
 */
@Service(value = "trackingService")
public class TrackingServiceImpl implements TrackingService {
	@Resource(name="trackingDao")
	private TrackingDao trackingDao;

	public List<UserRequestVO> selectUserRequest(UserRequestVO userRequestVO) {
		try {
			if(userRequestVO.getMobile() != null && !userRequestVO.getMobile().isEmpty()) {
				userRequestVO.setMobile(EncryptUtil.encryptText(userRequestVO.getMobile()));
			}

			if(userRequestVO.getBrthDt() != null && !userRequestVO.getBrthDt().isEmpty()) {
				userRequestVO.setBrthDt(EncryptUtil.encryptText(userRequestVO.getBrthDt()));
			}

			if(userRequestVO.getUserNm() != null && !userRequestVO.getUserNm().isEmpty()) {
				userRequestVO.setUserNm(EncryptUtil.encryptText(userRequestVO.getUserNm()));
			}

			if(userRequestVO.getInChargeNm() != null && !userRequestVO.getInChargeNm().isEmpty()) {
				userRequestVO.setInChargeNm(EncryptUtil.encryptText(userRequestVO.getInChargeNm()));
			}

			List<UserRequestVO> userRequestList = trackingDao.selectUserRequest(userRequestVO);

			if(userRequestList.size() > 0) {
				for(UserRequestVO userRequest : userRequestList) {
					userRequest.setUserNm(EncryptUtil.decryptText(userRequest.getUserNm()));
					userRequest.setBrthDt(EncryptUtil.decryptText(userRequest.getBrthDt()));
					userRequest.setMobile(EncryptUtil.decryptText(userRequest.getMobile()));
					userRequest.setInChargeNm(EncryptUtil.decryptText(userRequest.getInChargeNm()));
				}
			}

			return userRequestList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<HealthAlertVO> selectHealthAlert(HealthAlertVO healthAlertVO) {
		try {
			if(healthAlertVO.getMobile() != null && !healthAlertVO.getMobile().isEmpty()) {
				healthAlertVO.setMobile(EncryptUtil.encryptText(healthAlertVO.getMobile()));
			}

			if(healthAlertVO.getBrthDt() != null && !healthAlertVO.getBrthDt().isEmpty()) {
				healthAlertVO.setBrthDt(EncryptUtil.encryptText(healthAlertVO.getBrthDt()));
			}

			if(healthAlertVO.getUserNm() != null && !healthAlertVO.getUserNm().isEmpty()) {
				healthAlertVO.setUserNm(EncryptUtil.encryptText(healthAlertVO.getUserNm()));
			}

			if(healthAlertVO.getInChargeNm() != null && !healthAlertVO.getInChargeNm().isEmpty()) {
				healthAlertVO.setInChargeNm(EncryptUtil.encryptText(healthAlertVO.getInChargeNm()));
			}

			List<HealthAlertVO> healthAlertList = trackingDao.selectHealthAlert(healthAlertVO);

			if(healthAlertList.size() > 0) {
				for(HealthAlertVO healthAlert : healthAlertList) {
					healthAlert.setUserNm(EncryptUtil.decryptText(healthAlert.getUserNm()));
					healthAlert.setBrthDt(EncryptUtil.decryptText(healthAlert.getBrthDt()));
					healthAlert.setMobile(EncryptUtil.decryptText(healthAlert.getMobile()));
					healthAlert.setInChargeNm(EncryptUtil.decryptText(healthAlert.getInChargeNm()));
				}
			}

			return healthAlertList;
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public List<Map<String, Object>> selectTodayHealthAlertCnt(Map<String, Object> param) {
		return trackingDao.selectTodayHealthAlertCnt(param);
	}

	public List<Map<String, Object>> selectTodayUserRequestCnt(Map<String, Object> param) {
		return trackingDao.selectTodayUserRequestCnt(param);
	}
}
