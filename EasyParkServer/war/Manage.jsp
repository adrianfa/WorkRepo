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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title>Park and Pay</title>
		<link rel="stylesheet" href="css/style.css" type="text/css" />
		<!--[if IE 7]>
			<link rel="stylesheet" href="css/ie7.css" type="text/css" />
		<![endif]-->
		
		    <!--Load the AJAX API-->
	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
</script>
<script>
/* ***************************** TABLE  button1 table_div_pie ********************************* */
google.load('visualization', '1', {packages:['table']});

$(document).ready(function(){
  $("button1").click(function(){
    $.getJSON("http://localhost:8888/readoccupancyperparking",function(result){
        var data = new google.visualization.DataTable(result);
		/*var data = new google.visualization.DataTable();*/
			
        data.addColumn('string', 'Parking');
        data.addColumn('number', 'Earning');
        data.addColumn('number', 'Occupancy');
        /*data.addRows([
          ['Lot_1',  {v: 10000, f: '$10,000'}, {v: 10000, f: '10%'}],
          ['Lot_2',   {v:8000,   f: '$8,000'},  {v: 12500, f: '12,5%'}],
          ['Lot_3', {v: 12500, f: '$12,500'}, {v:8000,   f: '8%'}],
          ['Lot_4',   {v: 7000,  f: '$7,000'},   {v: 7000,  f: '47%'}] ]);*/
          
        var table = new google.visualization.Table(document.getElementById('table_div_pie'));
        table.draw(data, {showRowNumber: true});
        
 		/* To test what values we receive 
      	$.each(result, function(i, field){
        	$(".occupancy").append(field + " ");
      	});*/  	
    });
  });
});
</script>

<script>
/* ***************************** PIE CHART  button2 chart_div_pie ********************************* */
google.load('visualization', '1', {packages:['corechart']});

$(document).ready(function(){
  $("button2").click(function(){
    $.getJSON("http://localhost:8888/readearningsperparking",function(result){
	       // Create the data table.
        var data = new google.visualization.DataTable(result);      
	    /* var data = new google.visualization.DataTable(); */
	    
        data.addColumn('string', 'Lot');
        data.addColumn('number', 'Income'); 
        /*data.addRows([['Lot_1', 3],['Lot_2', 1],['Lot_3', 1],['Lot_4', 2]]);*/
		
        // Set chart options
        var options = {'title':'Income Per Parking Lots'};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div_pie'));
        chart.draw(data, options);
        
        /* Testing to see what I actually read there
        $.each(result, function(i, field){
        $(".earnings").append(field + " "); }); */
    });
  });
});
</script>

<script>
/* ***************************** MAP  button0 map_div ********************************* */

google.load("visualization", "1", {packages:["map"]});

$(document).ready(function(){
  $("button0").click(function(){
    $.getJSON("http://localhost:8888/readparkingmap",function(result){
    	
  	/*  	
    	var data = new google.visualization.DataTable(result);
        data.addColumn('number', 'Lat');
        data.addColumn('number', 'Lon');
        data.addColumn('string', 'Name');
        var map = new google.visualization.Map(document.getElementById('map_div_pie'));
		map.draw(data, {showTip: true});
    
	*/
    /*    var data = google.visualization.arrayToDataTable([
                                                          ['Lat', 'Lon', 'Name'],
                                                          [30.280251, -97.737631, 'Lot_1'],
                                                          [30.282851, -97.737449, 'Lot_2'],
                                                          [30.268473, -97.738444, 'Lot_3'],
                                                          [30.287078, -97.748684, 'Lot_4']
                                                        ]);

        var map = new google.visualization.Map(document.getElementById('map_div_pie'));
		map.draw(data, {showTip: true});
	*/


     	  
      	var data = new google.visualization.arrayToDataTable();
      	data.addRows(2);
        data.setCell(0,0, 'Lat');
        data.setCell(0,1, 'Lon');
        data.setCell(0,2, 'Name');
        data.setCell(0,0, 30.280251);
        data.setCell(0,1, -97.737631);
        data.setCell(0,2, 'Lot_1');
       /*
	  	int j=0;	 
 	     $.each(result, function(i, field){
 	    	  data.addRows(1);
 	    	  if (j==0) data.setCell(j,0,Integer.valueOf(field));
 	    	  if (j==1) data.setCell(j,1,Integer.valueOf(field));
 	    	  if (j==2) data.setCell(j,2,field);
 	    	  j++;
 	      });
 	     */
 	       var map = new google.visualization.Map(document.getElementById('map_div_pie'));
 			map.draw(data, {showTip: true});
 			
          $.each(data, function(i, field){
             $(".mapping").append(field + " ");
          });

    });
  });
});
</script>

    <script>
     // ********************** MAP WITH PARKINGS ************************
      google.load("visualization", "1", {packages:["map"]});
      google.setOnLoadCallback(drawMap);
      function drawMap() {
    	  
    	  //Json readparkingmap
 
        var data = google.visualization.arrayToDataTable([
          ['Lat', 'Lon', 'Name'],
          [30.280251, -97.737631, 'Lot_1'],
          [30.282851, -97.737449, 'Lot_2'],
          [30.268473, -97.738444, 'Lot_3'],
          [30.287078, -97.748684, 'Lot_4']
        ]);

        var map = new google.visualization.Map(document.getElementById('map_div'));
        map.draw(data, {showTip: true});
      }
      </script>
     
