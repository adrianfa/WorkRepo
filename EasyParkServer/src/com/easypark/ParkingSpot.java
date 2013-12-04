package com.easypark;

import java.util.Date;
import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;

@Entity
public class ParkingSpot implements Comparable<ParkingSpot> {

	static {
		 ObjectifyService.register(ParkingSpot.class);
	}
	// id is set by the datastore for us
	@Id
	public Long spotId;
	public Long lotId;
	public boolean free;
	public Date freeFrom;
	public Date inceptionDate;
	public Date statisticsStartDate;
	public Long occupancy; //in seconds
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private ParkingSpot() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":").useForNull("NULL");
		return joiner.join(spotId.toString(), lotId.toString(), Boolean.toString(free), freeFrom.toString(),
				inceptionDate.toString(), statisticsStartDate.toString(), occupancy.toString());
 	}


	public ParkingSpot(Long spotId, Long lotId, boolean free, Date freeFrom, long statisticsStartDate) {
		this.spotId = spotId;
		this.lotId = lotId;
		this.free = free;
		this.inceptionDate = new Date();
		if(statisticsStartDate > 0)
			this.statisticsStartDate.setTime(statisticsStartDate);
		this.occupancy = 0L;
	}

	@Override
	public int compareTo(ParkingSpot other) {
		if( spotId > other.spotId)
			return 1;
		else if( spotId < other.spotId)
			return -1;
		else
			return 0;
	}
	
	public boolean isAlreadyInList(ParkingSpot other) {
		List<ParkingSpot> spots = OfyService.ofy().load().type(ParkingSpot.class).list();
		for(ParkingSpot spot : spots) {
			if(spot.compareTo(other) == 0)
				return true;
		}
			
		return false;
	}
}
