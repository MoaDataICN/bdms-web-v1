package com.moadata.bdms.common.elasticsearch.service;

import com.moadata.bdms.model.vo.AttachmentVO;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moadata.bdms.model.vo.SearchConditionVO;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import javax.annotation.Resource;

@Service(value="esService")
public class ESService {

    @Resource(name="esClient")
    private RestHighLevelClient esClient;
    @Autowired
    private RestClientBuilder elasticsearchRestClientBuilder;

    public Map<String, Object> searchWithPaging(List<SearchConditionVO> conditions, int page, int size, List<String> expectedResult, String orderby, String orderdirection) throws IOException {
        int from = (page - 1) * size; // 0-based index
        String sortField = (orderby != null) ? orderby : "";
        String sortDirection = (orderdirection != null) ? orderdirection : "asc";

        // BoolQueryBuilder 설정 (검색 조건들 적용)
        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery();

        if(conditions != null && conditions.size() > 0) {
            for (SearchConditionVO condition : conditions) {
                if((condition.getField().equals("attchSt") && condition.getValue().isEmpty())){

                } else {
                    switch (condition.getOperator()) {
                        case "like":
                            // like 조건
                            //boolQuery.must(QueryBuilders.queryStringQuery("*"+condition.getValue()+"*"));
                            boolQuery.must(QueryBuilders.wildcardQuery(condition.getField(), "*" + condition.getValue() + "*"));
                            break;
                        case "equals":
                            // equals 조건: match 쿼리 사용
                            boolQuery.must(QueryBuilders.matchQuery(condition.getField(), condition.getValue()));
                            break;
                        case "greaterThan":
                            // greaterThan 조건: range 쿼리 사용
                            boolQuery.must(QueryBuilders.rangeQuery(condition.getField()).gt(condition.getValue()));
                            break;
                        case "lessThan":
                            // lessThan 조건: range 쿼리 사용
                            boolQuery.must(QueryBuilders.rangeQuery(condition.getField()).lt(condition.getValue()));
                            break;
                        default:
                            throw new IllegalArgumentException("Unsupported operator: " + condition.getOperator());
                    }
                }
            }
        } else {
            boolQuery.must(QueryBuilders.matchAllQuery());
        }


        // SearchSourceBuilder 설정 (필드 포함/제외)
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder()
                .query(boolQuery)
                .from(from)
                .size(size)
                .fetchSource(expectedResult.toArray(new String[0]),
                        new String[]{});

        // 정렬 관련, ES 필드수정이 필요하여 보류
        /*
        if ("desc".equalsIgnoreCase(sortDirection)) {
        	searchSourceBuilder.sort(sortField, SortOrder.DESC);
        } else {
        	searchSourceBuilder.sort(sortField, SortOrder.ASC);
        }
        */

        // SearchRequest 생성
        SearchRequest searchRequest = new SearchRequest("mediwalk");
        searchRequest.source(searchSourceBuilder);

        // 검색 실행
        SearchResponse response = esClient.search(searchRequest, RequestOptions.DEFAULT);

        // 검색 결과 추출
        List<Map<String, Object>> results = new ArrayList<>();
        for (SearchHit hit : response.getHits().getHits()) {
            results.add(hit.getSourceAsMap());
        }

        // jqGrid 형식으로 변환
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("page", page);
        resultMap.put("records", response.getHits().getTotalHits().value); // 전체 데이터 개수
        resultMap.put("total", (int) Math.ceil((double) response.getHits().getTotalHits().value / size)); // 총 페이지 수
        resultMap.put("rows", results); // 검색된 데이터 리스트

        return resultMap;
    }

    public AttachmentVO getAttachImages(String attachId) {
        AttachmentVO findResult = new AttachmentVO();
        try {
            SearchSourceBuilder sourceBuilder = new SearchSourceBuilder()
                    .query(QueryBuilders.termQuery("attchId.keyword", attachId));
            SearchRequest searchRequest = new SearchRequest("mediwalk");
            searchRequest.source(sourceBuilder);

            // 검색 실행
            SearchResponse response = esClient.search(searchRequest, RequestOptions.DEFAULT);

            // 검색 결과 추출
            List<AttachmentVO> results = new ArrayList<>();
            for (SearchHit hit : response.getHits().getHits()) {
                Map<String, Object> sourceAsMap = hit.getSourceAsMap();

                AttachmentVO attachment = new AttachmentVO();

                // JSON 데이터에서 필요한 필드를 추출
                attachment.setAttchId(hit.getId());
                attachment.setUserId((String) sourceAsMap.getOrDefault("userId", ""));
                attachment.setAttchMngId((String) sourceAsMap.get("attchMngId"));
                attachment.setAttchId((String) sourceAsMap.get("attchId"));
                attachment.setBinaryImage((String) sourceAsMap.get("binaryImage"));
                attachment.setOriginalFileName((String) sourceAsMap.get("originalFileName"));

                results.add(attachment);
            }


            if(results.size() > 0) {
                return results.get(0);
            } else {
                return findResult;
            }
        }catch(Exception e) {
            e.printStackTrace();

        }
        return findResult;
    }
}
