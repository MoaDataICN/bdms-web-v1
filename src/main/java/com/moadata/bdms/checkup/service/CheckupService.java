package com.moadata.bdms.checkup.service;

import com.moadata.bdms.model.vo.CheckupVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface CheckupService {
    public List<CheckupVO> selectCheckupList(CheckupVO checkupVO);
    public Map<String, Object> getImportMapForBDMSMulti(MultipartFile file, String loginId);
    public boolean insertCheckupDataList(CheckupVO checkupVO);
}
