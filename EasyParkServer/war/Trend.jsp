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
 	    
		    
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
    // ********************** CHART INCOME PER PARKING ************************
    
      // Load the Visualization API and the piechart package.
      google.load('

    		  ', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      //function drawChart() {
   	$.getJSON("/ReadEarningsPerParking", function(drawChart) {
    	         //alert(earnings); //uncomment this for debug
    	         //alert (earnings.item1+" "+earnings.item2+" "+earnings.item3); //further debug
    	         //$('#showdata').html("<p>item1="+earnings.item1+" item2="+earnings.item2+" item3="+earnings.item3+"</p>");
    	   	

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Lot');
        data.addColumn('number', 'Income'); 
        //
        // Json : readearningsperparking
       
        data.addRows([
          ['Lot1', 3],
          ['Lot2', 1],
          ['Lot3', 1],
          ['Lot4', 2]
         ]);

        // Set chart options
        var options = {'title':'Income Per Parking Lots'};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
 
    
    <script type='text/javascript'>
    /********************** TABLE INCOME  ************************/ 
    
      google.load('visualization', '1', {packages:['table']});
      google.setOnLoadCallback(drawTable);
      function drawTable() {
        var data = new google.visualization.DataTable();
        
        // Json : readearningsperparking
        // Json : readoccupancyperparking
        data.addColumn('string', 'Parking');
        data.addColumn('number', 'Earning');
        data.addColumn('number', 'Occupancy');
        data.addRows([
          ['Lot_1',  {v: 10000, f: '$10,000'}, {v: 10000, f: '10%'}],
          ['Lot_2',   {v:8000,   f: '$8,000'},  {v: 12500, f: '12,5%'}],
          ['Lot_3', {v: 12500, f: '$12,500'}, {v:8000,   f: '8%'}],
          ['Lot_4',   {v: 7000,  f: '$7,000'},   {v: 7000,  f: '47%'}]
        ]);

        var table = new google.visualization.Table(document.getElementById('table_div'));
        table.draw(data, {showRowNumber: true});
      }
    </script>

    <script type="text/javascript">
    // ********************** MAPTREE OCCUPANCY ************************
    
      google.load("visualization", "1", {packages:["treemap"]});
      google.setOnLoadCallback(drawMapTree);
      function drawMapTree() {
        // Create and populate the data table.
        //Json readoccupancyperparking
        
        var data = google.visualization.arrayToDataTable([
          ['Location', 'Parent', 'Market trade volume (size)', 'Market increase/decrease (color)'],
          ['Global',    null,                 0,                               0],
          ['Lot1',   	'Global',             0,                               0],
          ['Lot2',    	'Global',             0,                               0],
          ['Lot3',      'Global',             0,                               0],
          ['Lot4', 		'Global',             0,                               0],
          ['Brazil',    'Lot1',            11,                              10],
          ['USA',       'Lot1',            52,                              31],
          ['Mexico',    'Lot1',            24,                              12],
          ['Canada',    'Lot1',            16,                              -23],
          ['France',    'Lot2',             42,                              -11],
          ['Germany',   'Lot2',             31,                              -2],
          ['Sweden',    'Lot2',             22,                              -13],
          ['Italy',     'Lot2',             17,                              4],
          ['UK',        'Lot2',             21,                              -5],
          ['China',     'Lot3',               36,                              4],
          ['Japan',     'Lot3',               20,                              -12],
          ['India',     'Lot3',               40,                              63],
          ['Laos',      'Lot3',               4,                               34],
          ['Mongolia',  'Lot3',               1,                               -5],
          ['Israel',    'Lot3',               12,                              24],
          ['Iran',      'Lot3',               18,                              13],
          ['Pakistan',  'Lot3',               11,                              -52],
          ['Egypt',     'Lot4',             21,                              0],
          ['S. Africa', 'Lot4',             30,                              43],
          ['Sudan',     'Lot4',             12,                              2],
          ['Congo',     'Lot4',             10,                              12],
          ['Zaire',     'Lot4',             8,                               10]
        ]);

        // Create and draw the visualization.
        var tree = new google.visualization.TreeMap(document.getElementById('treemap_div'));
        tree.draw(data, {
          minColor: '#f00',
          midColor: '#ddd',
          maxColor: '#0d0',
          headerHeight: 8,
          fontColor: 'black',
          showScale: true});
        }
    </script>
    
</head>
<body>
		<div class="page">
			<div class="header">
				<a href="index.html" id="logo"><img src="images/logo.gif" alt=""/></a>
				<ul>
					<li class="selected"><a href="index.html">Home</a></li>
					<li class="selected"><a href="Manage.html">Manage</a></li>
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
			<div class="header" align="right" id="map_div" style="width: 400px; height: 300px; background: no-repeat right top;"></div>
			<div class="body">
				<div id="featured_om">

					<h3>YOUR CURRENT PARKING LOTS</h3>
      				<div class="view-title">
        				<% if (currentUser != null) { 
 							String lot_id = request.getParameter("lotId");
 							Long lotID= (lot_id==null) ? 0: Long.valueOf(lot_id);
							int taken_now=0, taken=0;
 							List<ParkingSpot> spots = OfyService.ofy().load().type(ParkingSpot.class).list();
	    					for (ParkingSpot spot :spots) 
	    					{ 
	    						if ((spot.lotId==lot.lotId) && (!spot.free) && (lot.active==true))
	    							{ taken_now++;}
	    						if ((spot.lotId==lot.lotId) && (lot.active==true))	
	    							{ taken++;}	
        					%>  
        					<tr>
			 					<th><p> OCCUPIED RIGHT NOW</p></th>
			 					<th><p> OVERALL OCCUPANCY </p></th>
			 				</tr>
        					    
			 				<tr>
			 					<td><%= taken_now %></td>
			 					<td><%= taken %></td>
			 				</tr>
							<%	}}}%>
							
					<li>
       					<div id="chart_div"  style="width: 268px; height: 158px;"></div>	
 				 		<p style="margin-left: 50px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3">Parking Earnings</font> </b></p>
 				 	</li>
					<li>   		 
    	       			<div id="table_div" style="width: 268px; height: 158px;"></div>
    	       			<p style="margin-left: 50px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3"> Report </font> </b></p>
    				</li>
					<li>   		 
    	       			<div id="treemap_div" style="width: 268px; height: 158px;"></div>
    	       			<p style="margin-left: 50px; display:block; text-align: left; "> <b> <font color="#3090C7" size="3"> Occupancy </font> </b></p>
    				</li>
 
    			</div>
    		</div>
    	</div>
    				   			
    	
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