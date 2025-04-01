package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

/**
 * Code
 */
@Getter
@Setter
@Alias("attachmentVO")
public class AttachmentVO extends BaseObject {
	private String userId;

	private String attchMngId;		// 관리ID(묶음)
	private String seqno;			// 순번
	private String attchId;			// 실제 파일ID (각각)
	private String attchPos;		// 사용되는 위치 (프로필, 오늘, 게시글)
	private String attchSt;			// 상태(Y,N)
	private String attchSize;		// 파일 크기(KB)

	private String crDt;
	private String crId;
	private String registDt;
	private String registId;
	private String updateDt;
	private String updateId;

	private String dailyName;

	private String binaryImage;		// 바이너리로 변환된 String값
	private String originalFileName;// 원본 파일명

	private ArrayList<MultipartFile> article_file;
	private MultipartFile inputFile;
}
