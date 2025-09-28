package com.task.taskmanager.repository;

import com.task.taskmanager.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    // Custom method to find a User by their username
    User findByUsername(String username);
}