package com.khoubyari.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import springfox.documentation.swagger2.annotations.EnableSwagger2;

import org.armedbear.lisp.*;
import org.armedbear.lisp.Package;
import com.interloper.Interloper;

/*
 * This is the main Spring Boot application class. It configures Spring Boot, JPA, Swagger
 */

@SpringBootApplication
@Configuration
@EnableAutoConfiguration  // Sprint Boot Auto Configuration
@ComponentScan(basePackages = "com.khoubyari.example")
@EnableJpaRepositories("com.khoubyari.example.dao.jpa") // To segregate MongoDB and JPA repositories. Otherwise not needed.
public class Application extends SpringBootServletInitializer {

    private static final Class<Application> applicationClass = Application.class;
    private static final Logger log = LoggerFactory.getLogger(applicationClass);

    public static void main(String[] args) {

        SpringApplication.run(applicationClass, args);

        //Interloper.objs.add(applicationClass);
        System.out.println("creating a lisp interpreter and starting swank");
        final Interpreter interpreter = Interpreter.createInstance();
        interpreter.eval("(load \"/mnt/entry.lisp\")");

        // just for demonstration...
        // you can add something to the arraylist from lisp and then
        // you can see it arrive here :)
        while(true){
            try{
                Thread.sleep(5000);
            } catch (Exception e) {
                System.out.println(e);
            } 
            System.out.println("this pass Interloper.objs contains:");
            for(Object o : Interloper.objs){
                System.out.print(o.getClass() + ": ");
                System.out.println(o);
                System.out.println();
            }

        }
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(applicationClass);
    }


}
