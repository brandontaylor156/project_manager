<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Project Details</title>
<t:base>
<div class="container mt-3">
	<a href="/dashboard" class="lead">Dashboard</a>
	<p class="lead"><span class="fw-bold">Project:</span>  ${project.title}</p>
	<p class="lead"><span class="fw-bold">Description:</span>  ${project.description}</p>
	<p class="lead"><span class="fw-bold">Due Date:</span>  <fmt:formatDate type="date" dateStyle="long" value="${project.dueDate}"/></p>
		
	<c:if test="${project.lead.id == user.id}">
	<div class="d-flex align-items-center gap-2 mb-3">
		<a href="/projects/${project.id}/edit" class="btn btn-info">Edit</a>
		<form class="mb-0" action="/projects/${project.id}/delete" method="post">
    		<input type="hidden" name="_method" value="delete">
    		<button class="btn btn-danger" type="submit">Delete</button>
		</form>
	</div>
	</c:if>
	
	<c:if test="${project.users.contains(user)}">
		<a href="/projects/${project.id}/tasks" class="lead">See tasks</a>
	</c:if>
	
</div>
</t:base>
	
	
