package com.google.cloud.demo;

import java.util.Date;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.common.base.Joiner;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class ConnexusImage implements Comparable<ConnexusImage> {

	@Id
	public Long id;
	public Long streamId;
	public String comments;
	public String bkUrl;
	public Date createDate;
	public Double latitude;
	public Double longitude;
	public Double distance;
	public String streamName;

	@SuppressWarnings("unused")
	private ConnexusImage() {
	}
	static {
		com.googlecode.objectify.ObjectifyService.factory().register(ConnexusImage.class);
	}

	public ConnexusImage(Long streamId, String user, String content, String bkUrl) {
		this(streamId, user, content, 0L,  bkUrl, 0.0, 0.0);
	}
	
	public ConnexusImage(Long streamId, String user, String content, long uploadTime, String bkUrl, Double latitude, Double longitude) {
		this.streamId = streamId;
		this.bkUrl = bkUrl;
		this.comments = content;
		createDate = new Date();
		if(uploadTime > 0)
			createDate.setTime(uploadTime);
		this.latitude = latitude;
		this.longitude = longitude;
		Date endDate = new Date();
		long startDate = endDate.getTime() - 365*24*60*60*1000L;

	}
	
	@Override
	public String toString() {
		// Joiner is from google Guava (Java utility library), makes the toString method a little cleaner
		Joiner joiner = Joiner.on(":").useForNull("NULL");
		System.out.println(id);
		System.out.println(streamId);
		System.out.println(bkUrl);
		System.out.println(createDate.toString());
		return joiner.join(id.toString(), streamId, comments, bkUrl==null ? "null" : bkUrl, createDate.toString(), latitude, longitude, distance, streamName);
	}

	// Need this for sorting images by date
	@Override
	public int compareTo(ConnexusImage other) {
		if (createDate.after(other.createDate)) {
			return 1;
		} else if (createDate.before(other.createDate)) {
			return -1;
		}
		return 0;
	}
	
}
