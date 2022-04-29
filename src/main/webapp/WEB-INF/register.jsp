<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formatting (dates) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Something Learned Everyday- Sign Up</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="container">
   	<div class="reg-form-box border rounded">
		<a href="/main" class="logo" style="font-size: 20px">Something Learned Everyday</a>
		<form:form action="/register" method="post" modelAttribute="newUser">
			<div class="form-group mt-4 mb-3" >			  
			  <form:input path="userName" class="form-control" placeholder="User Name"/>
			  <form:errors path="userName"  class="text-danger"/>
			</div>
			<div class="form-group mb-3">			 
			 <form:input path="email" class="form-control"  placeholder="Email Address"/>
			 <form:errors path="email" class="text-danger"/>
			</div>   		
			<div class="form-group mb-3">
			 
			 <form:input type="password" path="password" class="form-control"  placeholder="Password"/>
			 <form:errors path="password" class="text-danger"/>
			</div>
			<div class="form-group mb-4">			 
			 <form:input  type="password" path="confirm" class="form-control"  placeholder="Confirm Password"/>
			 <form:errors path="confirm" class="text-danger"/>
			</div>
			<input type="submit" value="Create Account" class="btn text-white w-100 mb-4" Style="background-color:#C1A3A3" />
			<p>Already have an account? <a href="/login">Log in</a></p>
	 	</form:form>   
 	</div>
 	
 	
 		   			
   </div>
</body>
</html>