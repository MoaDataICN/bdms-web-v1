package com.moadata.bdms.common.grpc.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.net.ssl.SSLException;

import com.moadata.bdms.user.service.UserService;
import org.json.JSONObject;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import api.Fromage;
import api.Fromage.AnalysisResponse;
import api.Fromage.GetAnalysisResponse;
import api.Fromage.GetOrganAnalysisRequest;
import api.Fromage.GetOrganAnalysisResponse;
import api.Fromage.SetUserInforResponse;
import api.FromageServiceGrpc;

import com.moadata.bdms.model.vo.HealthInfoVO;
import com.moadata.bdms.model.vo.UserInfoVO;
import com.moadata.bdms.model.vo.ReportItemVO;
import com.moadata.bdms.model.vo.ReportVO;

import api.Fromage;
import com.google.common.util.concurrent.ListenableFuture;
import com.google.protobuf.Timestamp;
import com.moadata.bdms.model.vo.MyVO;

import io.grpc.ManagedChannel;
import io.grpc.Channel;
import io.grpc.netty.shaded.io.grpc.netty.GrpcSslContexts;
import io.grpc.netty.shaded.io.grpc.netty.NettyChannelBuilder;
import io.grpc.netty.shaded.io.netty.handler.ssl.SslContext;
import io.grpc.netty.shaded.io.netty.handler.ssl.SslContextBuilder;
import io.grpc.netty.shaded.io.netty.handler.ssl.util.InsecureTrustManagerFactory;
import org.springframework.stereotype.Service;

import javax.net.ssl.SSLException;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Service(value = "grpcService")
public class GrpcServiceImpl implements GrpcService {

	@Resource(name = "userService")
	private UserService userService;

	private final String GRPC_SERVER_KEY = "JoPnuPZb3d1/snnpg1zpvw==";
	private final String GRPC_SERVER_IP = "10.120.102.102";
	private final int GRPC_SERVER_PORT = 8081;
	private final ManagedChannel channel;

	private FromageServiceGrpc.FromageServiceFutureStub futureStub; // 비동기 방식
	private FromageServiceGrpc.FromageServiceBlockingStub blockingStub; // 동기 방식

	public GrpcServiceImpl() throws IOException, SSLException {
		io.grpc.netty.shaded.io.netty.handler.ssl.SslContextBuilder sslContextBuilder = GrpcSslContexts.forClient()
				.trustManager(InsecureTrustManagerFactory.INSTANCE);
		SslContext sslContext = sslContextBuilder.build();

		this.channel = NettyChannelBuilder.forAddress(GRPC_SERVER_IP, GRPC_SERVER_PORT).sslContext(sslContext)
				.overrideAuthority(GRPC_SERVER_IP).build();

		this.blockingStub = FromageServiceGrpc.newBlockingStub(channel);
		this.futureStub = FromageServiceGrpc.newFutureStub(channel);
	}

