package com.easypark;

import java.net.URLEncoder;
import java.io.UnsupportedEncodingException;

public class Utils {

	public static String getLotEditUrl(boolean duplicate, String name, 
										String location, String location_latitude, String location_longitude, 
										String price, String spots, String opening_h, String closing_h) {
		
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
	    if(location_latitude != null)
	    	builder.append("&")
	    	.append("location_latitude")
            .append("=")
            .append(Encoder(location_latitude));
	    if(location_longitude != null)
	    	builder.append("&")
	    	.append("location_longitude")
            .append("=")
            .append(Encoder(location_longitude));
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
	    if(opening_h != null)
	    	builder.append("&")
	    	.append("opening_h")
            .append("=")
            .append(Encoder(opening_h));
	    if(closing_h != null)
	    	builder.append("&")
	    	.append("closing_h")
            .append("=")
            .append(Encoder(closing_h));

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
