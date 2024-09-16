package com.inventario.imobilizado.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RedirectController {

    @GetMapping("/")
    public String redirectToLoginPage() {
        return "redirect:/page/login";
    }
}
