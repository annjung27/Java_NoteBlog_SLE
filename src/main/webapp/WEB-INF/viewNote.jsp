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
    <title>Something Learned Everyday- Detail</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container mb-4">
  	<%---------------------menu bar -------------------------------------------------------------%>
  
	    <div class="d-flex justify-content-between align-items-center p-4 mb-4">
	    	<a href="/main" class="logo">Something Learned Everyday</a>
	    	<div>    	
		    	<a href="/mynotes">My notes</a>
		    	<c:if test="${user_id != null }">
		    	<a href="/logout" class="ms-3">Logout</a>
		    	</c:if>
		    </div>
	    </div>
	
	
	<%---------------------Title and Content-------------------------------------------------------- --%>
		<div class="content-box">
			<div class="border-bottom p-3 mb-4">
				<h1 class="mb-4">${thisNote.title}</h1>
				<p class="text-muted">by ${thisNote.user.userName} 
				<span class="ms-3">${thisNote.createdAt}</span></p>				
			</div>
			<div class="p-3 mb-4 border-bottom">
				${thisNote.content}
			</div>
			<c:if test="${user_id == thisNote.user.id}">
			<div class="d-flex">
				<a href="/mynotes" class="btn text-white me-2" Style="background-color:#C89595">Back to my notes</a>				
				<a href="/edit/${thisNote.id}" class="btn text-white me-2" Style="background-color:#CDBBA7">Edit</a>
				<form action="/mynotes/delete/${thisNote.id}" method="post">
					<input type="hidden" name="_method" value="delete" />
					<input type="submit" value="Delete" class="btn text-white" Style="background-color:#CDBBA7">	
				</form>	
			</div>			
			</c:if>		
			<c:if test="${user_id != thisNote.user.id }">
				<a href="/main" class="btn text-white me-2" Style="background-color:#C89595">Go back</a>
			</c:if>	
	<%--------------------Comments----------------------- --%>	
			
			<div class="card mt-5">				
				<form:form action="/notes/${thisNote.id}/comment"  method="post" modelAttribute="comment">
					
					<div class="card-body"><form:textarea path="content" rows="1" class="form-control" /></div>
					<div class="card-footer d-flex justify-content-end"><input type="submit" value="Post" class="btn text-white" Style="background-color:#C89595"/></div>											
				</form:form>
			</div>
			<br/>
			<div class="card">
				<div class="card-header">Comments</div>		
						
				<ul class="list-group">
				<c:forEach items="${thisNote.comment}" var="comment">
				
				  <li class="list-group-item d-flex justify-content-between">				  
				  	<div>${comment.content }</div>
				  	<div class="d-flex">
					  	<div class="me-3 fst-italic fw-light">posted by: ${comment.user.userName} </div>
					  	<c:if test="${user_id == comment.user.id }">
					  	<form action="/notes/delete/${comment.note.id}/${comment.id}" method="post">
							<input type="hidden" name="_method" value="delete" />
							<input type="submit" value="Delete" class="btn btn-sm text-white" Style="background-color:#CDBBA7"/>
						</form>	
					  	</c:if>
				  	</div>				  	
				  </li>	
				
				 </c:forEach> 			  
				</ul>
				
			</div>					
		</div>			
		
	</div>			
		
   
</body>
</html>