package com.moadata.bdms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication(scanBasePackages = {"com.moadata.bdms"})

@ImportResource(value= {"classpath:META-INF/spring/context-servlet.xml"})
@EnableScheduling
public class BDMSApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(BDMSApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(BDMSApplication.class);
    }
}