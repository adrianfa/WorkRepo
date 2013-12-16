<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.easypark.*"%>
<%@ page import="com.google.appengine.api.users.*"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreNeedIndexException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	UserService userService = UserServiceFactory.getUserService();
	User currentUser = userService.getCurrentUser();
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>Park and Pay</title>
		<link rel="stylesheet" href="css/style.css" type="text/css" />
		<!--[if IE 7]>
			<link rel="stylesheet" href="css/ie7.css" type="text/css" />
		<![endif]-->

</head>
<body>
 		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
				<ul>
					<li class="selected"><a href="index.html">Home</a></li>
					<li><a href="Login.jsp">Login</a></li>
					<li><a href="services.html">Services</a></li>
					<li><a href="about.html">About</a></li>
					<li><a href="blog.html">Blog</a></li>

				</ul>
			</div>  

 	<% int error_in_page=0;
	String same_name = request.getParameter("duplicate_account");
	if (same_name != null) error_in_page = Integer.valueOf(same_name);
	
	if (error_in_page==0) { %>
      <div class="view-title">
        <p>CREATE OWNER ACOUNT</p>
        <% if (currentUser != null) { 
		 %>
        <form action="/createowneraccount"
              method="post">     
	        <input id="accoount-name" class="input text" name="account" type="text" value="Stream name here...">
	        <p>Name your account</p>
	        <input id="btn-post" class="active btn" type="submit" value="Create Account">
	    </form>
	    <% } else { %>
	     <p>Please login in order to create new accounts...</p>	    
	    <% } %>
     </div>
     <% } else { %>
     <div class="view-title">
      
     <img class="errormsg" 
          src="img/CreateError.png"
          alt="Error Image" />
     
     </div>
     <%} %>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

</body>
</html>