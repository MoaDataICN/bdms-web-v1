package com.moadata.bdms.statistic.service;

import com.moadata.bdms.model.vo.StatisticVO;
import com.moadata.bdms.statistic.repository.StatisticDao;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Statistic Service 구현
 */
@Service(value = "statisticService")
public class StatisticServiceImpl implements StatisticService {

	@Resource(name="statisticDao")
	private StatisticDao statisticDao;

	@Override
	public String selectTotalUserAmount(Map<String, Object> param) {
		return statisticDao.selectTotalUserAmount(param);
	}

	@Override
	public List<StatisticVO> selectUserAmountSummary(Map<String, Object> param) {
		return statisticDao.selectUserAmountSummary(param);
	}

	@Override
	public List<StatisticVO> selectServiceRequestSummary(Map<String, Object> param) {
		return statisticDao.selectServiceRequestSummary(param);
	}

	@Override
	public List<StatisticVO> selectHealthAlertSummary(Map<String, Object> param) {
		return statisticDao.selectHealthAlertSummary(param);
	}

	@Override
	public ByteArrayOutputStream generateExcel(Map<String, Object> param) {
		try {
			List<StatisticVO> rawData = new ArrayList<>();
			String type = (String)param.get("type");

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String startDt = param.get("startDt").toString().substring(0, 10);
			String endDt = param.get("endDt").toString().substring(0, 10);
			LocalDate startDtDate = LocalDate.parse(startDt, formatter);
			LocalDate endDtDate = LocalDate.parse(endDt, formatter);

			param.put("startDt", startDtDate.atStartOfDay().toString());
			param.put("endDt", endDtDate.plusDays(1).atStartOfDay().toString());
			if(type.equals("userAmount")) {
				rawData = statisticDao.selectUserAmountSummary(param);
			} else if(type.equals("serviceRequest")) {
				rawData = statisticDao.selectServiceRequestSummary(param);
			} else if(type.equals("healthAlert")) {
				rawData = statisticDao.selectHealthAlertSummary(param);
			}

			if(rawData.size() > 0) {
				Map<String, StatisticVO> summaryMap = new HashMap<>();
				for (StatisticVO rs : rawData) {
					summaryMap.put(rs.getTimestamp(), rs);
				}

				List<String> allTimestamps = new ArrayList<>();
				for (LocalDateTime dt = startDtDate.atStartOfDay(); dt.isBefore(endDtDate.plusDays(1).atStartOfDay()); dt = dt.plusSeconds(1)) {
					allTimestamps.add(dt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
				}

				Workbook wb = new SXSSFWorkbook();

				Sheet sheet = wb.createSheet((String)param.get("type"));
				String[] headers = {};

				if(type.equals("userAmount")) {
					headers = new String[]{"date", "total user amount", "user in/out"};
				} else if(type.equals("serviceRequest")) {
					headers = new String[]{"date", "total requests amount", "nursing total", "nursing",
							"ambulance total", "ambulance", "consultation total", "consultation"};
				} else if(type.equals("healthAlert")) {
					headers = new String[]{"date", "total alert amount", "activity total", "activity",
							"falls total", "falls", "heart rate total", "heart rate", "sleep total", "sleep",
							"blood oxygen total", "blood oxygen", "temperature total", "temperature", "stress total", "stress"};
				}

				Row headerRow = sheet.createRow(0);
				for (int i = 0; i < headers.length; i++) {
					headerRow.createCell(i).setCellValue(headers[i]);
				}

				if(type.equals("userAmount")) {

					int totalUserAmount = Integer.parseInt(this.selectTotalUserAmount(param));
					int rowNum = 1;

					List<String> allTimestamps_min = new ArrayList<>();
					DateTimeFormatter minuteFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
					for (LocalDateTime dt = startDtDate.atStartOfDay(); dt.isBefore(endDtDate.plusDays(1).atStartOfDay()); dt = dt.plusMinutes(1)) {
						allTimestamps_min.add(dt.format(minuteFormatter));
					}

					for (String ts : allTimestamps_min) {
						StatisticVO rs = summaryMap.getOrDefault(ts, new StatisticVO(ts, 0));
						totalUserAmount += rs.getInOut();

						Row row = sheet.createRow(rowNum++);
						row.createCell(0).setCellValue(ts);
						row.createCell(1).setCellValue(totalUserAmount);
						row.createCell(2).setCellValue(rs.getInOut());
					}

				} else if(type.equals("serviceRequest")) {
					int totalNursing = 0, totalAmbulance = 0, totalConsultation = 0;
					int rowNum = 1;
					for (String ts : allTimestamps) {
						StatisticVO rs = summaryMap.getOrDefault(ts, new StatisticVO(ts, 0, 0, 0));
						totalNursing += rs.getNursing();
						totalAmbulance += rs.getAmbulance();
						totalConsultation += rs.getConsultation();
						int total = totalNursing + totalAmbulance + totalConsultation;

						Row row = sheet.createRow(rowNum++);

						row.createCell(0).setCellValue(ts);
						row.createCell(1).setCellValue(total);
						row.createCell(2).setCellValue(totalNursing);
						row.createCell(3).setCellValue(rs.getNursing());
						row.createCell(4).setCellValue(totalAmbulance);
						row.createCell(5).setCellValue(rs.getAmbulance());
						row.createCell(6).setCellValue(totalConsultation);
						row.createCell(7).setCellValue(rs.getConsultation());
					}
				} else if(type.equals("healthAlert")) {
					int totalActivity = 0, totalFalls = 0, totalHeartRate = 0, totalSleep = 0, totalBloodOxygen = 0, totalTemperature = 0, totalStress = 0;
					int rowNum = 1;
					for (String ts : allTimestamps) {
						StatisticVO rs = summaryMap.getOrDefault(ts, new StatisticVO(ts, 0, 0, 0, 0, 0,0 , 0));
						totalActivity += rs.getActivity();
						totalFalls += rs.getFalls();
						totalHeartRate += rs.getHeartRate();
						totalSleep += rs.getSleep();
						totalBloodOxygen += rs.getBloodOxygen();
						totalTemperature += rs.getTemperature();
						totalStress += rs.getStress();

						int total = totalActivity + totalFalls + totalHeartRate + totalSleep + totalBloodOxygen + totalTemperature + totalStress;

						Row row = sheet.createRow(rowNum++);

						row.createCell(0).setCellValue(ts);
						row.createCell(1).setCellValue(total);
						row.createCell(2).setCellValue(totalActivity);
						row.createCell(3).setCellValue(rs.getActivity());
						row.createCell(4).setCellValue(totalFalls);
						row.createCell(5).setCellValue(rs.getFalls());
						row.createCell(6).setCellValue(totalHeartRate);
						row.createCell(7).setCellValue(rs.getHeartRate());
						row.createCell(8).setCellValue(totalSleep);
						row.createCell(9).setCellValue(rs.getSleep());
						row.createCell(10).setCellValue(totalBloodOxygen);
						row.createCell(11).setCellValue(rs.getBloodOxygen());
						row.createCell(12).setCellValue(totalTemperature);
						row.createCell(13).setCellValue(rs.getTemperature());
						row.createCell(14).setCellValue(totalStress);
						row.createCell(15).setCellValue(rs.getStress());
					}
				}

				ByteArrayOutputStream out = new ByteArrayOutputStream();
				wb.write(out);
				wb.close();
				return out;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

		return null;
	}
}
