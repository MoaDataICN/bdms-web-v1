package com.moadata.bdms.config;

import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ElasticsearchConfig {

    @Bean(name="esClient")
    public RestHighLevelClient client() {
        return new RestHighLevelClient(
                RestClient.builder(new HttpHost("10.120.101.13", 9200, "http")));
    }
    /*
    @Bean
    public ElasticsearchRestTemplate elasticsearchTemplate(RestHighLevelClient client) {
        return new ElasticsearchRestTemplate(client);
    }
    */
}
