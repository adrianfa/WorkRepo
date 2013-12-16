package com.easypark;

import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;

@Entity
public class ParkingLot implements Comparable<ParkingLot> {

	static {
		 ObjectifyService.register(ParkingLot.class);
	}
	// id is set by the datastore for us
	@Id
	public Long lotId;
	public String lotName;
	public String ownerId;
	public String location;
	public String location_latitude;
	public String location_longitude;
	public String price;
	public int spots;
	public int freeSpots;
	public String opening_h;
	public String closing_h;
	public long earnings;
	public int occupancy;
	public boolean active; 
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private ParkingLot() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(lotId.toString(), lotName, ownerId, location, price, String.valueOf(spots), String.valueOf(freeSpots));
 	}


	public ParkingLot(String lotName, String ownerId, String location, String loc_lat, String loc_long, String price, int spots, String opening, String closing) {
		this.lotName = lotName;
		this.ownerId = ownerId;
		this.location = location;
		this.location_latitude = loc_lat; // 30.26758;
		this.location_longitude = loc_long; //-97.74297;
		this.price = price;
		this.spots = spots;
		this.opening_h = opening;
		this.closing_h = closing;
		this.earnings = 0;
		this.occupancy=0;
		this.active=true;
		this.freeSpots = spots;
	}

	@Override
	public int compareTo(ParkingLot other) {
		return location.compareTo(other.location);
	}
	
	public boolean isAlreadyInList(ParkingLot other) {
		List<ParkingLot> lots = OfyService.ofy().load().type(ParkingLot.class).list();
		for(ParkingLot lot : lots) {
			if(lot.compareTo(other) == 0)
				return true;
		}
			
		return false;
	}
}