	// 사용자 등록
	@Override
	public void registerPatient(UserInfoVO user) {
		try {
			String formattedBrthDt = user.getBrthDt().replaceAll("-", "");
			String gender = "M".equals(user.getSx()) ? "1" : ("F".equals(user.getSx()) ? "2" : null);
			if (gender == null) {
				throw new IllegalArgumentException("Invalid gender value: " + user.getSx());
			}
			Fromage.User.Builder userBuilder = Fromage.User.newBuilder().setName(user.getUserNm()) // 사용자 이름
					.setPcustNmbr(user.getUserId().length() > 30 ? user.getUserId().substring(0, 30) : user.getUserId()) // 사용자 ID
					.setBrthDate(formattedBrthDt) // 생년월일
					.setGen(gender) // 성별 (1: 남성, 2: 여성)
					.setPhoneNmbr(user.getMobile()) // 전화번호
					.setSrvcCode("01"); // 서비스 코드

			String yyyyMMdd = Instant.now().atZone(ZoneId.of("Asia/Seoul"))
					.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
			LocalDate localDate = LocalDate.parse(yyyyMMdd, DateTimeFormatter.ofPattern("yyyyMMdd"));
			Instant instant = localDate.atStartOfDay(ZoneId.of("Asia/Seoul")).toInstant();
			Timestamp nowDate = Timestamp.newBuilder().setSeconds(instant.getEpochSecond()).build();

			Fromage.PropertyKB.Builder propertyKBbuilder = Fromage.PropertyKB.newBuilder().setChannelCode("99")
					.setServiceStartDate(nowDate).setExpireDate(nowDate);

			Fromage.SetUserInfoRequestWithKB request = Fromage.SetUserInfoRequestWithKB.newBuilder()
					.setKey(GRPC_SERVER_KEY) // gRPC 서버 키
					.setUser(userBuilder) // 사용자 정보
					.setProperty(propertyKBbuilder) // 서비스 정보
					.build();

			blockingStub.setUserInfoWithKB(request);
		} catch (Exception e) {
			e.printStackTrace();
			// 예외 처리 추가
		}
	}

