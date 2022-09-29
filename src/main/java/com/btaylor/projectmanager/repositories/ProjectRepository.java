package com.btaylor.projectmanager.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.btaylor.projectmanager.models.Project;
import com.btaylor.projectmanager.models.User;

@Repository
public interface ProjectRepository extends CrudRepository<Project, Long>{
	List<Project> findAll();
	Project findByIdIs(Long id);
	List<Project> findAllByUsersOrderByDueDateAsc(User user);
	List<Project> findByUsersNotContainsOrderByDueDateAsc(User user); 
}