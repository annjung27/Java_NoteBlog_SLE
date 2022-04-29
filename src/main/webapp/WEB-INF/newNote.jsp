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
    <title>Something Learned Everyday- New Note</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/main.css"> <!-- change to match your file/naming structure -->
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400;600;700&display=swap" rel="stylesheet">

    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
   <div class="container">	   
   
   <%---------------------menu bar -------------------------------------------------------------%>
	    <div class="d-flex justify-content-between align-items-center border-bottom p-4 mb-4">
    		<a href="/main" class="logo">Something Learned Everyday</a>
	    	<a href="/logout">Logout</a>
	    </div> 	
	    
	<%------------------  New Form---------------------------------------------------------------%>
		<form:form action="/mynotes/create" method="post" modelAttribute="note">
			<div class="form-group mb-3">				
				<form:input path="title" class="form-control" placeholder="Title"/>
				<form:errors path="title"  class="text-danger"/>
			</div>
			<div class="form-group mb-3">
				<form:textarea path="content" class="form-control" id="summernote" />
				<form:errors path="content"  class="text-danger"/>
			</div>
			<div class="form-group mb-3">
				<form:input type="file" path="filename" name="file" />
			</div>
			<input type="submit" value="Create" class="btn text-white me-2" Style="background-color:#C89595"/>
			<a href="/mynotes" class="btn text-white" Style="background-color:#CDBBA7">Cancel</a>			
		</form:form>   	
   
   </div>
   <script>
     $('#summernote').summernote({       
       tabsize: 2,
       height: 300
     });
   </script>
</body>
</html>