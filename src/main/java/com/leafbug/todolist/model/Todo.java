package com.leafbug.todolist.model;

import java.util.Date;

public class Todo {
	private Integer tno;
	private Integer lno;
	private String todoType;
	private String content;
	private String complete;
	private Date completeDate;
	private Integer completes;
	private String userId;
	private Date regDate;
	private Date startDate;
	private Date endDate;
	private Date dday;
	private Date dplusday;
	private String repeatCycle;
	private Date repeatStart;
	private String additionalMemo;
	
	public Todo() {
		super();
	}

	@Override
	public String toString() {
		return "Todo [tno=" + tno + ", lno=" + lno + ", todoType=" + todoType + ", content=" + content + ", complete="
				+ complete + ", completeDate=" + completeDate + ", completes=" + completes + ", userId=" + userId + ", regDate="
				+ regDate + ", startDate=" + startDate + ", endDate=" + endDate + ", dday=" + dday + ", dplusday=" + dplusday
				+ ", repeatCycle=" + repeatCycle + ", repeatStart=" + repeatStart + ", additionalMemo=" + additionalMemo + "]";
	}

	public Integer getTno() {
		return tno;
	}

	public void setTno(Integer tno) {
		this.tno = tno;
	}

	public Integer getLno() {
		return lno;
	}

	public void setLno(Integer lno) {
		this.lno = lno;
	}

	public String getTodoType() {
		return todoType;
	}

	public void setTodoType(String todoType) {
		this.todoType = todoType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public Date getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}

	public Integer getCompletes() {
		return completes;
	}

	public void setCompletes(Integer completes) {
		this.completes = completes;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Date getDday() {
		return dday;
	}

	public void setDday(Date dday) {
		this.dday = dday;
	}

	public Date getDplusday() {
		return dplusday;
	}

	public void setDplusday(Date dplusday) {
		this.dplusday = dplusday;
	}

	public String getRepeatCycle() {
		return repeatCycle;
	}

	public void setRepeatCycle(String repeatCycle) {
		this.repeatCycle = repeatCycle;
	}

	public Date getRepeatStart() {
		return repeatStart;
	}

	public void setRepeatStart(Date repeatStart) {
		this.repeatStart = repeatStart;
	}

	public String getAdditionalMemo() {
		return additionalMemo;
	}

	public void setAdditionalMemo(String additionalMemo) {
		this.additionalMemo = additionalMemo;
	}

	
	
}
