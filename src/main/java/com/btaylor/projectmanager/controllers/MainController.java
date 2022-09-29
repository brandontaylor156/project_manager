package com.btaylor.projectmanager.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.btaylor.projectmanager.models.Project;
import com.btaylor.projectmanager.models.Task;
import com.btaylor.projectmanager.models.User;
import com.btaylor.projectmanager.services.ProjectService;
import com.btaylor.projectmanager.services.TaskService;
import com.btaylor.projectmanager.services.UserService;

@Controller
public class MainController {
	@Autowired
	UserService userService;
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	TaskService taskService;
	
	/******************************************************************************************/
	
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		User user = userService.findUserById((Long)session.getAttribute("id"));
		
		model.addAttribute("projects", projectService.allProjectsContainingUser(user));
		model.addAttribute("otherProjects", projectService.allProjectsNotContainingUser(user));
		model.addAttribute("user", user);
		
		return "/views/dashboard.jsp";
	}
	
	/******************************************************************************************/
	
	@GetMapping("/projects/new")
	public String newProject(
			@ModelAttribute("project") Project project, HttpSession session, Model model) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		model.addAttribute("id", (Long)session.getAttribute("id"));
		return "/views/newProject.jsp";
	}
	
	/******************************************************************************************/
	
	@PostMapping("/projects/new")
	public String addProject(
			@Valid @ModelAttribute("project") Project project, 
			BindingResult result, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		if (result.hasErrors())
			return "/views/newProject.jsp";
		else {
			User user = userService.findUserById(project.getLead().getId());
			List<User> userList = new ArrayList<User>();
			userList.add(user);
			project.setUsers(userList);
			projectService.createProject(project);
			return "redirect:/dashboard";
		}
	}
	
	/******************************************************************************************/
	
	@GetMapping("/projects/{id}")
	public String showProject(@PathVariable("id") Long id, Model model, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		Project project = projectService.findProjectById(id);
		User user = userService.findUserById((Long)session.getAttribute("id"));
		
		model.addAttribute("project", project);
		model.addAttribute("user", user);
		return "/views/showProject.jsp";
	}
	
	/******************************************************************************************/
	
	@GetMapping("/projects/{id}/tasks")
	public String showTasks(@PathVariable("id") Long id, HttpSession session, Model model, @ModelAttribute("task") Task task) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		Project project = projectService.findProjectById(id);
		model.addAttribute("project", project);
		model.addAttribute("id", (Long)session.getAttribute("id"));
		return "/views/tasks.jsp";
	}
	
	/******************************************************************************************/
	
	@PostMapping("/projects/{id}/tasks")
	public String createTask(@Valid @ModelAttribute("task") Task task, BindingResult result, 
			HttpSession session, Model model, @PathVariable("id") Long id) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		Project thisProject = projectService.findProjectById(id);
		
		if (result.hasErrors()) {
			model.addAttribute("project", thisProject);
			model.addAttribute("id", (Long)session.getAttribute("id"));
			return "/views/tasks.jsp";
		}
		else {
			taskService.createTask(task);
			return "redirect:/projects/" + id + "/tasks";
		}
		
	}
	
	/******************************************************************************************/
	
	@GetMapping("/projects/{id}/edit")
	public String editProject(@PathVariable("id") Long id, HttpSession session, Model model) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		Project project = projectService.findProjectById(id);
		model.addAttribute("project", project);
		model.addAttribute("id", (Long)session.getAttribute("id"));
		return "/views/editProject.jsp";
	}
	
	/******************************************************************************************/
	
	@PutMapping("/projects/{id}/edit")
	public String updateProject(@Valid @ModelAttribute("project") Project project, 
			BindingResult result, HttpSession session, @PathVariable("id") Long id, Model model) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		Project thisProject = projectService.findProjectById(id);
		
		if (result.hasErrors()) {
			model.addAttribute("currentProject", thisProject);
			model.addAttribute("id", (Long)session.getAttribute("id"));
			return "/views/editProject.jsp";
		}
		else {
			project.setUsers(thisProject.getUsers());
			projectService.updateProject(project);
			return "redirect:/dashboard";
		}
		
	}
	
	/******************************************************************************************/
	
	@PutMapping("/projects/{id}/join")
	public String joinProject(@PathVariable("id") Long id, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		User thisUser = userService.findUserById((Long)session.getAttribute("id"));
		Project thisProject = projectService.findProjectById(id);
		thisProject.getUsers().add(thisUser);
		projectService.updateProject(thisProject);
		
		return "redirect:/dashboard";
	}
	
	/******************************************************************************************/
	
	@PutMapping("/projects/{id}/leave")
	public String leaveProject(@PathVariable("id") Long id, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
	
		User thisUser = userService.findUserById((Long)session.getAttribute("id"));
		Project thisProject = projectService.findProjectById(id);
		
		List<User> users = thisProject.getUsers();
		for(int i = 0; i < users.size(); i++) {
			if (users.get(i).equals(thisUser))
				users.remove(i);
		}
		thisProject.setUsers(users);
		
		projectService.updateProject(thisProject);
		
		return "redirect:/dashboard";
	}
	
	/******************************************************************************************/
	
	@DeleteMapping("/projects/{id}/delete")
	public String delete(@PathVariable("id") Long id, HttpSession session) {
		if (session.getAttribute("id")==null)
			return "redirect:/";
		
		projectService.deleteProject(id);
		return "redirect:/dashboard";
	}
	
}
