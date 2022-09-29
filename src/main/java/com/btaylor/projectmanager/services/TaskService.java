package com.btaylor.projectmanager.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btaylor.projectmanager.models.Task;
import com.btaylor.projectmanager.repositories.TaskRepository;

@Service
public class TaskService {
    @Autowired
    TaskRepository taskRepository;
   
    public List<Task> allTasks() {
        return taskRepository.findAll();
    }
    
    public Task createTask(Task t) {
        return taskRepository.save(t);
    }
   
    public Task findTask(Long id) {
        return taskRepository.findByIdIs(id);
    }
}