package com.xm.pay;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@SpringBootApplication
@EnableEurekaClient
public class PayApplication {
	public static void main(String[] args) {
		SpringApplication.run(PayApplication.class, args);
	}
}
