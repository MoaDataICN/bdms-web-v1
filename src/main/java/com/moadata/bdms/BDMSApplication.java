package com.moadata.bdms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.moadata.bdms"})
public class BDMSApplication {

	public static void main(String[] args) {
		SpringApplication.run(BDMSApplication.class, args);
	}

}
