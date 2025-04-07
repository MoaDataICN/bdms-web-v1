package com.moadata.bdms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication(scanBasePackages = {"com.moadata.bdms"})

@ImportResource(value= {"classpath:META-INF/spring/context-servlet.xml"})

public class BDMSApplication {

	public static void main(String[] args) {
		SpringApplication.run(BDMSApplication.class, args);
	}

}
