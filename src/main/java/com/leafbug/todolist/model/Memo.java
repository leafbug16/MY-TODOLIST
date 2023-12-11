package com.leafbug.todolist.model;

public class Memo {
	private String memo;
	private String userId;
	
	public Memo(String memo, String userId) {
		super();
		this.memo = memo;
		this.userId = userId;
	}
	public Memo() {
		super();
	}
	
	@Override
	public String toString() {
		return "Memo [memo=" + memo + ", userId=" + userId + "]";
	}
	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
}
