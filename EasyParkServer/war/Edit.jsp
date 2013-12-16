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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EasyPark</title>
<!-- Bootstrap core CSS -->
<link href="../../bootstrap/css/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="navbar.css" rel="stylesheet">
</head>
<body>
    <div class="container">

      <!-- Static navbar -->
      <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><img src="img/photofeed.png" alt="Connexus" /></a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="Manage.jsp">Manage</a></li>
            <li><a href="Create.jsp">Create</a></li>
            <li class="active"><a href="Edit.jsp">Add/Edit</a></li>
            <li><a href="Search.jsp">Search</a></li>
            <li><a href="Trending.jsp">Trending</a></li>
            <li><a href="Social.jsp">Social</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
    		<%if(currentUser != null) { %>  
            <li><a>Hello <%= currentUser.getNickname() %> , 
                  <%= currentUser.getEmail() %></a></li>
            <li class="active">
                  <a href=<%= userService.createLogoutURL("/Edit.jsp")%>>Sign out</a>
   			<% } else {%>
            <li class="active">
                  <a href=<%= userService.createLoginURL("/Edit.jsp")%>>Sign in</a>   
   			<% } %>  
    		</li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>

	<% int error_in_page=0;
	String same_name = request.getParameter("duplicate");
	//if (same_name != null) error_in_page = Integer.valueOf(same_name);
	
	if (error_in_page==0) { %>
      <div class="view-title">
        <p>ADD/EDIT LOT</p>
        <% if (currentUser != null) { 
    	    String name = request.getParameter("name");
    	    if (name == null)
    	    	name = "lot name here...";
    	    String location = request.getParameter("location");
    	    if (location == null)
    	    	location = "location address here...";
    	    String price = request.getParameter("price");
    	    if (price == null)
    	    	price = "hourly price here...";
    	    String spots = request.getParameter("spots");
    	    if (spots == null)
    	    	spots = "number of spots here...";
		 %>
        <form action="/editlot"
              method="post">     
	        <input id="lot" class="input text" name="name" type="text" value="<%= name%>">
	        <p>Edit lot name</p>
	        <input id="lot" class="input text" name="location" type="text" value="<%= location%>">
	        <p>Edit location address</p>
	        <input id="lot" class="input text" name="price" type="text" value="<%= price%>">
	        <p>Edit hourly price for parking on a spot on this lot</p>
	        <input id="lot" class="input text" name="spots" type="text" value="<%= spots%>">
	        <p>Edit number of parking spots on this lot</p>
	        <input id="btn-post" class="active btn" type="submit" value="Submit Changes">
	    </form>
	    <% } else { %>
	     <p>Please login in order to add/edit parking lot data...</p>	    
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