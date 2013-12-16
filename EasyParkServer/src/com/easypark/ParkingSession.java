package com.easypark;

import java.util.Date;
import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;

@Entity
public class ParkingSession implements Comparable<ParkingSession> {

	static {
		 ObjectifyService.register(ParkingSession.class);
	}
	// id is set by the datastore for us
	@Id
	public Long sessionId;
	public Long userId;
	public Long lotId;
	public Long transactionId;
	public boolean alertSent;
	public Date startTime;
	public Date expirationTime;
	public Date alertTime;
	public Long paidAmmount;
	public String paymentMethod;
	public String lotAddress;
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private ParkingSession() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":").useForNull("NULL");
		return joiner.join(sessionId.toString(), userId.toString(), lotId.toString(), transactionId.toString(), 
				Boolean.toString(alertSent), startTime.toString(),
				expirationTime.toString(), alertTime.toString(), paidAmmount.toString(), paymentMethod, lotAddress);
 	}


	public ParkingSession(Long sessionId, Long userId, Long lotId, boolean alertSent, long stayTime, long alertAhead) {
		this.sessionId = sessionId;
		this.userId = userId;
		this.lotId = lotId;
		this.alertSent = alertSent;
		this.startTime = new Date();
		this.expirationTime = new Date();
		this.alertTime = new Date();
		this.expirationTime.setTime(startTime.getTime() + stayTime);
		this.alertTime.setTime(startTime.getTime() + stayTime - alertAhead);	
		this.paidAmmount = 0L;
	}
	
	public ParkingSession(String lotAddress, long stayExpTime, String paymentMethod, Long userId) {
		this.lotAddress = lotAddress;
		this.userId = userId;
		this.startTime = new Date();
		this.expirationTime = new Date();
		this.alertTime = new Date();
		this.expirationTime.setTime(stayExpTime);
		this.paymentMethod = paymentMethod;
		this.paidAmmount = 0L;
		this.alertSent = false;
		this.alertTime.setTime(stayExpTime - 15*60*1000); //15min default alert ahead of expiration time	
	}

	public ParkingSession(Long sessionId, Long userId, Long lotId, int availableSpots, String lotAddress, long stayExpTime, String paymentMethod, long cost) {
		this.sessionId = sessionId;
		this.userId = userId;
		this.lotId = lotId;
		this.transactionId = Long.valueOf(String.valueOf(availableSpots));
		this.lotAddress = lotAddress;
		this.startTime = new Date();
		this.expirationTime = new Date();
		this.alertTime = new Date();
		this.expirationTime.setTime(stayExpTime);
		this.paymentMethod = paymentMethod;
		this.paidAmmount = cost;
		this.alertSent = false;
		this.alertTime.setTime(stayExpTime - 15*60*1000); //15min default alert ahead of expiration time	
	}

	@Override
	public int compareTo(ParkingSession other) {
		if (startTime.after(other.startTime)) {
			return 1;
		} else if (startTime.before(other.startTime)) {
			return -1;
		}
		return 0;
	}
	
	public boolean isAlreadyInList(ParkingSession other) {
		List<ParkingSession> sessions = OfyService.ofy().load().type(ParkingSession.class).list();
		for(ParkingSession session : sessions) {
			if(session.compareTo(other) == 0)
				return true;
		}
			
		return false;
	}
}
