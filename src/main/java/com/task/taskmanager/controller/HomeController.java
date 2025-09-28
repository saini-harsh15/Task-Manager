package com.task.taskmanager.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // Handles requests to the root URL (e.g., http://localhost:8080/)
    @GetMapping("/")
    public String redirectToLogin(HttpSession session) {
        if (session != null && session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }
        return "redirect:/login";
    }
}