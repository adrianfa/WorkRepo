package com.easypark;

import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.google.common.base.Joiner;

@Entity
public class OwnerAccount implements Comparable<OwnerAccount> {

	static {
		 ObjectifyService.register(OwnerAccount.class);
	}
	// id is set by the datastore for us
	@Id
	public String ownerId;
	public String ownerName;
	public String accountName;
	public Long balance; //in cents
	
  
	// TODO: figure out why this is needed
	@SuppressWarnings("unused")
	private OwnerAccount() {
	}
	
	@Override
	public String toString() {
		Joiner joiner = Joiner.on(":");
		return joiner.join(ownerId.toString(), ownerName, accountName, balance.toString());
 	}


	public OwnerAccount(String ownerId, String ownerName, String accountName, Long balance) {
		this.ownerId = ownerId;
		this.ownerName = ownerName;
		this.accountName = accountName;
		this.balance = balance;
	}

	@Override
	public int compareTo(OwnerAccount other) {
		return ownerName.compareTo(other.ownerName);
	}
	
	public boolean isAlreadyInList(OwnerAccount other) {
		List<OwnerAccount> owners = OfyService.ofy().load().type(OwnerAccount.class).list();
		for(OwnerAccount owner : owners) {
			if(owner.compareTo(other) == 0)
				return true;
		}
			
		return false;
	}
}
