package com.moadata.bdms.workforce.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import com.moadata.bdms.model.vo.WorkforceVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("workforceDao")
public class WorkforceDao extends BaseAbstractDao {

    public String selectMaxWrkfrcId() {
        return (String)selectOne("workforce.selectMaxWrkfrcId");
    }

    public List<WorkforceVO> selectWorkforceList(WorkforceVO workforceVO) {
        List<WorkforceVO> list = selectList("workforce.selectWorkforceList", workforceVO);

        if(list.size() > 0) {
            list.get(0).setCnt((Integer)selectOne("workforce.selectWorkforceCnt", workforceVO));
        }
        return list;
    }

    public void insertWorkforce(WorkforceVO workforceVO) {
        insert("workforce.insertWorkforce", workforceVO);
    }

    public void updateWorkforce(WorkforceVO workforceVO) {
        update("workforce.updateWorkforce", workforceVO);
    }

    public WorkforceVO selectWorkforceById(String wrkfrcId) {
        return (WorkforceVO)selectOne("workforce.selectWorkforceById", wrkfrcId);
    }
}
