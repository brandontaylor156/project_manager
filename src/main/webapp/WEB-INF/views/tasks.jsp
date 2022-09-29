<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Project Tasks</title>
<t:base>
<div class="container d-flex vh-100 justify-content-start flex-column py-3">
	<a href="/dashboard" class="lead">Dashboard</a>
	<h3 class="display-3">Project: ${project.title}</h3>
	<p class="lead"><span class="fw-bold">Project Lead:</span> ${project.lead.firstName}</p>
	
	<form:form action="/projects/${project.id}/tasks" method="post" modelAttribute="task">
		<form:input type="hidden" path="creator" value="${id}"/>
		<form:input type="hidden" path="project" value="${project.id}"/>
		<div class="mb-3">
			<form:label for="description" class="form-label lead" path="description">Add a task for this team:</form:label>
			<form:errors path="description" class="text-danger" />
			<form:textarea class="form-control" path="description"/>
		</div>
		<button type="submit" class="btn btn-primary">Submit</button>
	</form:form>
	
	<div class="container-fluid g-0 overflow-auto">
	<c:forEach var="task" items="${project.tasks}">
		<p><span class="fw-bold">Added by ${task.creator.firstName} - <fmt:formatDate type="both" 
         dateStyle = "long" timeStyle = "long" value ="${task.createdAt}"/></span></p>
		<p>${task.description}</p>
	</c:forEach>
	</div>
</div>
</t:base>
	
