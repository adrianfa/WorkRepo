<%@ page contentType="text/html;charset=UTF-8" language="java"
  isELIgnored="false"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="com.google.cloud.demo.*"%>
<%@ page import="com.google.cloud.demo.model.*"%>
<%@ page import="com.google.appengine.api.users.*"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreNeedIndexException"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  UserService userService = UserServiceFactory.getUserService();
  AppContext appContext = AppContext.getAppContext();
  ConfigManager configManager = appContext.getConfigManager();
  DemoUser currentUser = appContext.getCurrentUser();
  PhotoServiceManager serviceManager = appContext.getPhotoServiceManager();
  PhotoManager photoManager = appContext.getPhotoManager();
  CommentManager commentManager = appContext.getCommentManager();
%>
<!DOCTYPE html>

<head>
<script type="text/javascript">
var tabLinks = new Array();
var contentDivs = new Array();

function init() {

  // Grab the tab links and content divs from the page
  var tabListItems = document.getElementById('tablist').childNodes;
  for ( var i = 0; i < tabListItems.length; i++ ) {
    if ( tabListItems[i].nodeName == "LI" ) {
      var tabLink = getFirstChildWithTagName( tabListItems[i], 'A' );
      var id = getHash( tabLink.getAttribute('href') );
      tabLinks[id] = tabLink;
      contentDivs[id] = document.getElementById( id );
    }
  }

  // Assign onclick events to the tab links, and
  // highlight the first tab
  var i = 0;

  for ( var id in tabLinks ) {
    tabLinks[id].onclick = showTab;
    tabLinks[id].onfocus = function() { this.blur() };
    if ( i == 0 ) tabLinks[id].className = 'current';
    i++;
  }

  // Hide all content divs except the first
  var i = 0;

  for ( var id in contentDivs ) {
    if ( i != 0 ) contentDivs[id].className = 'tabContent hide';
    i++;
  }
}

function showTab() {
  var selectedId = getHash( this.getAttribute('href') );

  // Highlight the selected tab, and dim all others.
  // Also show the selected content div, and hide all others.
  for ( var id in contentDivs ) {
    if ( id == selectedId ) {
      tabLinks[id].className = 'current';
      contentDivs[id].className = 'tabContent';
    } else {
      tabLinks[id].className = '';
      contentDivs[id].className = 'tabContent hide';
    }
  }

  // Stop the browser following the link
  return false;
}

function getFirstChildWithTagName( element, tagName ) {
  for ( var i = 0; i < element.childNodes.length; i++ ) {
    if ( element.childNodes[i].nodeName == tagName ) return element.childNodes[i];
  }
}

function getHash( url ) {
  var hashPos = url.lastIndexOf ( '#' );
  return url.substring( hashPos + 1 );
}

function onFileSelected() {
  filename = document.getElementById("input-file").value;
  if (filename == null || filename == "") {
    document.getElementById("btn-post").setAttribute("class", "inactive btn");
    document.getElementById("btn-post").disabled = true;
  } else {
    document.getElementById("btn-post").setAttribute("class", "active btn");
    document.getElementById("btn-post").disabled = false;
  }
}

function togglePhotoPost(expanded) {
  onFileSelected();
  if (expanded) {
    document.getElementById("btn-choose-image").style.display="none";
    document.getElementById("upload-form").style.display="block";
  } else {
    document.getElementById("btn-choose-image").style.display="inline-block";
    document.getElementById("upload-form").style.display="none";
  }
}

function onCommentChanged(id) {
  comment = document.getElementById("comment-input-" + id).value;
  if (comment == null || comment.trim() == "") {
    document.getElementById("comment-submit-" + id).setAttribute("class", "inactive btn");
    document.getElementById("comment-submit-" + id).disabled = true;
  } else {
    document.getElementById("comment-submit-" + id).setAttribute("class", "active btn");
    document.getElementById("comment-submit-" + id).disabled = false;
  }
}

function toggleCommentPost(id, expanded) {
  onCommentChanged(id);
  if (expanded) {
    document.getElementById("comment-input-" + id).setAttribute("class", "post-comment expanded");
    document.getElementById("comment-submit-" + id).style.display="inline-block";
    document.getElementById("comment-cancel-" + id).style.display="inline-block";
  } else {
    document.getElementById("comment-input-" + id).value = ""
    document.getElementById("comment-input-" + id).setAttribute("class", "post-comment collapsed");
    document.getElementById("comment-submit-" + id).style.display="none";
    document.getElementById("comment-cancel-" + id).style.display="none";
  }
}
</script>
<title>Photofeed</title>
<link rel="stylesheet" type="text/css" href="photofeed.css" />
</head>

