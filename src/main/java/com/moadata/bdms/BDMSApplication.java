package com.moadata.bdms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(scanBasePackages = {"com.moadata.bdms"})
public class BDMSApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(BDMSApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(BDMSApplication.class);
	}
}
