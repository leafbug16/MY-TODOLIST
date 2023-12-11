package com.leafbug.todolist.model;

import java.util.Date;

public class Comment {
	private Integer cno;
	private Integer bno;
	private String comment;
	private String commenter;
	private Date regDate;
	private Date updateDate;
	
	public Comment() {
		super();
	}

	public Comment(Integer bno, String comment, String commenter) {
		super();
		this.bno = bno;
		this.comment = comment;
		this.commenter = commenter;
	}

	public Integer getCno() {
		return cno;
	}

	public void setCno(Integer cno) {
		this.cno = cno;
	}

	public Integer getBno() {
		return bno;
	}

	public void setBno(Integer bno) {
		this.bno = bno;
	}

	public String getComment() {
		return comment.replace("\r\n", "<br/>");
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getCommenter() {
		return commenter;
	}

	public void setCommenter(String commenter) {
		this.commenter = commenter;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "Comment [cno=" + cno + ", bno=" + bno + ", comment=" + comment + ", commenter=" + commenter + ", regDate="
				+ regDate + ", updateDate=" + updateDate + "]";
	}
	
	
}
