package com.easypark;

import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;

public class Utils {

	public static String getLotEditUrl(boolean duplicate, String name, String location, String price, String spots) {
		
	    StringBuilder builder = new StringBuilder("/Edit.jsp");
        builder.append("?");
	    if (duplicate)
	    	builder.append("duplicate")
	            .append("=")
	            .append("1");
	    if(name != null)
	    	builder.append("&")
	    	.append("name")
            .append("=")
            .append(name);
	    if(location != null)
	    	builder.append("&")
	    	.append("location")
            .append("=")
            .append(Encoder(location));
	    if(price != null)
	    	builder.append("&")
	    	.append("price")
            .append("=")
            .append(price);
	    if(spots != null)
	    	builder.append("&")
	    	.append("spots")
            .append("=")
            .append(spots);
	    
	    return builder.toString();
	}
	
	public static String Encoder(String stringUrl){
		String encodedurl = null;
		try {
			encodedurl = URLEncoder.encode(stringUrl,"UTF-8"); 
		}	catch(UnsupportedEncodingException uee){
		  System.err.println(uee);
		}
		return encodedurl;
	}

}
