package com.moadata.bdms.model.vo;

import java.util.List;

import com.moadata.bdms.common.base.vo.BaseObject;
import org.apache.ibatis.type.Alias;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("alarmVO")
public class AlarmVO extends BaseObject {

	private String userId;				// 사용자 Id
	private String userNm;				// 사용자 닉네임
	private String tokenId;			
	private List<String> tokenList;
	private String crId;
	private String crDt;
	
	private String alrmId;				// 알람 Id
	private String alrmPushId;			// 스케쥴러용 알람 ID
	private String alrmTp;				// 알림선택(1:소리와 진동 허용, 2: 무음, 3:전체차단)
	private String alrmUrl;				// 푸시 알림 URL
	
	private String ntcYn;				// 공지사항여부(전체고객대상 서비스 공지 알림) (Y/N)
	private String gudYn;				// 시스템-알림 여부 (Y/N)
	private String bnfEvtYn;			// 혜택및이벤트여부(이벤트 및 신규 서비스, 프로모션 안내등)(Y/N)
	private String chllngId;			// 참가한 챌린지Id
	private String chgAlrmYn;			// 챌린지알림여부(내가 가입한 챌린지의 알림)(Y/N)
	private String ract;				// 내반응(형태는 000~111로 새메시지알림(0,1), 새댓글 알림(0,1), 친구 신청(팔로우) 알림(0,1))
	private String ractNm;				// 새메시지 알림(Y/N)
	private String ractNc;				// 새댓글 알림(Y/N)
	private String ractFa;				// 친구 신청(팔로우) 알림(Y/N)
	private String cont;				// 내용
	private String title;
	
	private String alrmNotiTp;			// 알람 공지 종류
	private String alrmNotiTtl;			// 알람 공지 제목
	private String alrmNotiCont;		// 알람 공지 내용
	private String attchMngId;			// 알람 공지 첨부물
	private String attchId;				// 썸네일 이미지용
	private String vstCnt;				// 공지 조회수
	private String dlYn;
	private String locAddr;
	
	private String sndDt;				// 발송시간
	private String registDt;
	private String registId;
	
	private String uptDt;
	private String uptId;
	
	private String pushYn;				// 광고성 푸시 알림 허용(Y/N)
	private String pushUptDt;			// 광고성 푸시 알림 동의 / 비동의 변경일시
	
	private String sendFlag;			// 푸시알림 flag
	private String readSt;				// 알림 읽음 표시 여부
	
	/*
	 보내줘야 하는 데이터 :
	 alrmId, userId, ntcYn, bnfEvtYn, chgAlrmYn, ract 해당 사항 Y/N, 000~111 보내기
	  */
}

