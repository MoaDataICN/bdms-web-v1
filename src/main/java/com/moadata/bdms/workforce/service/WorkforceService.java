package com.moadata.bdms.workforce.service;

import com.moadata.bdms.model.vo.WorkforceVO;

import java.util.List;

public interface WorkforceService {
    public String selectMaxWrkfrcId();
    public List<WorkforceVO> selectWorkforceList(WorkforceVO workforceVO);

    public void insertWorkforce(WorkforceVO workforceVO);
    public void updateWorkforce(WorkforceVO workforceVO);
    public WorkforceVO selectWorkforceById(String wrkfrcId);
}
