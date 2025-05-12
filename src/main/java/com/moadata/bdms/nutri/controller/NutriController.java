package com.moadata.bdms.nutri.controller;

import com.moadata.bdms.model.vo.NutriVO;
import com.moadata.bdms.nutri.service.NutriService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

@Controller
public class NutriController {

	@Resource(name="nutriService")
	private NutriService nutriService;

	@ResponseBody
	@RequestMapping(value="/api/updateNutriAge", method = RequestMethod.POST)
	public Map<String, Object> updateNutriAge(@RequestBody String userId) {
		Map<String, Object> map = new HashMap<>();
		boolean isError = false;
		String message = "";

		try {
			NutriVO nutri = new NutriVO();
			nutri.setUserId(userId);
			nutriService.insertNutriAnly(userId);
		} catch(Exception e) {
			isError = true;
			message = e.getMessage();
		}
		map.put("isError", isError);
		map.put("message", message);

		return map;
	}
}
