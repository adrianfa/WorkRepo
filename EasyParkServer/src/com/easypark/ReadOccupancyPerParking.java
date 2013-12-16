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

public class ReadOccupancyPerParking extends HttpServlet {
        
        private static final Logger log = Logger.getLogger(ReadOccupancyPerParking.class.getName());
        
        public void doGet(HttpServletRequest req, HttpServletResponse resp)
                        throws IOException {
                
                log.warning("Entering ReadOccupancyPerParking");
        
          // For all sessions there are
                // For all lot_IDs I have 
                	// compute how many times it was used (number of sessions)
                
                List<ParkingSession> sessions = OfyService.ofy().load().type(ParkingSession.class).list();      
				List<ParkingLot>     lots     = OfyService.ofy().load().type(ParkingLot.class).list();
                                 
                for (ParkingSession session :sessions) {
                	for (ParkingLot lot : lots) {
                                if (session.lotId == lot.lotId) {lot.occupancy++;}
                	}
                }

            // Build list to pass along containing parking lot name and its occupancy 
                
                ArrayList<String> table_input = new ArrayList<String>();
                
            	for (ParkingLot lot : lots) {
            		table_input.add(lot.lotName);
            		table_input.add(Long.toString(lot.earnings));
            		table_input.add(Long.toString(lot.occupancy));
            	}
                
                
                Gson gson = new Gson();
                String json = gson.toJson(table_input);
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
