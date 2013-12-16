package com.easypark;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class EditLotServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
	
		boolean duplicate = false;
	 	UserService userService = UserServiceFactory.getUserService();
		User currentUser = userService.getCurrentUser();
	    String name = req.getParameter("name");
	    String location = req.getParameter("location");
	    String price = req.getParameter("price");
	    String spots = req.getParameter("spots");
	    if((currentUser != null) && (location != null)) {
	    	ParkingLot s = new ParkingLot(name, currentUser.getUserId(), location, price, Integer.parseInt(spots));
			if (!s.isAlreadyInList(s))
				// persist to datastore
				ofy().save().entity(s).now();
			else {
				duplicate = true;
				List<ParkingLot> lots = OfyService.ofy().load().type(ParkingLot.class).list();
				for (ParkingLot lot : lots) {
					if(lot.compareTo(s) == 0) {
						lot.price = price;
						lot.spots = Integer.parseInt(spots);
						lot.freeSpots = Integer.parseInt(spots);
						ofy().save().entity(lot).now();
						break;	
					}
				}

			}
	    }

	    resp.sendRedirect(Utils.getLotEditUrl(duplicate, name, location, price, spots));		
	}

}
