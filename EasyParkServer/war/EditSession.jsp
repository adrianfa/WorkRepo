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
					<li><a href="index.html">Home</a></li>
					<li><a href="Manage.jsp">Manage</a></li>
					    <%if(currentUser != null) { %>  
            		<li><a>Hello <%= currentUser.getNickname() %> , 
                  		<%= currentUser.getEmail() %></a></li>
            		<li class="active">
                  		<a href=<%= userService.createLogoutURL("/Create.jsp")%>>Sign out</a>
   						<% } else {%>
            		<li class="active">
                  		<a href=<%= userService.createLoginURL("/Create.jsp")%>>Sign in</a>   
   						<% } %>     						
				</ul>
			</div>
			<div class="body">
				<div id="featured_oe">

			<% int error_in_page=0;
			String same_name = request.getParameter("duplicate");
			if (same_name != null) error_in_page = Integer.valueOf(same_name);
	
			if (error_in_page==0) { %>
    	 <div class="view-title">
        <h3>EDIT A SESSION</h3>
        <% 
        
        /* 
        
	public ParkingSession(Long sessionId, Long userId, Long lotId, boolean alertSent, long stayTime, long alertAhead) {
		.sessionId 
		.userId 
		.lotId 
		.alertSent
		.startTime
		.expirationTime.setTime(startTime.getTime() + stayTime);
		.alertTime.setTime(startTime.getTime() + stayTime - alertAhead);	
		.paidAmmount = 0L;
*/
        
        if (currentUser != null) { 
    	    
        	String name = request.getParameter("name");
    	    if (name == null) 		name = "lot name here...";
    	    
    	    String location = request.getParameter("location");
    	    if (location == null) 	location = "location address here...";
       	    
    	    String loc_lat = request.getParameter("loc_lat");
    	    if (loc_lat == null)	loc_lat = "latitude ...";
       	    
    	    String loc_long = request.getParameter("loc_long");
    	    if (loc_long == null)	loc_long = "longitude ...";
    	    
    	    String price = request.getParameter("price");
    	    if (price == null)		price = "hourly price here...";
    	    
    	    String spots = request.getParameter("spots");
    	    if (spots == null)		spots = "number of spots here...";
    	    
    	    String opening_h = request.getParameter("opening_h");
    	    if (opening_h == null)	opening_h = "opening hour ...";
       	    
    	    String closing_h = request.getParameter("closing_h");
    	    if (closing_h == null)	closing_h = "closing hour ...";

		 %>
        <form action="/editlot" method="post">     
	        <p>Edit lot name.</p>
	       	<input id="lot" class="input text" name="name" type="text" value="<%= name%>">
	        <p>Edit location address.</p>
	        <input id="lot" class="input text" name="location" type="text" value="<%= location%>">
	         <p> </p>
	        <input id="lot" class="input text" name="loc_lat" type="text" value="<%= loc_lat%>">
	        <input id="lot" class="input text" name="loc_long" type="text" value="<%= loc_long%>">
	        <p>Edit hourly price for parking on a spot on this lot.</p>
	        <input id="lot" class="input text" name="price" type="text" value="<%= price%>">
	        <p>Edit number of parking spots on this lot.</p>
	        <input id="lot" class="input text" name="spots" type="text" value="<%= spots%>">
	        <p>Opening and closing hour for this parking lot.</p>
	        <input id="lot" class="input text" name="opening_h" type="text" value="<%= opening_h%>">
	        <input id="lot" class="input text" name="closing_h" type="text" value="<%= closing_h%>">
	        
	        <p>Please click <font color="#EE9A4D">Submit Changes</font> below when done.</p>
	        <input id="btn-post" class="active btn" type="submit" value="Submit Changes" >
	    </form>
	    
	    <% } %>
     </div>
		<input type="button" value="Return to your List" onClick="parent.location='Manage.jsp'"
		       style="background:url(../images/interface_o.jpg) no-repeat; color:#fff;" 
		/>
    	</div> 
    	
				<ul class="blog">
					<li>
						<div>
							<a href="service_driver.html"><img src="images/driver.png" alt=""/></a>
							<p align=center> <b> <font color="#3090C7" size="3"> MOBILE APPLICATION INFO </font> </b></p>
							<p> Click to get the Mobile application. </p>
							<a href="service_driver.html">click to read more</a>
						</div>
					</li>
					<li>
						<div>
							<a href="Login.jsp"><img src="images/owner.jpg" alt=""/></a>
							<p align=center> <b> <font color="#0000A0" size="3"> OWNER LOGIN </font> </b></p>
							<p> Owner ? Click picture to login. </p>
							<a href="service_owner.html">click to read more</a>
						</div>
					</li>
					<li>
						<div>
							<a href="Login.jsp"><img src="images/enforcer.jpg" alt=""/></a>
							<p align=center> <b> <font color="#2554C7" size="3"> PARKING SHERIFF LOGIN </font> </b></p>
							<p> Parking sheriff - click picture to login. </p>
							<a href="service_enforcer.html">click to read more</a>
						</div>
					</li>
				</ul>
			</div> 
			<div class="footer">
				<ul>
					<li><a href="index.html">Home</a></li>
    		<%if(currentUser != null) { %>  
            <li><a>Hello <%= currentUser.getNickname() %> , 
                  <%= currentUser.getEmail() %></a></li>
            <li class="active">
                  <a href=<%= userService.createLogoutURL("/Create.jsp")%>>Sign out</a>
   			<% } else {%>
            <li class="active">
                  <a href=<%= userService.createLoginURL("/Create.jsp")%>>Sign in</a>   
   			<% } %>  
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

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.min.js"></script>

</body>
</html>