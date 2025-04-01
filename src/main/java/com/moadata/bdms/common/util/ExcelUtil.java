package com.moadata.bdms.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.ClientAnchor.AnchorType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.util.IOUtils;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFCreationHelper;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFPicture;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.moadata.bdms.model.vo.ExcelExportVo;


public class ExcelUtil{
	
	/**
	 * 엑셀 타이틀 세팅
	 * @param sheet
	 * @param titles: 타이틀 배열(다국어처리로 인해 label properites key 값)
	 * @return row
	 * */
	public static XSSFRow setTitleColumns(XSSFSheet sheet, String[] titles, Locale locale) throws Exception{
		int rownum = sheet.getLastRowNum()+1;
		if(sheet.getRow(sheet.getLastRowNum()) == null) {
			rownum = 0;
		}
		XSSFRow row = sheet.createRow(rownum);
		row.setHeight((short)(20*20));
		
		//셀 스타일
		Workbook wb = sheet.getWorkbook();
		CellStyle style = wb.createCellStyle();
		Font font = wb.createFont();
		
		font.setBold(true);
		font.setFontName("맑은 고딕");
		font.setFontHeightInPoints((short)11);
		font.setColor(IndexedColors.BLACK.getIndex());
		
		style.setFont(font);
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setVerticalAlignment(VerticalAlignment.CENTER);
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
		style.setBorderTop(BorderStyle.THIN);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		
		for(int i=0 ; i<titles.length ; i++) {
			row.createCell(i).setCellValue(titles[i]); //다국어 파일에서 읽기 MessageUtil.getMessage(locale, titles[i])
			row.getCell(i).setCellStyle(style);
		}
		
		style = null;
		font = null;
		wb = null;
		
		return row;
	}
	
	
	/**
	 * 엑셀 데이터 리스트 세팅 
	 * @param sheet
	 * @param list: 데이터 리스트
	 * @param dataKeys: 데이터 키 배열
	 * @param dataTypes: 데이터 타입 배열(String, Number)
	 * */
	public static void setDataColumns(XSSFSheet sheet, List<?> list, String[] dataKeys, String[] dataTypes) throws Exception{
		if(list != null && list.size() > 0 && dataKeys != null && dataKeys.length > 0) {
			XSSFRow row = null;
			
			//셀 스타일
			Workbook wb = sheet.getWorkbook();
			CellStyle style = wb.createCellStyle();
			Font font = wb.createFont();
			XSSFDataFormat format = (XSSFDataFormat) wb.createDataFormat();
			
			font.setFontName("맑은 고딕");
			font.setFontHeightInPoints((short)10);
			
			Class<?> klass = Class.forName(list.get(0).getClass().getName());  //리스트 객체의 클래스
			for(Object o: list) {
				row = sheet.createRow(sheet.getLastRowNum()+1); //행 생성
				
				for(int i=0 ; i<dataKeys.length ; i++) {
					XSSFCell cell = row.createCell(i); //셀 생성
					
					for(Method m: klass.getMethods()) {
						String methodName = "get"+dataKeys[i]; //getter
						if(methodName.toUpperCase().equals(m.getName().toUpperCase())) { //Vo에서 key값과 동일한 객체 이름이 있는경우
							
							//셀 스타일
							style = wb.createCellStyle();
							style.setFont(font);
							style.setVerticalAlignment(VerticalAlignment.CENTER);
							style.setBorderBottom(BorderStyle.THIN);
							style.setBorderLeft(BorderStyle.THIN);
							style.setBorderRight(BorderStyle.THIN);
							
							if(dataTypes != null && dataTypes.length > 0) { //셀 타입에 따라 정렬 변화
								if("String".equals(dataTypes[i])) {
									style.setAlignment(HorizontalAlignment.LEFT);
									cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
								} else if("Number".equals(dataTypes[i])) {
									style.setAlignment(HorizontalAlignment.RIGHT);
									String value = String.valueOf(m.invoke(o));
									double dValue = 0;
									try {
										dValue = Double.parseDouble(value);
										if(dValue == Math.floor(dValue)) {
											style.setDataFormat(format.getFormat("#,##0"));
										} else {
											style.setDataFormat(format.getFormat("#,##0.########"));
										}
									} catch (Exception e) {
									}
									cell.setCellValue(dValue); //셀에 값 입력
								} else {
									style.setAlignment(HorizontalAlignment.CENTER);
									cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
								}
							} else {
								style.setAlignment(HorizontalAlignment.CENTER);
								cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
							}
							
							cell.setCellStyle(style);
							cell = null;
							style = null;
							break;
						}
					}
				}
				row = null;
			}
			
			klass = null;
			font = null;
			style = null;
			wb = null;
		}
	}
	
	
	/**
	 * 엑셀 데이터 리스트 세팅, 기준키 기준으로 합산 
	 * @param ExcelExportVo
	 * */
	public static void setSumDataColumns(ExcelExportVo excelDto) throws Exception{
		Locale locale = excelDto.getLocale();
		XSSFSheet sheet = excelDto.getSheet();
		List<?> list = excelDto.getList();
		String[] dataKeys = excelDto.getDataKeys();
		String[] dataTypes = excelDto.getDataTypes();
		String[] sumTargetKeys = excelDto.getSumTargetKeys();
		String sumKey = excelDto.getSumKey();
		
		if(list != null && list.size() > 0 && dataKeys != null && dataKeys.length > 0) {
			XSSFRow row = null;
			
			//셀 스타일
			Workbook wb = sheet.getWorkbook();
			CellStyle style = wb.createCellStyle();
			Font font = wb.createFont();
			XSSFDataFormat format = (XSSFDataFormat) wb.createDataFormat();
			
			font.setFontName("맑은 고딕");
			font.setFontHeightInPoints((short)10);
			
			Class<?> klass = Class.forName(list.get(0).getClass().getName());  //리스트 객체의 클래스
			
			String tempSumKeyValue = ""; //임시 기준키 값 (이전)
			HashMap<String, Integer> tempSumMap = new HashMap<>(); //임시 합산 값 (이전)
			for(int i=0 ; i<sumTargetKeys.length ; i++){
				tempSumMap.put(sumTargetKeys[i], 0);
			}
			
			int num = 0;
			
			String sumKeyValue = null;
			HashMap<String, Integer> sumMap = new HashMap<>();
			for(Object o: list) {
				
				//현재 기준키값 보관
				for(Method m: klass.getMethods()){
					if(m.getName().toUpperCase().equals(("get"+sumKey).toUpperCase())){
						sumKeyValue = String.valueOf(m.invoke(o));
					}
				}
				
				//현재 합산키값 보관
				for(int i=0 ; i<sumTargetKeys.length ; i++){
					for(Method m: klass.getMethods()){
						String key = "get"+sumTargetKeys[i];
						if(m.getName().toUpperCase().equals(key.toUpperCase())){
							sumMap.put(sumTargetKeys[i], Integer.parseInt(String.valueOf(m.invoke(o))));
						}
					}
				}
				
				if(num==0) { //처음인 경우
					tempSumKeyValue = sumKeyValue; //임시 기준키값 = 현재 기준키값
				}
				
				if(!tempSumKeyValue.equals(sumKeyValue)){ //임시 기준키값 != 현재 기준키값
					row = sheet.createRow(sheet.getLastRowNum()+1); //행 생성
					
					//합계 세팅
					for(int i=0 ; i<dataKeys.length ; i++) {
						XSSFCell cell = row.createCell(i); //셀 생성
						//셀 스타일
						style = wb.createCellStyle();
						style.setFont(font);
						style.setVerticalAlignment(VerticalAlignment.CENTER);
						style.setBorderBottom(BorderStyle.THIN);
						style.setBorderLeft(BorderStyle.THIN);
						style.setBorderRight(BorderStyle.THIN);
						style.setAlignment(HorizontalAlignment.RIGHT);
						style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
						style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
						
						if(i == 0) {
							cell.setCellValue("합계");//MessageUtil.getMessage(locale, "common.sum")
						} else {
							if(tempSumMap.get(dataKeys[i]) != null) {
								
								double dValue = Double.parseDouble(Integer.toString(tempSumMap.get(dataKeys[i])));
								if(dValue == Math.floor(dValue)) {
									style.setDataFormat(format.getFormat("#,##0"));
								} else {
									style.setDataFormat(format.getFormat("#,##0.########"));
								}
								cell.setCellValue(dValue);
								tempSumMap.put(dataKeys[i], 0); //임시 합산값 초기화
							}
						}
						cell.setCellStyle(style);
						cell = null;
						style = null;
					}
					tempSumKeyValue = sumKeyValue; //임시 기준키값 초기화
					row = null;
				}
				
				//임시 합산값 = 임시 합산값 + 현재 합산값 
				Iterator<String> iter = tempSumMap.keySet().iterator();
				while(iter.hasNext()){
					String key = iter.next();
					tempSumMap.put(key, tempSumMap.get(key) + sumMap.get(key));
				}
				
				//데이터 세팅
				row = sheet.createRow(sheet.getLastRowNum()+1); //행 생성
				
				for(int i=0 ; i<dataKeys.length ; i++) {
					XSSFCell cell = row.createCell(i); //셀 생성
					
					for(Method m: klass.getMethods()) {
						String methodName = "get"+dataKeys[i]; //getter
						if(methodName.toUpperCase().equals(m.getName().toUpperCase())) { //Vo에서 key값과 동일한 객체 이름이 있는경우
							
							//셀 스타일
							style = wb.createCellStyle();
							style.setFont(font);
							style.setVerticalAlignment(VerticalAlignment.CENTER);
							style.setBorderBottom(BorderStyle.THIN);
							style.setBorderLeft(BorderStyle.THIN);
							style.setBorderRight(BorderStyle.THIN);
							
							if(dataTypes != null && dataTypes.length > 0) { //셀 타입에 따라 정렬 변화
								if("String".equals(dataTypes[i])) {
									style.setAlignment(HorizontalAlignment.LEFT);
									cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
								} else if("Number".equals(dataTypes[i])) {
									style.setAlignment(HorizontalAlignment.RIGHT);
									String value = String.valueOf(m.invoke(o));
									double dValue = 0;
									try {
										dValue = Double.parseDouble(value);
										if(dValue == Math.floor(dValue)) {
											style.setDataFormat(format.getFormat("#,##0"));
										} else {
											style.setDataFormat(format.getFormat("#,##0.########"));
										}
									} catch (Exception e) {
									}
									cell.setCellValue(dValue); //셀에 값 입력
								} else {
									style.setAlignment(HorizontalAlignment.CENTER);
									cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
								}
							} else {
								style.setAlignment(HorizontalAlignment.CENTER);
								cell.setCellValue(String.valueOf(m.invoke(o))); //셀에 값 입력
							}
							
							cell.setCellStyle(style);
							cell = null;
							style = null;
							break;
						}
					}
				}
				row = null;
				
				if(num+1 == list.size()) { //마지막 행인 경우
					row = sheet.createRow(sheet.getLastRowNum()+1); //행 생성
					
					//합계 세팅
					for(int i=0 ; i<dataKeys.length ; i++) {
						XSSFCell cell = row.createCell(i); //셀 생성
						//셀 스타일
						style = wb.createCellStyle();
						style.setFont(font);
						style.setVerticalAlignment(VerticalAlignment.CENTER);
						style.setBorderBottom(BorderStyle.THIN);
						style.setBorderLeft(BorderStyle.THIN);
						style.setBorderRight(BorderStyle.THIN);
						style.setAlignment(HorizontalAlignment.RIGHT);
						style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
						style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
						
						if(i == 0) {
							cell.setCellValue("합계");//MessageUtil.getMessage(locale, "common.sum")
						} else {
							if(tempSumMap.get(dataKeys[i]) != null) {
								
								double dValue = Double.parseDouble(Integer.toString(tempSumMap.get(dataKeys[i])));
								if(dValue == Math.floor(dValue)) {
									style.setDataFormat(format.getFormat("#,##0"));
								} else {
									style.setDataFormat(format.getFormat("#,##0.########"));
								}
								cell.setCellValue(dValue);
							}
						}
						cell.setCellStyle(style);
						cell = null;
						style = null;
					}
					row = null;
				}
				num++;
			}
			
			klass = null;
			font = null;
			style = null;
			wb = null;
		}
	}
	
	
	public static void setExcelImages(XSSFSheet sheet, String[] imageArray, int col1, int row1) throws Exception{
		if(imageArray != null && imageArray.length > 0) {
			XSSFWorkbook wb = sheet.getWorkbook();
			int addCol = 0;
			
			for(int i=0 ; i<imageArray.length ; i++) {
				String imageData = imageArray[i].replaceAll("data:image/png;base64,", "");
				String imageFileName = "image"+i+".png";
				
				byte[] file = Base64.decodeBase64(imageData);
				FileOutputStream fos = new FileOutputStream(imageFileName);
				fos.write(file);
				fos.close();
				
				File imgFile = new File(imageFileName);
				if(imgFile.exists()) {
					int tempHeight = 160;
					
					try { //해당파일이 이미지인 경우 에러 없이 실행
						BufferedImage img = ImageIO.read(imgFile);
						tempHeight = Math.round((float)Math.ceil(img.getHeight()/1.25));
					} catch (Exception e) { 
					}
					
					
					if( addCol == 0 ) { //이미지 세팅 첫번째인 경우 row 생성
						//XSSFRow row = sheet.createRow( sheet.getLastRowNum()+1 );
						XSSFRow row = sheet.getRow(row1);
						if( row != null ){
							row.setHeight((short)(tempHeight*20));
						}
					}
					
					InputStream inputStream = new FileInputStream(imageFileName);
					byte[] bytes = IOUtils.toByteArray(inputStream);
					int pictureIdx = wb.addPicture(bytes, XSSFWorkbook.PICTURE_TYPE_PNG);
					inputStream.close();
					
					XSSFCreationHelper helper = wb.getCreationHelper();
					XSSFDrawing drawing = sheet.createDrawingPatriarch();
					XSSFClientAnchor anchor = helper.createClientAnchor();
					
					anchor.setCol1(col1+addCol);
					anchor.setRow1(row1);
					anchor.setAnchorType(AnchorType.MOVE_DONT_RESIZE);
					
					XSSFPicture pict = drawing.createPicture(anchor, pictureIdx);
					pict.resize(10, 1);
					addCol += 10;
					
					anchor = null;
					drawing = null;
					helper = null;
				}
				
			}
			
		}
	}
	
	
	/**
	 * 엑셀 파일 생성, 서버에 임시 저장, 파일명은 사용자 아이디
	 * @param wb
	 * @param userId
	 * @return success: 성공여부(1: 성공, -1: 실패)
	 * */
	public static int createExcelFile(Workbook wb, HttpServletRequest request) {
		int success = 1;
		HttpSession session = null;
		File dir = null;
		FileOutputStream fos = null;
		try {
			session = request.getSession();
			String root = session.getServletContext().getRealPath("/")+"tempExcel"+File.separator;
			String filePath = root+session.getAttribute("USER_ID")+".xlsx";
			
//			System.out.println("▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼");
//			System.out.println(filePath);
//			System.out.println("▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲");
			
			dir = new File(root);
			if(!dir.exists())
				dir.mkdirs();
			
			fos = new FileOutputStream(filePath);
			wb.write(fos);
			
			if(fos != null) {
				fos.flush();
				fos.close();
				fos = null;
			}
			
		} catch (Exception e) {
			success = -1;
			e.printStackTrace();
		} finally {
			try {
				if(fos != null) {
					fos.flush();
					fos.close();
					fos = null;
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			session = null;
			dir = null;
		}
		return success;
	}
	
	
	/**
	 * 셀 데이터를 value object 형태로 반환
	 * @param row
	 * @param klass: object 의 클래스
	 * @param dataKeys: 셀 데이터의 value object 키, 셀 순번과 동일
	 * @return data: 반환 object
	 * */
	public static Object getRowValuesToVo(XSSFRow row, Class<?> klass, String[] dataKeys) throws Exception{
		Object data = klass.newInstance();
		Field[] fields = data.getClass().getDeclaredFields();
		
		int cellNum = row.getPhysicalNumberOfCells(); //셀 개수
		if(cellNum > 0) {
			for(int i=row.getFirstCellNum() ; i<row.getLastCellNum() ; i++) {
				String value = getValue(row.getCell(i));
				
				for(Field f : fields) {
					if(dataKeys[i].equals(f.getName())) {
						if(!f.isAccessible()){
							f.setAccessible(true);
						}
						
						Class<?> type = f.getType();
						if(type == long.class) {
							if("".equals(value)) {
								f.set(data, 0);
							} else {
								f.set(data, Long.parseLong(value));
							}
						} else if(type == int.class) {
							if("".equals(value)) {
								f.set(data, 0);
							} else {
								f.set(data, Integer.parseInt(value));
							}
						} else if(type == char.class) {
							f.set(data, value.charAt(0));
						} else if(type == Date.class) {
							f.set(data, new SimpleDateFormat("yyyy-MM-dd").parse(value));
						} else {
							f.set(data, value);
						}
						type = null;
					}
				}
				value = null;
			}
		}
		
		return data;
	}
	
	
	/**
	 * 셀 데이터 String 형태로 반환
	 * @param cell
	 * @return value
	 * */
	public static String getValue(XSSFCell cell) {
		String value = "";
		
		if(cell != null) {
			if(cell.getCellType() == CellType.FORMULA) {  
				value = cell.getCellFormula();
			} else if(cell.getCellType() == CellType.NUMERIC) {
				if(DateUtil.isCellDateFormatted(cell)) {
					Date date = cell.getDateCellValue();
					value = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
				} else {
					double d_value = cell.getNumericCellValue();
					double f_value = Math.floor(d_value);
					if(d_value == f_value) {
						value = ((int) f_value) + "";
					} else {
						value = d_value + "";
					}
				}
			} else if(cell.getCellType() == CellType.STRING) {
				value = cell.getStringCellValue();
			} else if(cell.getCellType() == CellType.BOOLEAN) {
				value = cell.getBooleanCellValue() + "";
			} else if(cell.getCellType() == CellType.ERROR) {
				value = cell.getErrorCellValue() + "";
			} else if(cell.getCellType() == CellType.BLANK) {
				value = "";
			} else {
				value = cell.getStringCellValue();
			}
		}
		return value;
	}
	
	/**
	 * 데이터 유효성 검사
	 * @param value: 검사할 데이터
	 * @param type: 유효성 검사 타입
	 * 			- D1: 날짜 (yyyy-MM-dd)
	 * 			- D2: 시간(yyyy-MM-dd HH:mm:ss)
	 * 			- D3: 시간(HH:mm:ss)
	 * 			- DT: 일자(1~32, 32=말일)
	 * 			- N1: 양수
	 * 			- YN: Y, N
	 * @return isMatch: 검사 통과 여부 (true, false)
	 * */
	public static boolean checkValueRegexMatch(String value, String type) {
		boolean isMatch = false;
		String regex = null;
		Pattern pattern = null;
		Matcher matcher = null;
		
		if("D1".equals(type)) {
			regex = "(1[7-9]|20)\\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])";
		} else if("D2".equals(type)) {
			regex = "(1[7-9]\\d{2}|20\\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])\\s([0-1][0-9]|2[0-3])\\:([0-5][0-9])\\:([0-5][0-9])";
		} else if("D3".equals(type)) {
			regex = "([0-1][0-9]|2[0-3])\\:([0-5][0-9])\\:([0-5][0-9])";
		} else if("DT".equals(type)) {
			regex = "([1-9]|[1-2][0-9]|3[0-2])";
		} else if("N1".equals(type)) {
			regex = "[0-9]*";
		} else if("YN".equals(type)) {
			regex = "Y|N|y|n";
		}
		
		if(regex != null){
			pattern = Pattern.compile(regex);
			matcher = pattern.matcher(value);
			
			isMatch = matcher.matches();
		}
		
		return isMatch;
	}
	
	//Excel Export 
	//List: 조회 한 데이터, fileName: 엑셀 파일 이름, headers: 엑셀 해더 명칭 및 조회한 데이터 키
	public static boolean exportToExcel(List resultList, HttpServletResponse response, String fileName, String headers)  throws Exception{
		
		try {
			Workbook workbook = new SXSSFWorkbook(); // 성능 개선 버전
		    Sheet sheet = workbook.createSheet("데이터");
		    
		    createExcel(sheet, resultList, headers);		        
		
		    // 컨텐츠 타입과 파일명 지정
		    response.setContentType("application/vnd.ms-excel");
		    response.setHeader("Content-Disposition", String.format("attachment;filename=%s.xlsx", java.net.URLEncoder.encode(fileName,"UTF8")));		      
		        
		    workbook.write(response.getOutputStream());
		    workbook.close();
		    response.getOutputStream().close();
			return true;

		} catch (Exception e) {
			//LOGGER.error(e.toString());
			System.out.println("Exception error :: " + e.toString());
			return false;
			//map.put("message", e.getMessage());
		}
	}
	
	//Excel Export : 2개의 sheet 
	//resultList: 조회 한 데이터, fileName: 엑셀 파일 이름, headers: 엑셀 헤더 명칭 및 조회한 데이터 키, resultList_1: 조회한 데이터 2, headers_1: 엑셀 헤더 명칭 및 조회한 데이터 키 2
	public static boolean exportToExcelForAddSheet(List resultList, HttpServletResponse response, String fileName, String headers, List resultList_1, String headers_1)  throws Exception{
		
		try {
			Workbook workbook = new SXSSFWorkbook(); // 성능 개선 버전
		    Sheet sheet =   workbook.createSheet("조회 데이터");
		    Sheet sheet_1 = workbook.createSheet("집계 데이터");
		    
		    createExcel(sheet, resultList, headers);
		    createExcel(sheet_1, resultList_1, headers_1);
		
		    // 컨텐츠 타입과 파일명 지정
		    response.setContentType("application/vnd.ms-excel");
		    response.setHeader("Content-Disposition", String.format("attachment;filename=%s.xlsx", java.net.URLEncoder.encode(fileName,"UTF8")));		      
		        
		    workbook.write(response.getOutputStream());
		    workbook.close();
		    response.getOutputStream().close();
			return true;

		} catch (Exception e) {
			System.out.println("Exception error :: " + e.toString());
			return false;
		}
	}
    
	// 엑셀 생성
	private static void createExcel(Sheet sheet, List resultList, String header) throws Exception {

		// 데이터를 한개씩 조회해서 한개의 행으로 만든다.
		int rowNum = 0;
		Row row;
		Cell cell;
		// Header
		row = sheet.createRow(rowNum++);
		String headers[] = header.split(":"); 

		String headerNm[] = headers[0].split(","); //엑셀 헤더 
		String columns[] = headers[1].split(",");  //List 키 값

		// 엑셀 파일의 해더 셋팅.
		for (int i = 0; i < headerNm.length; i++) {
			cell = row.createCell(i);
			cell.setCellValue(headerNm[i]);
		}

		for (int i = 0; i < resultList.size(); i++) {
			Object obj = resultList.get(i);
			// row 생성
			row = sheet.createRow(rowNum++);
			int cellNum = 0;
			Field field;			
			for (int index = 0; index < columns.length; index++) {
				cell = row.createCell(cellNum++);

				field = obj.getClass().getDeclaredField(columns[index]);
				field.setAccessible(true);
				Object value = field.get(obj);
				if (value == null) {
					cell.setCellValue("");
				} else {
					cell.setCellValue(value.toString());
				}

			}

		}
	}
	
	
	// 여러 헤더, 여러 리스트 한 시트로 엑셀 생성
	@SuppressWarnings("unused")
	private static void createExcelbyMultiBody(Sheet sheet, HashMap<String, Object> resultLists, List<String> headersItm) throws Exception {

		// 데이터를 한개씩 조회해서 한개의 행으로 만든다.
		int rowNum = 0;
		Row row;
		Cell cell;
		// Header
		row = sheet.createRow(rowNum++);
		int headersCnt = 0;
		headersCnt = headersItm.size();
		
		for (int k=0; k < headersCnt; k++) {
			String headerEle = headersItm.get(k);
			String itm = Integer.toString(k);
			List resultList = (List)resultLists.get(itm);
			
			String headers[] = headerEle.split(":"); 
	
			String headerNm[] = headers[0].split(","); //엑셀 헤더 
			String columns[] = headers[1].split(",");  //List 키 값
	
			// 엑셀 파일의 해더 셋팅.
			for (int i = 0; i < headerNm.length; i++) {
				cell = row.createCell(i);
				cell.setCellValue(headerNm[i]);
			}
	
			for (int i = 0; i < resultList.size(); i++) {
				Object obj = resultList.get(i);
				// row 생성
				row = sheet.createRow(rowNum++);
				int cellNum = 0;
				Field field;			
				for (int index = 0; index < columns.length; index++) {
					cell = row.createCell(cellNum++);
	
					field = obj.getClass().getDeclaredField(columns[index]);
					field.setAccessible(true);
					Object value = field.get(obj);
					if (value == null) {
						cell.setCellValue("");
					} else {
						cell.setCellValue(value.toString());
					}
	
				}
	
			}
			rowNum++;
			
	    }
		
	}	
	
}