	@Override
	public void registerCheckupData(ReportVO latestReport, List<HealthInfoVO> healthInfoList, UserInfoVO userInfo) {
			try { 
				String yyyyMMdd = Instant.now().atZone(ZoneId.of("Asia/Seoul"))
						.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
				LocalDate localDate = LocalDate.parse(yyyyMMdd, DateTimeFormatter.ofPattern("yyyyMMdd"));
				Instant instant = localDate.atStartOfDay(ZoneId.of("Asia/Seoul")).toInstant();
				Timestamp nowDate = Timestamp.newBuilder().setSeconds(instant.getEpochSecond()).build();
				
				Fromage.AnalysisRequest.Data.Checkup.Builder checkupBuilder = Fromage.AnalysisRequest.Data.Checkup.newBuilder();
				
				String gender = "M".equals(userInfo.getSx()) ? "1" : ("F".equals(userInfo.getSx()) ? "2" : null);
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		        LocalDate birthData = LocalDate.parse(userInfo.getBrthDt(),formatter);
		        LocalDate current = LocalDate.now();
		        double age = ChronoUnit.YEARS.between(birthData,current);
		        
		        checkupBuilder.setAge(age);
		        checkupBuilder.setGen(Double.parseDouble(gender.toString()));
				
			    for (HealthInfoVO healthInfo : healthInfoList) { 
			        String metaDataCode = healthInfo.getMetaDataCode();
					if (!metaDataCode.equals("91000001") && !metaDataCode.equals("91000002") && healthInfo.getValue() != null) {
						Double value = Double.parseDouble(healthInfo.getValue());

						// 각 metaDataCode에 맞는 값 설정
						switch (metaDataCode) {
							case "11000000": // 키(Height)
								checkupBuilder.setHt(value);
								break;
							case "12000000": // 체중(Weight)
								checkupBuilder.setBw(value);
								break;
							case "13000000": // 허리둘레(WC)
								checkupBuilder.setWc(value);
								break;
							case "14000000": // 체질량지수(BMI)
								checkupBuilder.setBmi(value);
								break;
							case "17100000": // 수축기 혈압(SBP)
								checkupBuilder.setSbp(value);
								break;
							case "17200000": // 이완기 혈압(DBP)
								checkupBuilder.setDbp(value);
								break;
							case "22000000": // 혈청 크레아티닌(Serum Creatinine)
								checkupBuilder.setCr(value);
								break;
							case "23000000": // 신사구체여과율(GFR)
								checkupBuilder.setGfr(value);
								break;
							case "24000000": // 요산(Uric Acid)
								checkupBuilder.setUph(value);
								break;
							case "25000000": // BUN(BUN)
								checkupBuilder.setBun(value);
								break;
							case "31000000": // AST(SGOT)
								checkupBuilder.setAst(value);
								break;
							case "32000000": // ALT(SGPT)
								checkupBuilder.setAlt(value);
								break;
							case "33000000": // γ-GTP(γ-GTP)
								checkupBuilder.setGgtp(value);
								break;
							case "34000000": // 총 단백질(Total Protein)
								checkupBuilder.setTp(value);
								break;
							case "35000000": // 총 빌리루빈(Bilirubin)
								checkupBuilder.setTb(value);
								break;
							case "36000000": // ALP(ALP)
								checkupBuilder.setAlp(value);
								break;
							case "41000000": // 총 콜레스테롤(Total Cholesterol)
								checkupBuilder.setTc(value);
								break;
							case "42000000": // HDL 콜레스테롤(HDL-C)
								checkupBuilder.setHdl(value);
								break;
							case "43000000": // LDL 콜레스테롤(LDL-C)
								checkupBuilder.setLdl(value);
								break;
							case "44000000": // 중성지방(Triglyceride)
								checkupBuilder.setTg(value);
								break;
							case "52000000": // 공복 혈당(FBG)
								checkupBuilder.setFbs(value);
								break;
							case "53000000": // 당화혈색소(HbA1C)
								checkupBuilder.setHba1C(value);
								break;
							default:
								break;
						}
					}
			    }
			    
			    checkupBuilder.build();
				
				// Fromage 데이터 빌드
				Fromage.AnalysisRequest.Data.Builder analysisRequestBuilder = Fromage.AnalysisRequest.Data.newBuilder() 
						.setSrvcCode("1010010") // 서비스 코드
						.setReptCode("0402083") // 레포트 코드 
						.setCntyCode("ko-KR") // 국가
						.setChckDate(latestReport.getChckDate().replace("-", "")) // 검진 날짜
						.setPcustNmbr(userInfo.getUserId().length() > 30 ? userInfo.getUserId().substring(0, 30) : userInfo.getUserId()) // 환자 번호
						.setPcustName(userInfo.getUserNm()) // 환자 이름
						.setBrthDate(userInfo.getBrthDt().replace("-", "")) // 생년월일 
						.setScrapSucsYn(true) // 스크랩 성공
						.setScrapDataValidYn(true) // 유효 데이터 여부 
						.setScrapDate(nowDate) // 데이터 등록일자(Timestamp)=현재일자
						.setChannelCode("99") // 채널코드=99
						.setRequestDate(nowDate) // 요청일자(Timestamp)=현재일자
						.setCheckupData(checkupBuilder); // 검진데이터
				
				List<Fromage.AnalysisRequest.Data> dataList = new ArrayList<>();
				dataList.add(analysisRequestBuilder.build());
				
				// 분석데이터 등록
				Fromage.AnalysisRequest analysisRequest = Fromage.AnalysisRequest.newBuilder()
						.setKey(GRPC_SERVER_KEY)
						.addAllData(dataList)
						.build();
				
				api.Fromage.AnalysisResponse response = blockingStub.analysis(analysisRequest);
				//grpcAnalysisAge(userInfo, latestReport);
			} catch (Exception e) { 
				e.printStackTrace();
			}
	}
	
