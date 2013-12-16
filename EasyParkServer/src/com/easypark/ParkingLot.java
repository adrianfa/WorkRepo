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
	public String price;
	public int spots;
	public int freeSpots;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private ParkingLot() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(lotId.toString(), lotName, ownerId, location, price, String.valueOf(spots), String.valueOf(freeSpots));
 	}


	public ParkingLot(String lotName, String ownerId, String location, String price, int spots) {
		this.lotName = lotName;
		this.ownerId = ownerId;
		this.location = location;
		this.price = price;
		this.spots = spots;
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
