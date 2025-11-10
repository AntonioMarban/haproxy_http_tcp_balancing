package com.example;

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.web.bind.annotation.*;

@RestController
@SpringBootApplication
public class App1 {
    @GetMapping("/hello")
    public String hello() {
        return "Hola desde app1"; // TODO: Cambiar mensaje en app2
    }

    public static void main(String[] args) {
        SpringApplication.run(App1.class, args);
    }
}
