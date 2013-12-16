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

public class ReadEarningsPerParking extends HttpServlet {
        
        private static final Logger log = Logger.getLogger(ReadEarningsPerParking.class.getName());
        
        public void doGet(HttpServletRequest req, HttpServletResponse resp)
                        throws IOException {
                
                log.warning("Entering ReadEarningsPerParking");
        
          // For all sessions there are
                // For all lot_IDs I have 
                	// compute the overall income 
                
                List<ParkingSession> sessions = OfyService.ofy().load().type(ParkingSession.class).list();      
				List<ParkingLot>     lots     = OfyService.ofy().load().type(ParkingLot.class).list();
                                 
                for (ParkingSession session :sessions) {
                	for (ParkingLot lot : lots) {
                                if (session.lotId == lot.lotId) {lot.earnings+=session.paidAmmount;}
                	}
                }

            // Build list to pass along containing parking lot name and its earnings 
                
                ArrayList<String> earnings = new ArrayList<String>();
                
            	for (ParkingLot lot : lots) {
                    earnings.add(lot.lotName);
                    earnings.add(Long.toString(lot.earnings));
            	}
                
                
                Gson gson = new Gson();
                String json = gson.toJson(earnings);
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
