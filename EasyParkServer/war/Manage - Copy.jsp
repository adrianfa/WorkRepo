<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
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
            <li class="active"><a href="Manage.jsp">Manage</a></li>
            <li><a href="Create.jsp">Create</a></li>
            <li><a href="Edit.jsp">Add/Edit</a></li>
            <li><a href="Search.jsp">Search</a></li>
            <li><a href="Trending.jsp">Trending</a></li>
            <li><a href="Social.jsp">Social</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
    		<%if(currentUser != null) { %>  
            <li><a>Hello <%= currentUser.getNickname() %> , 
                  <%= currentUser.getEmail() %></a></li>
            <li class="active">
                  <a href=<%= userService.createLogoutURL("/Create.jsp")%>>Sign out</a>
   			<% } else {%>
            <li class="active">
                  <a href=<%= userService.createLoginURL("/Create.jsp")%>>Sign in</a>   
   			<% } %>  
    		</li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>

	<% int error_in_page=0;
	String same_name = request.getParameter("duplicate_account");
	if (same_name != null) error_in_page = Integer.valueOf(same_name);
	
	if (error_in_page==0) { %>
      <div class="view-title">
        <p>MANAGE OWNER ACOUNT</p>
        <% if (currentUser != null) { 
		 %>
        <form action="/manageowneraccount"
              method="post">    
            <p>My Parking Lots:</p>
	        <table border="1">
			 <tr>
			 	<th>Name</th>
			 	<th>Location</th>
			 	<th>Number of Spots</th>
			 	<th>Price per Hour</th>
			 	<th>Delete</th>
			 </tr>
        <%      
 			int table_count = 0;
			List<ParkingLot> lots = OfyService.ofy().load().type(ParkingLot.class).list();
		    for (ParkingLot lot : lots) {
		    	table_count++;
        %>      
			 <tr>
			 	<th><a href=<%= Utils.getLotEditUrl(false, lot.lotName, lot.location, lot.price, String.valueOf(lot.spots)) %>> <%= lot.lotName %></a></th>
			 	<th><%= lot.location %></th>
			 	<th><%= lot.spots %></th>
			 	<th><%= lot.price %></th>
			 	<th><input type="checkbox" name="delete-box" value=<%= lot.lotId %>></th>
			 </tr>
			<%	} %>
			</table> 
              
		<%
	      	String btn_type = "submit";
		 	if (table_count == 0) {
		 		btn_type = "hidden";
		 	}
		%>
	        <input id="add-lots" class="active btn" type="submit" value="Add Lot">
	        <input id="delete-lots" class="active btn" type=<%= btn_type %> value="Delete Checked">
	    </form>
	    <% } else { %>
	     <p>Please login in order to manage your account...</p>	    
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