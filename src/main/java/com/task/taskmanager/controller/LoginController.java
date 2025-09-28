package com.task.taskmanager.controller;

import com.task.taskmanager.entity.User;
import com.task.taskmanager.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLogin(Model model, HttpSession session) {
        if (session != null && session.getAttribute("userId") != null) {
            return "redirect:/dashboard";
        }
        return "login"; // Maps to /WEB-INF/jsp/login.jsp
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               Model model,
                               HttpSession session) {
        // Normalize inputs to avoid whitespace-related login failures
        String normalizedUsername = username == null ? null : username.trim();
        String normalizedPassword = password == null ? null : password.trim();

        // Query user by username
        User user = userService.findByUsername(normalizedUsername);

        // Basic credential check (plain text). In production, use password hashing.
        if (user == null || user.getPassword() == null || !user.getPassword().equals(normalizedPassword)) {
            model.addAttribute("error", "Invalid username or password.");
            model.addAttribute("username", normalizedUsername); // pre-fill username on error
            return "login";
        }

        // Set session attributes for logged-in user
        session.setAttribute("userId", user.getId());
        session.setAttribute("username", user.getUsername());

        return "redirect:/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/login";
    }
}
