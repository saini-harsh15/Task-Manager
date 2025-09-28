package com.task.taskmanager.service;

import com.task.taskmanager.entity.User;
import com.task.taskmanager.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public User save(User user) {
        // In a real application, we would hash the password here.
        // For now, we just save the user.
        return userRepository.save(user);
    }

    public User findByUsername(String username) {
        // This method will be useful for a simple "login" check later
        // and for checking if a user already exists during registration.
        return userRepository.findByUsername(username);
    }

    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
}