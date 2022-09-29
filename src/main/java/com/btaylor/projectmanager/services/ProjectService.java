package com.btaylor.projectmanager.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btaylor.projectmanager.models.Project;
import com.btaylor.projectmanager.models.User;
import com.btaylor.projectmanager.repositories.ProjectRepository;

@Service
public class ProjectService {
	
	@Autowired
	ProjectRepository projectRepository;
	
	public List<Project> allProjects() {
		return projectRepository.findAll();
	} 
	
	public Project findProjectById(Long id) {
		return projectRepository.findByIdIs(id);
	}
	
	public List<Project> allProjectsContainingUser(User user){
		return projectRepository.findAllByUsersOrderByDueDateAsc(user);
	}
	
	public List<Project> allProjectsNotContainingUser(User user){
		return projectRepository.findByUsersNotContainsOrderByDueDateAsc(user);
	}
	
	public Project createProject(Project p) {
		return projectRepository.save(p);
	}
	
	public Project updateProject(Project p) {
    	return projectRepository.save(p);
    }
	
	public void deleteProject(Long id) {
    	projectRepository.deleteById(id);
    }
}