	@Override
	public boolean fetchAndProcessAnalysisAge(UserInfoVO userInfo, boolean isStartFlag) {
	    boolean isError = false;
	    
	    RestTemplate restTemplate = new RestTemplate();
	    String searchId = userInfo.getUserId().length() > 30 ? userInfo.getUserId().substring(0, 30) : userInfo.getUserId();
	    String analysisAgeUrl = "https://bdms.moadata.ai:8912/api/external/analysis-age?userNo=" + searchId;
	    try {            
            ResponseEntity<String> response = restTemplate.exchange(analysisAgeUrl, HttpMethod.GET, null, String.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                String responseBody = response.getBody();
                JSONObject jsonResponse = new JSONObject(responseBody);
                HealthInfoVO healthInfo = new HealthInfoVO();
                healthInfo.setUserId(userInfo.getUserId());
                
                // 종합나이 (BAD)
                healthInfo.setBadVal(jsonResponse.optString("bioAge").isEmpty() ? "0" : jsonResponse.optString("bioAge"));

                // 비만 (BAA)
                healthInfo.setBaaVal(jsonResponse.optString("obesityAge").isEmpty() ? "0" : jsonResponse.optString("obesityAge"));

                // 심장 (CAA)
                healthInfo.setCaaVal(jsonResponse.optString("heartAge").isEmpty() ? "0" : jsonResponse.optString("heartAge"));

                // 취장 (PAA)
                healthInfo.setPaaVal(jsonResponse.optString("abdomenAge").isEmpty() ? "0" : jsonResponse.optString("abdomenAge"));

                // 신장 (REA)
                healthInfo.setReaVal(jsonResponse.optString("lungAge").isEmpty() ? "0" : jsonResponse.optString("lungAge"));

                // 간장 (HEA)
                healthInfo.setHeaVal(jsonResponse.optString("liverAge").isEmpty() ? "0" : jsonResponse.optString("liverAge"));
                
                healthInfo.setUptYn(isStartFlag ? "Y" : "N");
                
                userService.insertAnlyData(healthInfo);
            } else {
                isError = true;
            }
        } catch (Exception e) {
            isError = true;
        }
	    return isError;
	}
	

	@Override
	public boolean fetchAndProcessAnalysisAgeByUserId30(String userId, boolean isStartFlag) {
	    boolean isError = false;
	    System.out.println("All userId : " + userId);
	    System.out.println("fetchAndProcessAnalysisAgeByUserId30 userId : " + (userId.length() >= 30 ? userId.substring(0, 30) : userId));
	    
	    RestTemplate restTemplate = new RestTemplate();
	    String analysisAgeUrl = "https://bdms.moadata.ai:8912/api/external/analysis-age?userNo=" + (userId.length() >= 30 ? userId.substring(0, 30) : userId);
	    try {            
            ResponseEntity<String> response = restTemplate.exchange(analysisAgeUrl, HttpMethod.GET, null, String.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                String responseBody = response.getBody();
                JSONObject jsonResponse = new JSONObject(responseBody);
                HealthInfoVO healthInfo = new HealthInfoVO();
                healthInfo.setUserId(userId);
                
                // 종합나이 (BAD)
                healthInfo.setBadVal(jsonResponse.optString("bioAge").isEmpty() ? "0" : jsonResponse.optString("bioAge"));

                // 비만 (BAA)
                healthInfo.setBaaVal(jsonResponse.optString("obesityAge").isEmpty() ? "0" : jsonResponse.optString("obesityAge"));

                // 심장 (CAA)
                healthInfo.setCaaVal(jsonResponse.optString("heartAge").isEmpty() ? "0" : jsonResponse.optString("heartAge"));

                // 취장 (PAA)
                healthInfo.setPaaVal(jsonResponse.optString("abdomenAge").isEmpty() ? "0" : jsonResponse.optString("abdomenAge"));

                // 신장 (REA)
                healthInfo.setReaVal(jsonResponse.optString("lungAge").isEmpty() ? "0" : jsonResponse.optString("lungAge"));

                // 간장 (HEA)
                healthInfo.setHeaVal(jsonResponse.optString("liverAge").isEmpty() ? "0" : jsonResponse.optString("liverAge"));
                
                healthInfo.setUptYn(isStartFlag ? "Y" : "N");
                
               userService.insertAnlyData(healthInfo);
            } else {
                isError = true;
            }
        } catch (Exception e) {
            isError = true;
        }
	    return isError;
	}
	
