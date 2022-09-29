<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Project Manager Dashboard</title>
<t:base>
<div class="container">
	<h3 class="display-3">Welcome, ${user.firstName}</h3>
	<div class="in-line">
		<a class="lead" href="/projects/new">New Project</a>
		<a class="lead" href="/logout">Logout</a>
	</div>
	
	<h6 class="display-6">All Projects</h6>
	<table class="table table-striped">
		<colgroup>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
    	</colgroup>
		<thead>
			<tr>
				<th>Project</th>
				<th>Team Lead</th>
				<th>Due Date</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="project" items="${otherProjects}">
			<tr>
				<td class="align-middle"><a href="/projects/${project.id}">${project.title}</a></td>
				<td class="align-middle">${project.lead.firstName} ${project.lead.lastName}</td>
				<td class="align-middle"><fmt:formatDate type="date" dateStyle="long" value="${project.dueDate}"/></td>
				<td class="align-middle">
					<form class="mb-0" action="/projects/${project.id}/join" method="post">
    					<input type="hidden" name="_method" value="put">
    					<button class="btn btn-primary" type="submit">Join Team</button>
					</form>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<h6 class="display-6">Your Projects</h6>
	<table class="table table-striped">
		<colgroup>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
      		<col class="col-3"></col>
    	</colgroup>
		<thead>
			<tr>
				<th>Project</th>
				<th>Team Lead</th>
				<th>Due Date</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="project" items="${projects}">
			<tr>
				<td class="align-middle"><a href="/projects/${project.id}">${project.title}</a></td>
				<td class="align-middle">${project.lead.firstName} ${project.lead.lastName}</td>
				<td class="align-middle"><fmt:formatDate type="date" dateStyle="long" value="${project.dueDate}"/></td>
				<td class="d-flex align-items-center gap-2">
					<c:choose> 
						<c:when test="${project.lead.id == user.id}">
							<a href="/projects/${project.id}/edit" class="btn btn-info">Edit</a>
							<form class="mb-0" action="/projects/${project.id}/delete" method="post">
    							<input type="hidden" name="_method" value="delete">
    							<button class="btn btn-danger" type="submit">Delete</button>
							</form>
						</c:when>
						<c:otherwise>
							<form class="mb-0" action="/projects/${project.id}/leave" method="post">
    							<input type="hidden" name="_method" value="put">
    							<button class="btn btn-warning" type="submit">Leave</button>
							</form>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</t:base>