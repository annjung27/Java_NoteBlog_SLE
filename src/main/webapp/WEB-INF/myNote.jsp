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
    <title>Something Learned Everyday - My Notes</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="container mb-4">
	   <%---------------------menu bar -------------------------------------------------------------%>
	     <div class="d-flex justify-content-between align-items-center p-4 mb-4 text-white" style="background-color: #DDBEBE;">
	    	<a href="/main" class="logo">Something Learned Everyday</a>
	    	<a href="/logout">Logout</a>
	    </div> 	 
	    
	    
	   
	   	<div class="content-box">
	   	
		  <%--------------------- Header(user info) -------------------------------------------------------------%>
		     <div class="text-end">
		     	<h1 class="mb-5 fw-normal">Welcome back, ${thisUser.userName}</h1>
		   		<a href="/mynotes/new" class="btn text-white mb-5" Style="background-color:#C89595">+ Create new note</a>
		     </div>
		     
		  
		     <h3 class="mb-4 fw-normal">What I Learned</h3>
		     <hr/>
		<%------------------------ List of my Notes  ----------------------------------------------------------------------- --%>	     
		     
		     	<c:forEach items="${thisUser.notes}" var="note">
		     	
			     <div class="card mb-4" style="width:100%">			     
					  <div class="row g-0">					    
					    <div class="col-md-8">
					      <div class="card-body">
					        <a href="/notes/${note.id}" class="card-title h3">${note.title}</a>
					        
					        <div class="d-flex align-items-baseline mt-3">
						        <p class="card-text me-3"><small class="text-muted">${note.createdAt}</small></p>
						        <form action="/mynotes/delete/${note.id}" method="post">
						        	<input type="hidden" name="_method" value="delete" />
						        	<input type="submit" value="&#128465;" class="bg-white border-0 ">	
						        </form>				        
					        </div>
					      </div>
					    </div>
					    <div class="col-md-4 d-flex align-items-center justify-content-evenly">
     						<img src="https://cdn.pixabay.com/photo/2017/07/02/21/34/notebook-2465914_960_720.jpg" class="img-fluid rounded" alt="...">
    					</div>
					  </div>				
				</div>
				
				</c:forEach>
				   		
	   		</div>
   
   
   </div> 
  
</body>
</html>