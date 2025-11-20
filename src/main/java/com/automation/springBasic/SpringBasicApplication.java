package com.automation.springBasic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringBasicApplication {

	public static void main(String[] args) {
        SpringApplication.run(HelloWorldApplication.class, args);
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