<body onload="init()">
  <div class="wrap">

    <div class="header group">
      <h1>
        <img src="img/photofeed.png" alt="Photofeed" />
      </h1>
    </div>
      
		<ul class="tablist">
      		<li><a href="#managestream">Manage</a></li>
      		<li><a href="#createstream">Create</a></li>
      		<li id="current"><a href="#viewstream">View</a></li>
      		<li><a href="#searchstream">Search</a></li>
      		<li><a href="#trendingstream">Trending</a></li>
      		<li><a href="#socialstream">Social</a></li>
		</ul>    
   
	<div class="tabContent" id="managestream">
    </div>
    
 	<div class="tabContent" id="searchstream">
    </div>
    
 	<div class="tabContent" id="trendingstream">
    </div>
    
 	<div class="tabContent" id="socialstream">
    </div>
    
	<div class="tabContent" id="createstream">
    </div>
    
	<div class="tabContent" id="viewstream">
    
    <div class="glow"></div>

    <div id="upload-wrap">
      <div id="upload">
        <div class="account group">
          <div id="account-thumb">
            <img
              src="<%= ServletUtils.getUserIconImageUrl(currentUser.getUserId()) %>"
              alt="Unknown User Icon" />
          </div>
          <!-- /#account-thumb -->
          <div id="account-name">
            <h2><%= ServletUtils.getProtectedUserNickname(currentUser.getNickname()) %></h2>
            <p><%= currentUser.getEmail() %>
              | <a
                href=<%= userService.createLogoutURL(configManager.getMainPageUrl())%>>Sign
                out</a>
            </p>
          </div>
          <!-- /#account-name -->
        </div>
        <!-- /.account -->
        <a id="btn-choose-image" class="active btn" onclick="togglePhotoPost(true)">Choose an image</a>
        <div id="upload-form" style="display:none">
          <form action="<%= serviceManager.getUploadUrl() %>" method="post"
            enctype="multipart/form-data">
            <input id="input-file" class="inactive file btn" type="file" name="photo"
              onchange="onFileSelected()">
            <textarea name="title" placeholder="Write a description"></textarea>
            <input id="btn-post" class="active btn" type="submit" value="Post">
            <a class="cancel" onclick="togglePhotoPost(false)">Cancel</a>
          </form>
        </div>
      </div>
      <!-- /#upload -->
    </div>
    <!-- /#upload-wrap -->

    <!-- KK -->
    <%
      Iterable<Photo> photoIter = photoManager.getActivePhotos();
      ArrayList<Photo> photos = new ArrayList<Photo>();
      try {
        for (Photo photo : photoIter) {
          photos.add(photo);
        }
      } catch (DatastoreNeedIndexException e) {
        pageContext.forward(configManager.getErrorPageUrl(
          ConfigManager.ERROR_CODE_DATASTORE_INDEX_NOT_READY));
      }

      int count = 0;
      for (Photo photo : photos) {
        String firstClass = "";
        String lastClass = "";
        if (count == 0) {
          firstClass = "first";
        }
        if (count == photos.size() - 1) {
          lastClass = "last";
        }
    %>
    <div class="feed <%= firstClass %> <%= lastClass %>">
      <div class="post group">
        <div class="image-wrap">
          <img class="photo-image"
            src="<%= serviceManager.getImageDownloadUrl(photo)%>"
            alt="Photo Image" />
        </div>
        <div class="owner group">
          <!-- MM: took out here code for cats images -->
          <div class="desc">
            <h3><%= ServletUtils.getProtectedUserNickname(photo.getOwnerNickname()) %></h3>
            
            <p class="timestamp"><%= ServletUtils.formatTimestamp(photo.getUploadTime()) %></p>
            <p>
            <p><c:out value="<%= photo.getTitle() %>" escapeXml="true"/>
          </div>
          <!-- /.desc -->
        </div>
        <!-- /.usr -->
      </div>
      <!-- /.post -->
      
      <%
        Iterable<Comment> comments = commentManager.getComments(photo);
        for (Comment comment : comments) {
       %>
		<!-- MM: took out here code for iterative comment -->
      <%
        }
      %>
      	<!-- MM: took out here code for last comment -->   
    </div>
    <!-- /.feed -->
    <%
        count++;
      }
    %>
  </div>
  <!-- /.view -->  
  </div>
  <!-- /.wrap -->
</body>
</html>
