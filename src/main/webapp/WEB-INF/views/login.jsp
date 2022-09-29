<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "t" tagdir="/WEB-INF/tags" %>

<title>Project Manager</title>
<t:base>
<div class="container d-flex vh-100 justify-content-center flex-column">
	<h6 class="display-6">Project Manager</h6>
	<p class="lead">A place for teams to manage projects.</p>
	
	<div class="row">
		<div class="col">
			<h6 class="display-6">Register</h6>
			<form:form action="/register" method="post" modelAttribute="newUser">
				<div class="mb-3">
					<form:label for="firstName" path="firstName" class="form-label">First Name:</form:label>
					<form:errors path="firstName" class="text-danger" />
					<form:input type="text" class="form-control" path="firstName" />
				</div>
				<div class="mb-3">
					<form:label for="lastName" path="lastName" class="form-label">Last Name:</form:label>
					<form:errors path="lastName" class="text-danger" />
					<form:input type="text" class="form-control" path="lastName" />
				</div>
				<div class="mb-3">
					<form:label for="email" path="email" class="form-label">Email:</form:label>
					<form:errors path="email" class="text-danger" />
					<form:input type="text" class="form-control" path="email" />
				</div>
				<div class="mb-3">
					<form:label for="password" path="password" class="form-label">Password:</form:label>
					<form:errors path="password" class="text-danger" />
					<form:input type="password" class="form-control" path="password" />
				</div>
				<div class="mb-3">
					<form:label for="confirm" path="confirm" class="form-label">Confirm:</form:label>
					<form:errors path="confirm" class="text-danger" />
					<form:input type="password" class="form-control" path="confirm" />
				</div>
				<button type="submit" class="btn btn-primary">Register</button>
			</form:form>
		</div>
		<div class="col">
			<h6 class="display-6">Log In</h6>
			<form:form action="/login" method="post" modelAttribute="newLogin">
				<div class="mb-3">
					<form:label for="email" path="email" class="form-label">Email:</form:label>
					<form:errors path="email" class="text-danger" />
					<form:input type="text" path="email" class="form-control" />
				</div>
				<div class="mb-3">
					<form:label for="password" path="password" class="form-label">Password:</form:label>
					<form:errors path="password" class="text-danger" />
					<form:input type="password" path="password" class="form-control" />
				</div>
				<button type="submit" class="btn btn-primary">Log In</button>
			</form:form>
		</div>
	</div>
</div>
</t:base>
	
