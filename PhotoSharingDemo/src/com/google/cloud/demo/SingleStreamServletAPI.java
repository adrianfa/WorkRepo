package com.google.cloud.demo;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.*;

import com.google.cloud.demo.model.Photo;
import com.google.cloud.demo.model.PhotoManager;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@SuppressWarnings("serial")
public class SingleStreamServletAPI extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		
		AppContext appContext = AppContext.getAppContext();
		PhotoManager photoManager = appContext.getPhotoManager();
		PhotoServiceManager serviceManager = appContext.getPhotoServiceManager();
		
		String streamId = req.getParameter(ServletUtils.REQUEST_PARAM_NAME_ALBUM_ID); 
		String streamUserId = req.getParameter(ServletUtils.REQUEST_PARAM_NAME_PHOTO_OWNER_ID);
	   	Iterable<Photo> photoIter = photoManager.getOwnedAlbumPhotos(streamUserId, streamId);
		List<ConnexusImage> subsetImages = new ArrayList<ConnexusImage>();
		Double lat = 0.0;
		Double lng = 0.0;
		
     	for (Photo photo : photoIter) {
     		ConnexusImage img = new ConnexusImage(Long.parseLong(streamId), streamUserId, "for mapping", 
     				photo.getUploadTime(), serviceManager.getImageDownloadUrl(photo), lat, lng);
     		subsetImages.add(img); 
     	}

  		Collections.sort(subsetImages);
        
		Gson gson = new Gson();
		String json = gson.toJson(subsetImages);
		resp.setContentType("application/json");
		resp.getWriter().print(json);
		
		// for debugging 
		//Type t = new TypeToken<List<ConnexusImage>>(){}.getType();
		//List<ConnexusImage> fromJson = (List<ConnexusImage>) gson.fromJson(json, t);
		//for (ConnexusImage s : fromJson ) {
		//	System.out.println(s);
		//} 
	}
}