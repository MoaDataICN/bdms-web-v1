package com.moadata.bdms.checkup.repository;

import com.moadata.bdms.common.base.dao.BaseAbstractDao;
import org.springframework.stereotype.Repository;
import com.moadata.bdms.common.util.encrypt.EncryptUtil;
import com.moadata.bdms.model.vo.CheckupVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.Math.pow;

@Repository("checkupDao")
public class CheckupDao extends BaseAbstractDao {

    public List<CheckupVO> selectCheckupList(CheckupVO checkupVO) {
        List <CheckupVO> resultList = new ArrayList<CheckupVO>();
        resultList = selectList("checkup.selectCheckupList", checkupVO);
        if(resultList.size() > 0) {
            resultList.get(0).setCnt((int)selectOne("checkup.selectTotalRecords"));
        }
        return resultList;
    }

    public String selectUserName(String userId){
        return (String)selectOne("checkup.selectUserName", userId);
    }

    public boolean insertCheckupDataList(CheckupVO checkupVO){

        String reportId = "";

        List<Map> tempList = checkupVO.getParamList();
        if(tempList.size() > 0) {
            for(int i=0; i< tempList.size(); i ++) {

                List<Map> checkUpList = new ArrayList<>();
                Map<String, Object> tmpmap = new HashMap<>();
                try {
                    if (tempList.get(i).get("hght") != null && !tempList.get(i).get("hght").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "11000000"); //1
                        tmpmap.put("msmt", tempList.get(i).get("hght"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("wght") != null && !tempList.get(i).get("wght").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "12000000"); //2
                        tmpmap.put("msmt", tempList.get(i).get("wght"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("wst") != null && !tempList.get(i).get("wst").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "13000000"); //3
                        tmpmap.put("msmt", tempList.get(i).get("wst"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("sbp") != null && !tempList.get(i).get("sbp").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "17100000"); //4
                        tmpmap.put("msmt", tempList.get(i).get("sbp"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("dbp") != null && !tempList.get(i).get("dbp").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "17200000");  //5
                        tmpmap.put("msmt", tempList.get(i).get("dbp"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("fbs") != null && !tempList.get(i).get("fbs").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "52000000");  //6
                        tmpmap.put("msmt", tempList.get(i).get("fbs"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("hba1c") != null && !tempList.get(i).get("hba1c").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "53000000");  //7
                        tmpmap.put("msmt", tempList.get(i).get("hba1c"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("tc") != null && !tempList.get(i).get("tc").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "41000000");  //8
                        tmpmap.put("msmt", tempList.get(i).get("tc"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("hdl") != null && !tempList.get(i).get("hdl").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "42000000");  //9
                        tmpmap.put("msmt", tempList.get(i).get("hdl"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("ldl") != null && !tempList.get(i).get("ldl").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "43000000");  //10
                        tmpmap.put("msmt", tempList.get(i).get("ldl"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("trgly") != null && !tempList.get(i).get("trgly").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "44000000");  //11
                        tmpmap.put("msmt", tempList.get(i).get("trgly"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("sc") != null && !tempList.get(i).get("sc").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "22000000");  //12
                        tmpmap.put("msmt", tempList.get(i).get("sc"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("gfr") != null && !tempList.get(i).get("gfr").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "23000000");  //13
                        tmpmap.put("msmt", tempList.get(i).get("gfr"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("urAcd") != null && !tempList.get(i).get("urAcd").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "24000000");  //14
                        tmpmap.put("msmt", tempList.get(i).get("urAcd"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("bun") != null && !tempList.get(i).get("bun").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "25000000");  //15
                        tmpmap.put("msmt", tempList.get(i).get("bun"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("alt") != null && !tempList.get(i).get("alt").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "32000000");  //16
                        tmpmap.put("msmt", tempList.get(i).get("alt"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("ast") != null && !tempList.get(i).get("ast").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "31000000");  //17
                        tmpmap.put("msmt", tempList.get(i).get("ast"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("gtp") != null && !tempList.get(i).get("gtp").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "33000000");  //18
                        tmpmap.put("msmt", tempList.get(i).get("gtp"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("tprtn") != null && !tempList.get(i).get("tprtn").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "34000000");  //19
                        tmpmap.put("msmt", tempList.get(i).get("tprtn"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("blrbn") != null &&  !tempList.get(i).get("blrbn").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "35000000");  //20
                        tmpmap.put("msmt", tempList.get(i).get("blrbn"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("alp") != null && !tempList.get(i).get("alp").equals("")) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "36000000");  //21
                        tmpmap.put("msmt", tempList.get(i).get("alp"));
                        checkUpList.add(tmpmap);
                    }

                    if (tempList.get(i).get("locale") != null && ((String)tempList.get(i).get("locale")).indexOf("ko") != -1) {
                        if (!tempList.get(i).get("comment").equals("")) {
                            tmpmap = new HashMap<>();
                            tmpmap.put("metaDataCode", "91000001");  //Comment 한글일 경우  "91000001", 영문일 경우 "91000002"
                            tmpmap.put("cmmt", tempList.get(i).get("comment"));
                            checkUpList.add(tmpmap);
                        }
                    } else {
                        if (!tempList.get(i).get("comment").equals("")) {
                            tmpmap = new HashMap<>();
                            tmpmap.put("metaDataCode", "91000002");  //Comment 한글일 경우  "91000001", 영문일 경우 "91000002"
                            tmpmap.put("cmmt", tempList.get(i).get("comment"));
                            checkUpList.add(tmpmap);
                        }
                    }

                    if (tempList.get(i).get("wght") != null && tempList.get(i).get("hght") != null && isNumberic((String)tempList.get(i).get("wght")) && isNumberic((String)tempList.get(i).get("hght"))) {
                        tmpmap = new HashMap<>();
                        tmpmap.put("metaDataCode", "14000000"); //BMI 지수
                        tmpmap.put("msmt", Double.toString(Integer.parseInt((String)tempList.get(i).get("wght")) / pow((Integer.parseInt((String)tempList.get(i).get("hght")) / 100), 2)));
                        checkUpList.add(tmpmap);
                    }

                    reportId = (String) selectOne("user.selectMaxSeqReportItem");
                    for (int k = 0; k < checkUpList.size(); k++) {
                        checkUpList.get(k).put("reportId", reportId);
                        checkUpList.get(k).put("adminId",  tempList.get(i).get("adminId"));
                    }

                    tempList.get(i).put("reportId", reportId);
                    // 입력창 필드 해결 이후 추가 예정

                    String brthDtStr = (String)tempList.get(i).get("brthDt");
                    String brthYear = brthDtStr.substring(0, 4);
                    String brthDt = "";

                    try {
                        brthDt = EncryptUtil.encryptText(brthDtStr);
                    } catch (Exception e) {
                        e.printStackTrace();
                        return false;
                    }

                    tempList.get(i).put("brthYear",brthYear);
                    tempList.get(i).put("brthDt", brthDt);

                    update("checkup.updateWlkMyMulti", tempList.get(i));
                    insert("checkup.insertChckReportMulti", tempList.get(i));
                    insert("checkup.insertCheckUpMulti", checkUpList);
                    insert("checkup.insertMyBodyMulti", tempList.get(i));
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
            }
        }
        return true;
    }

    public boolean isNumberic(String str) {
        try {
            Double.parseDouble(str);
        } catch (NumberFormatException e) {
            return false;
        }
        return true;
    }
}