</head>
<body>

		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
				<ul>
					<li class="selected"><a href="index.html">Home</a></li>
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
						<button0 style="margin-left: 50px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3">Map</button>      					
        				 <%-- >div id="map_div_pie" style="width: 400px; height: 300px"></div--%>
       					 <div id="map_div" style="width: 400px; height: 300px"></div>

			
				<div id="featured_om">

					<h3>YOUR CURRENT PARKING LOTS</h3>
					<p>Here is the list of the parking lots you currently registered with us:
					 </p>
						<% int error_in_page=0;
						String same_name = request.getParameter("duplicate_account");
						if (same_name != null) error_in_page = Integer.valueOf(same_name);
	
						if (error_in_page==0) { %>
      				<div class="view-title">
        				<% if (currentUser != null) { %>
        			<form 	action="/manageowneraccount"
             				method="post">    
	        			<table border="1">
			 				<tr>
			 					<th width=40% >Name</th>
			 					<th width=60% >Location</th>
			 					<th>Number of Spots</th>
			 					<th>Used</th>
			 					<th>Price per Hour</th>
			 					<th>opening/closing</th>
			 					<th>Delete</th>
			 				</tr>
        					<%      
 							int table_count = 0;
							List<ParkingLot> lots = OfyService.ofy().load().type(ParkingLot.class).list();
		    				for (ParkingLot lot : lots) {
		    					if (lot.active==true)
		    						{
		    						table_count++;
		    						int taken=0;
		    						List<ParkingSpot> spots = OfyService.ofy().load().type(ParkingSpot.class).list();
		    						for (ParkingSpot spot :spots) 
		    							{ if ((spot.lotId==lot.lotId) && (!spot.free) && (lot.active==true)) taken++;}
        						%>      
			 					<tr>
			 						<td><a href=<%= Utils.getLotEditUrl(false, lot.lotName, 
			 													lot.location, lot.location_latitude, lot.location_longitude, 
			 													lot.price, String.valueOf(lot.spots),
			 													lot.opening_h, lot.closing_h) %>> <%= lot.lotName %></a></td>
			 						<td><%= lot.location %></td>
			 						<td><%= lot.spots %></td>
			 						<td><%= taken %></td>
			 						<td><%= lot.price %></td>
			 						<td><%= lot.opening_h%> - <%= lot.closing_h%></td>
			 						<td><input style="width: 20px;" type="checkbox" name="delete-box" value=<%= lot.lotId %>></td>
			 					</tr>
							<%	} }%>
						</table> 
						<%
	      				String btn_type = "submit";
		 				if (table_count == 0) {
		 					btn_type = "hidden";
		 				}
						%>
	        			<input id="delete-lots" class="active btn" type=<%= btn_type %> value="Delete Lot">
	    			<input id="add-lots" 	class="active btn" type="submit" value="Add Lot">
	    			</form>
	    			
	    				<% } else { %>
	     			<p>Please login in order to manage your account...</p>	    
	    				<% } %>
     				</div>
     				<% } else { %>
     			<div class="view-title">
     				<img class="errormsg" 	src="img/CreateError.png"  alt="Error Image" />
     			</div>
     				<%} %>
    			</div>
    				
    			<ul class="blog">
					<li>
						<button1 style="margin-left: 20px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3">Occupancy</font> </b></button>      					
       					<div class="occupancy" id="table_div_pie"  style="width: 258px; height: 140px;"></div>	
 
 				 	</li>
					<li>   		 
  						<button2 style="margin-left: 20px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3">Earnings</font> </b></button>      					
      					<div class="earnings" id="chart_div_pie"  style="width: 258px; height: 140px;"></div>	
    	       	<%-- p style="margin-left: 50px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3"> Report </font> </b></p--%>
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