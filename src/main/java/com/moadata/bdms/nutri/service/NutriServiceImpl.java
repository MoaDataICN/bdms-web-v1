package com.moadata.bdms.nutri.service;

import com.moadata.bdms.model.vo.NutriVO;
import com.moadata.bdms.my.repository.MyDao;
import com.moadata.bdms.nutri.repository.NutriDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.util.Random;

@Service("nutriService")
public class NutriServiceImpl implements NutriService{

	@Resource(name="nutriDao")
	private NutriDao nutriDao;

	@Resource(name="myDao")
	private MyDao myDao;

	@Override
	public void insertNutriAnly(String userId) {

		NutriVO nutri = new NutriVO();
		nutri.setUserId(userId);
		nutri.setBadVal(getRandomDecimalString());
		nutri.setBaaVal(getRandomDecimalString());
		nutri.setCaaVal(getRandomDecimalString());
		nutri.setPaaVal(getRandomDecimalString());
		nutri.setReaVal(getRandomDecimalString());
		nutri.setHeaVal(getRandomDecimalString());

		nutriDao.insertNutriAnly(nutri);
		myDao.updateCheckupKey(userId);
	}

	public static String getRandomDecimalString() {
		Random rand = new Random();
		double randomValue = -10 + (10 - (-10)) * rand.nextDouble(); // min 이상 max 미만
		DecimalFormat df = new DecimalFormat("0.00"); // 소수점 둘째 자리까지 포맷
		return df.format(randomValue);
	}
}