	@Override
	public Map<String, Object> grpcAnalysisAge(UserInfoVO userInfo, ReportVO latestReport, boolean isStartFlag) {
	    Map<String, Object> resultMap = new HashMap<>();
	    boolean isError = false;
	    String errorMessage = "";

	    try {
	        if (userInfo != null && latestReport != null) {
	            // 분석 요청 준비
	            Fromage.GetOrganAnalysisRequest.Data.Builder getanalysisRequestBuilder = Fromage.GetOrganAnalysisRequest.Data.newBuilder()
	                    .setSrvcCode("1010010") // 서비스 코드
	                    .setReptCode("0402083") // 레포트 코드 
	                    .setCntyCode("ko-KR") // 국가
	                    .setChckDate(latestReport.getChckDate().replace("-", "")) // 검진 날짜
	                    .setPcustNmbr(userInfo.getUserId().length() > 30 ? userInfo.getUserId().substring(0, 30) : userInfo.getUserId()); // 환자 번호

	            List<Fromage.GetOrganAnalysisRequest.Data> dataList = new ArrayList<>();
	            dataList.add(getanalysisRequestBuilder.build());

	            // 분석 요청
	            Fromage.GetOrganAnalysisRequest analysisRequest = Fromage.GetOrganAnalysisRequest.newBuilder()
	                    .setKey(GRPC_SERVER_KEY)
	                    .addAllData(dataList)
	                    .build();

	            // gRPC 분석 호출
	            GetOrganAnalysisResponse response = blockingStub.getOrganAnalysis(analysisRequest);
	            System.out.println("analysis Response: " + response);

	            String encodedMessage = response.getData(0).getMessage();
	            byte[] byteArray = encodedMessage.getBytes(StandardCharsets.UTF_8);
	            String decodedMessage = new String(byteArray, StandardCharsets.UTF_8);
	            System.out.println("복원된 메시지: " + decodedMessage);
	            System.out.println("생체나이 :  " + response.getData(0));

	            // 응답이 성공적인 경우
	            if ("Y".equals(response.getSucsYn())) {
	                HealthInfoVO healthInfo = new HealthInfoVO();
	                healthInfo.setUserId(userInfo.getUserId());

	                // 종합 나이 (BAD)

	                //double aoa = response.getData(0).getAoa();
	                //healthInfo.setBadVal(Double.isNaN(aoa) ? "0" : String.valueOf(aoa));


	                // 비만 (BAA)
	                double baa = response.getData(0).getBaa();
	                healthInfo.setBaaVal(Double.isNaN(baa) ? "0" : String.valueOf(baa));

	                // 심장 (CAA)
	                double caa = response.getData(0).getCaa();
	                healthInfo.setCaaVal(Double.isNaN(caa) ? "0" : String.valueOf(caa));

	                // 취장 (PAA)
	                double paa = response.getData(0).getPaa();
	                healthInfo.setPaaVal(Double.isNaN(paa) ? "0" : String.valueOf(paa));

	                // 신장 (REA)
	                double rea = response.getData(0).getRea();
	                healthInfo.setReaVal(Double.isNaN(rea) ? "0" : String.valueOf(rea));

	                // 간장 (HEA)
	                double hea = response.getData(0).getHea();
	                healthInfo.setHeaVal(Double.isNaN(hea) ? "0" : String.valueOf(hea));

	                healthInfo.setUptYn(isStartFlag ? "Y" : "N");
	                userService.insertAnlyData(healthInfo);

	                // 성공적인 처리 결과 리턴
	                resultMap.put("success", true);
	                resultMap.put("message", "Analysis successfully processed.");
	            } else {
	                isError = true;
	                errorMessage = "Analysis failed: " + response.getMessage();
	            }
	        } else {
	            isError = true;
	            errorMessage = "User info or latestReport is null.";
	        }
	    } catch (Exception e) {
	        isError = true;
	        errorMessage = "Exception occurred: " + e.getMessage();
	        e.printStackTrace();
	    }

	    if (isError) {
	        resultMap.put("success", false);
	        resultMap.put("message", errorMessage);
	    }

	    return resultMap;
	}
}