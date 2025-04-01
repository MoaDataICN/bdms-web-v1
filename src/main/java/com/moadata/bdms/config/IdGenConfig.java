package com.moadata.bdms.config;

import com.moadata.bdms.support.idgen.service.impl.TableIdGenService;
import com.moadata.bdms.support.idgen.service.impl.strategy.IdGenStrategyImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
public class IdGenConfig {
    @Bean
    public IdGenStrategyImpl userSeq() {
        IdGenStrategyImpl strategy = new IdGenStrategyImpl();
        strategy.setPrefix("USR_");
        strategy.setCipers(12);
        strategy.setFillChar('0');
        return strategy;
    }

    @Bean(destroyMethod = "destroy")
    public TableIdGenService userIdGenService(DataSource dataSource, IdGenStrategyImpl userSeq) {
        TableIdGenService idGenService = new TableIdGenService();
        idGenService.setDataSource(dataSource);
        idGenService.setStrategy(userSeq);
        idGenService.setBlockSize(1);
        idGenService.setTable("HSMNG_MNG_IDS");
        idGenService.setTableName("UID");
        return idGenService;
    }
}
