<%@ page contentType="text/html;charset=UTF-8" language="java"
  isELIgnored="false"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.easypark.*"%>
<%@ page import="com.google.appengine.api.users.*"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreNeedIndexException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>About - Generic Website Template</title>
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
					<li><a href="index.html">Home</a></li>
					<li class="selected"><a href="Login.jsp">Login</a></li>
					<li><a href="about.html">About</a></li>
					<li><a href="blog.html">Blog</a></li>
					<li><a href="services.html">Services</a></li>
				</ul>
			</div>
			<div class="body">
				
				<h3>Please LOGIN with your GMAIL user account</h3>
				<p>
				<BR>
				<h3>By clicking the link below: </h3>
    			<a href=<%= UserServiceFactory.getUserService().createLoginURL("/Manage.jsp")%>>SIGN IN</a>
				</p>
				<h3>You can read more about this service</h3>
				<p>
				<BR>
				<h3>by clicking the link below: </h3>
    			<a href=services.html>READ MORE</a>
				</p>
				
			</div>
			<div class="footer">
				<ul>
					<li><a href="index.html">Home</a></li>
					<li><a href="Login.jsp">Login</a></li>
					<li><a href="about.html">About</a></li>
					<li><a href="blog.html">Blog</a></li>
					<li><a href="services.html">Gallery</a></li>
				</ul>
				<p>&#169; Copyright &#169; 2013. Farkash</p>
				<div class="connect">
					<a href="http://facebook.com/freewebsitetemplates" id="facebook">facebook</a>
					<a href="http://twitter.com/fwtemplates" id="twitter">twitter</a>
					<a href="http://www.youtube.com/fwtemplates" id="vimeo">vimeo</a>
				</div>
			</div>
		</div>

	
	
  </body>
</html>
