package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseSearchObject;
import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.List;
import java.util.Map;

/**
 * User
 */
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("checkupVO")
public class CheckupVO extends BaseSearchObject {
    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = 5908162720412609036L;
    private String   reportId;                    // 보고서 Id
    private String   userId;                      // 사용자 Id
    private String   adminId;                     // 관리자 Id
    private String   reportItemGroup;             // report Item Group
    private String   valid;                       // valid 형태 (passed, failed)
    private String   chckType;                    // 검진 종류
    private String   chckCt;                      // 검진병원
    private String   chckDctr;                    // 검진 담당의사
    private String   chckResult;                  // 검진 결과
    private String   chckDt;                      // CheckUp Date                 건강검진일
    private String   brthDt;                      // Birth Date                   생년월일
    private String   gender;                      // Gender                       성별
    private String   hght;                        // Height                       신장
    private String   wght;                        // Weight                       몸무게
    private String   wst;                         // Waist circumference          허리둘레
    private String   sbp;                         // Systolic Blood Pressure      혈압(수축기)
    private String   dbp;                         // Diastolic Blood Pressure     혈압(이완기)
    private String   fbs;                         // Fasting Blood Sugar          공복혈당 수치
    private String   hba1c;                       // HbA1C                        공복혈당 당화혈색소
    private String   tc;                          // Total Cholesterol            혈중지질수치 - 총콜레스테롤
    private String   hdl;                         // HDL                          혈중지질수치 - 고밀도콜레스테롤
    private String   ldl;                         // LDL                          혈중지질수치 - 저밀도콜레스테롤
    private String   trgly;                       // Triglyceride                 혈중지질수치 - 중성지방
    private String   sc;                          // Serum Creatinine             요검사수치 - 혈청크레아티닌
    private String   gfr;                         // GFR                          요검사수치 - 신사구체여과율(GFR)
    private String   urAcd;                       // Uric Acid                    요검사수치 - 요산
    private String   bun;                         // BUN                          요검사수치 - BUN
    private String   alt;                         // ALT                          간수치 - alt
    private String   ast;                         // AST                          간수치 - ast
    private String   gtp;                         // γ-GTP                        간수치 - γ-GTP
    private String   tprtn;                       // Total Protein                간수치 - 총단백질
    private String   blrbn;                       // Bilirubin                    간수치 - 총빌리루빈
    private String   alp;                         // ALP                          간수치 - ALP
    private String   comment;                     // Comment
    private String   bmi;                         // BMI
    private String   locale;                      // 언어 locale
    private String   brthYear;                    // 출생년

	private String   registDt;
	private String   registId;
	private String   uptDt;
	private String   uptId;

	/** Upload Status 목록 조회용 */
	private String   enteredBy;                   // 기재자                        BDMS APP : by user / BDMS WEB : adminNm
	private String   userNm;                      // 환자명
	private String   grpcYn;                      // GRPC 연동 상태                BDMS APP : NULL / BDMS WEB : N or Y

    private String   mct;                         // Medical Checkup Type
    private String   cr;                          // Checkup result
    private String   cc;                          // Checkup center

    private List<Map> paramList;
}