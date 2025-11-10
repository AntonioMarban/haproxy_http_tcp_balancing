package com.example;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@SpringBootApplication
public class App2 {
    @GetMapping("/hello")
    public String hello() {
        return "Hola desde app2"; // TODO: Cambiar mensaje en app1
    }

    public static void main(String[] args) {
        SpringApplication.run(App2.class, args);
    }
}
