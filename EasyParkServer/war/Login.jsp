<%@ page contentType="text/html;charset=UTF-8" language="java"
  isELIgnored="false"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.easypark.*"%>
<%@ page import="com.google.appengine.api.users.*"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreNeedIndexException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>EasyPark</title>
  </head>

  <body>
    <h1>Welcome to EasyPark!</h1>
    
	<p>
	<font size="2"> <strong> Login with Gmail user ID and password: </strong></font>
	<BR>
	<font size="2">  <strong> By clicking the link below: </strong></font>
    <a href=<%= UserServiceFactory.getUserService().createLogoutURL("/Create.jsp")%>>Sign in</a>
	</p>
	
  </body>
</html>
