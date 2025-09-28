package com.task.taskmanager.repository;

import com.task.taskmanager.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    
    // Custom query method: Find all tasks belonging to a specific user
    List<Task> findByUserId(Long userId);
}