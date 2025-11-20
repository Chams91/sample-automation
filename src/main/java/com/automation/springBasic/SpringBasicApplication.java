package com.automation.springBasic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class SpringBasicApplication {

	public static void main(String[] args) {
        SpringApplication.run(SpringBasicApplication.class, args);
    }
    
    @RestController
    public static class HelloController {
        
        @GetMapping("/home")
        public String hello() {
            return "Hello World!";
        }
        
        @GetMapping("/health")
        public String health() {
            return "OK";
        }
    }

}
