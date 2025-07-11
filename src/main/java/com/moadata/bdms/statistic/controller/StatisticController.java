package com.moadata.bdms.statistic.controller;

import com.moadata.bdms.my.service.MyService;
import com.moadata.bdms.statistic.service.StatisticServiceImpl;
import com.moadata.bdms.tracking.service.TrackingService;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/statistic")
public class StatisticController {

	@Resource(name="myService")
	private MyService myService;

	@Resource(name="trackingService")
	private TrackingService trackingService;

	@Resource(name="statisticService")
	private StatisticServiceImpl statisticService;

	@GetMapping("/branchStatistic")
    public String branchStatistic(ModelMap model) {

		model.addAttribute("userCntMap", myService.selectUserCntGrp());

        return "statistic/branchStatistic";
    }

	@GetMapping("/user")
	public String user(){
		return "statistic/userStatistic";
	}

	@ResponseBody
	@RequestMapping(value = "/selectUserCnt", method = RequestMethod.POST)
	public Map<String, Object> selectUserCnt(@RequestBody Map<String, Object> param) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;

		try {
			map.put("resultList",myService.selectUserCnt(param));
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@GetMapping("/healthAlert")
	public String healthAlert(){
		return "statistic/healthAlertStatistic";
	}

	@ResponseBody
	@RequestMapping(value = "/selectHealthAlertCnt", method = RequestMethod.POST)
	public Map<String, Object> selectHealthAlertCnt(@RequestBody Map<String, Object> param) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;

		try {
			map.put("resultList",trackingService.selectHealthAlertsAmount(param));
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@GetMapping("/serviceRequest")
	public String serviceRequest(){
		return "statistic/serviceRequestStatistic";
	}

	@ResponseBody
	@RequestMapping(value = "/selectServiceRequestCnt", method = RequestMethod.POST)
	public Map<String, Object> selectServiceRequestCnt(@RequestBody Map<String, Object> param) {
		Map<String, Object> map = new HashMap<>();

		String message = "";
		boolean isError = false;

		try {
			map.put("resultList",trackingService.selectUserRequestsAmount(param));
		} catch(Exception e) {
			e.printStackTrace();
			isError = true;
			message = e.getMessage();
		}

		map.put("isError", isError);
		map.put("message", message);

		return map;
	}

	@ResponseBody
	@PostMapping("/exportStatisticExcel")
	public ResponseEntity<byte[]> exportSummary(@RequestBody Map<String, Object> param) throws IOException {

		ByteArrayOutputStream excelFile = statisticService.generateExcel(param);

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDisposition(ContentDisposition.attachment()
				.filename("summary.xlsx").build());

		return new ResponseEntity<>(excelFile.toByteArray(), headers, HttpStatus.OK);
	}
}
