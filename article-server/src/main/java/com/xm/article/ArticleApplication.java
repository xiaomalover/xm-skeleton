package com.xm.article;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

/**
 * 文章微服务
 * @author xiaomalover <xiaomalover@gmail.com>
 */
@SpringBootApplication
@EnableEurekaClient
public class ArticleApplication {
	public static void main(String[] args) {
		SpringApplication.run(ArticleApplication.class, args);
	}
}
