package com.leafbug.todolist.model;

public class Like {
	private Integer lno;
	private Integer bno;
	private String liker;
	
	public Like(Integer bno, String liker) {
		super();
		this.bno = bno;
		this.liker = liker;
	}
	public Like() {
		super();
	}
	
	public Integer getLno() {
		return lno;
	}
	public void setLno(Integer lno) {
		this.lno = lno;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getLiker() {
		return liker;
	}
	public void setLiker(String liker) {
		this.liker = liker;
	}
	
	@Override
	public String toString() {
		return "Like [lno=" + lno + ", bno=" + bno + ", liker=" + liker + "]";
	}
	
}
