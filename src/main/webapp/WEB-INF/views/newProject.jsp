<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>New Project</title>
<t:base>
<div class="container mt-3">
	<h3 class="display-3">Create a Project</h3>
	<form:form action="/projects/new" method="post" modelAttribute="project">
		<form:input type="hidden" path="lead" value="${id}"/>
		<div class="mb-3">
			<form:label for="title" class="form-label" path="title">Title:</form:label>
			<form:errors path="title" class="text-danger" />
			<form:input type="text" class="form-control" path="title"/>
		</div>
		<div class="mb-3">
			<form:label for="description" class="form-label" path="description">Description:</form:label>
			<form:errors path="description" class="text-danger" />
			<form:textarea class="form-control" path="description"/>
		</div>
		<div class="mb-3">
			<form:label for="dueDate" class="form-label" path="dueDate">Due Date:</form:label>
			<form:errors path="dueDate" class="text-danger" />
			<form:input type="date" class="form-control" path="dueDate"/>
		</div>
		<div class="in-line">
			<a class="btn btn-danger" href="/dashboard">Cancel</a>
			<button type="submit" class="btn btn-primary">Create</button>
		</div>
	</form:form>
</div>
</t:base>
	
