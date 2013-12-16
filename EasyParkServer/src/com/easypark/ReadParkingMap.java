package com.easypark;

import java.io.IOException;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.*;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@SuppressWarnings("serial")

public class ReadParkingMap extends HttpServlet {
        
        private static final Logger log = Logger.getLogger(ReadParkingMap.class.getName());
        
        public void doGet(HttpServletRequest req, HttpServletResponse resp)
                        throws IOException {
                
                log.warning("Entering ReadParkingMap");
        
          // For all sessions there are
                // For all lot_IDs I have 
                	// compute how many times it was used (number of sessions)
                    
				List<ParkingLot>     lots     = OfyService.ofy().load().type(ParkingLot.class).list();
                                 
            // Build list to pass along containing parking lot name its latitude and its longitude  
                
                ArrayList<String> map_parking = new ArrayList<String>();
                
               /* map_parking.add("Lat");
                map_parking.add("Lon");
                map_parking.add("Name");
                */
            	for (ParkingLot lot : lots) {
            		map_parking.add(lot.location_latitude);                    
            		map_parking.add(lot.location_longitude);
            		map_parking.add(lot.lotName);
            	}
                
                Gson gson = new Gson();
                String json = gson.toJson(map_parking);
                resp.setContentType("application/json");
                resp.getWriter().print(json);
                
                // for debugging
                Type t = new TypeToken<List<String>>(){}.getType();
                List<String> fromJson = (List<String>) gson.fromJson(json, t);
                for (String s : fromJson ) {
                        System.out.println(s);
                }
        }
}
