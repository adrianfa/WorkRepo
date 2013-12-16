package com.easypark;

import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.google.common.base.Joiner;

@Entity
public class UserAccount implements Comparable<UserAccount> {

	static {
		 ObjectifyService.register(UserAccount.class);
	}
	// id is set by the datastore for us
	@Id
	public Long userId;
	@Index 
	public String licensePlate;
	public String userName;
	public Long balance; //in cents
	public String phoneNo;
	
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private UserAccount() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(licensePlate.toString(), userName, balance.toString(), phoneNo);
 	}


	public UserAccount(String licensePlate, String userName, String phoneNo, Long balance) {
		this.licensePlate = licensePlate;
		this.userName = userName;
		this.balance = balance;
		this.phoneNo = phoneNo;
	}

	@Override
	public int compareTo(UserAccount other) {
		return licensePlate.compareTo(other.licensePlate);
	}
	
	public boolean isAlreadyInList(UserAccount other) {
		List<UserAccount> users = OfyService.ofy().load().type(UserAccount.class).list();
		for(UserAccount user : users) {
			if(user.compareTo(other) == 0)
				return true;
		}
			
		return false;
	}
}
