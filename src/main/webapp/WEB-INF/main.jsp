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
    <title>Something Learned Everyday- Main</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="container mb-4"> 
   
  <%---------------------menu bar -------------------------------------------------------------%>
  
    <div class="d-flex justify-content-between align-items-center border-bottom p-4 mb-4">
    	<a href="/main" class="logo">Something Learned Everyday</a>
    	<div>
    		<c:if test="${user_id == null }">    	
	    	<a href="/login">Login</a>
	    	</c:if>
	    	<c:if test="${user_id != null }">
	    	<a href="/mynotes">My Notes</a>
	    	<a href="/logout" class="ms-3">Logout</a>
	    	</c:if>
	    </div>
    </div>
    
  <%--------------------- header --------------------------------------------------------------%>
  
    <div class="row mb-5 align-items-center border-bottom pb-4">
    	<div class="col text-center">
	    	<h3>Learn Something New Everyday</h3> 
	    	<p>Share your newfound knowledge with others.</p>
	    	<a href="/mynotes" class="btn text-white" Style="background-color:#C89595">Start my note</a>   	
    	</div>
    	<div class="col">
	    	<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="https://cdn.pixabay.com/photo/2015/02/02/11/08/office-620817_960_720.jpg" class="d-block w-100 rounded" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="https://cdn.pixabay.com/photo/2015/01/09/11/08/startup-594090_960_720.jpg" class="d-block w-100 rounded" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="https://cdn.pixabay.com/photo/2017/05/11/11/15/workplace-2303851_960_720.jpg" class="d-block w-100 rounded" alt="...">
			    </div>
			  </div>
			</div>
    	</div>
    </div>    
    
  <%--------------------- cards and carousel------------------------------------------------------%> 
  	
  	<h4 class="ms-3">Popular posts</h4>
    <div class="card-grid">    
	    <c:forEach items="${allNotes}" var="note">	    		    	    	
			 <a href="/notes/${note.id}" class="card bg-dark text-white m-3">		 
				<img src="https://cdn.pixabay.com/photo/2013/10/02/23/03/mountains-190055_960_720.jpg" class="card-img" alt="...">
				<div class="card-img-overlay">
					<h5 class="card-title">${note.title}</h5>			
					<p class="card-text">by ${note.user.userName}</p>
					<p class="card-text">${note.createdAt}</p>			
			 	</div>	
			 </a>	
								   	    
		 </c:forEach>	        	
	</div> 
	 	  
 </div>
	
   
  
</body>
</html>