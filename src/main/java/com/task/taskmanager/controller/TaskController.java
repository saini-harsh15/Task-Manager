package com.task.taskmanager.controller;

import com.task.taskmanager.entity.Task;
import com.task.taskmanager.entity.User;
import com.task.taskmanager.repository.TaskRepository;
import com.task.taskmanager.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
public class TaskController {

    @Autowired
    private TaskRepository taskRepository;

    @Autowired
    private UserService userService;

    // DASHBOARD: List tasks for logged-in user and show create form
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        String username = (String) session.getAttribute("username");
        List<Task> tasks = taskRepository.findByUserId(userId);
        model.addAttribute("username", username);
        model.addAttribute("tasks", tasks);
        model.addAttribute("newTask", new Task());
        return "dashboard"; // /WEB-INF/jsp/dashboard.jsp
        
    }

    // CREATE task
    @PostMapping("/tasks")
    public String createTask(@RequestParam("title") String title,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam(value = "status", required = false) String status,
                             @RequestParam(value = "priority", required = false) String priority,
                             HttpSession session,
                             Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        User user = userService.findById(userId);
        if (user == null) {
            return "redirect:/logout"; // session stale
        }
        // sanitize inputs
        String safeTitle = title != null ? title.trim() : null;
        String safeDescription = description != null ? description.trim() : null;
        String safeStatus = status != null ? status.trim().toUpperCase() : null;
        // allow only known statuses
        if (!"PENDING".equals(safeStatus) && !"DONE".equals(safeStatus) && !"LATER".equals(safeStatus)) {
            safeStatus = "PENDING";
        }
        String safePriority = priority != null ? priority.trim().toUpperCase() : null;
        if (!"HIGH".equals(safePriority) && !"MEDIUM".equals(safePriority) && !"LOW".equals(safePriority)) {
            safePriority = "MEDIUM";
        }
        Task task = new Task();
        task.setTitle(safeTitle);
        task.setDescription(safeDescription);
        task.setStatus(safeStatus);
        task.setPriority(safePriority);
        task.setUser(user);
        taskRepository.save(task);
        return "redirect:/dashboard";
    }

    // EDIT form
    @GetMapping("/tasks/{id}/edit")
    public String editTask(@PathVariable("id") Long id, HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        Optional<Task> opt = taskRepository.findById(id);
        if (opt.isEmpty() || opt.get().getUser() == null || !opt.get().getUser().getId().equals(userId)) {
            return "redirect:/dashboard"; // not found or not owned
        }
        model.addAttribute("task", opt.get());
        return "edit-task"; // /WEB-INF/jsp/edit-task.jsp
    }

    // UPDATE
    @PostMapping("/tasks/{id}/update")
    public String updateTask(@PathVariable("id") Long id,
                             @RequestParam("title") String title,
                             @RequestParam(value = "description", required = false) String description,
                             @RequestParam("status") String status,
                             @RequestParam(value = "priority", required = false) String priority,
                             HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        Optional<Task> opt = taskRepository.findById(id);
        if (opt.isPresent()) {
            Task t = opt.get();
            if (t.getUser() != null && t.getUser().getId().equals(userId)) {
                t.setTitle(title != null ? title.trim() : t.getTitle());
                t.setDescription(description != null ? description.trim() : null);
                t.setStatus((status != null && !status.isBlank()) ? status : t.getStatus());
                String safePriority = priority != null ? priority.trim().toUpperCase() : null;
                if (safePriority == null || safePriority.isBlank()) {
                    safePriority = t.getPriority();
                } else if (!"HIGH".equals(safePriority) && !"MEDIUM".equals(safePriority) && !"LOW".equals(safePriority)) {
                    safePriority = t.getPriority();
                }
                t.setPriority(safePriority);
                taskRepository.save(t);
            }
        }
        return "redirect:/dashboard";
    }

    // DELETE
    @PostMapping("/tasks/{id}/delete")
    public String deleteTask(@PathVariable("id") Long id, HttpSession session) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/login";
        }
        Optional<Task> opt = taskRepository.findById(id);
        if (opt.isPresent()) {
            Task t = opt.get();
            if (t.getUser() != null && t.getUser().getId().equals(userId)) {
                taskRepository.deleteById(id);
            }
        }
        return "redirect:/dashboard";
    }
}
