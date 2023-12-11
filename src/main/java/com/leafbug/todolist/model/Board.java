package com.leafbug.todolist.model;

import java.util.Date;

public class Board {
	private String boardType;
	private Integer bno;
	private String title;
	private String content;
	private String writer;
	private Integer views;
	private Integer comments;
	private Integer likes;
	private Date regDate;
	private String comment;
	
	public Board() {
		super();
	}
	
	public Board(String boardType, String title, String content, String writer) {
		super();
		this.boardType = boardType;
		this.title = title;
		this.content = content;
		this.writer = writer;
	}
		
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Integer getViews() {
		return views;
	}
	public void setViews(Integer views) {
		this.views = views;
	}
	public Integer getComments() {
		return comments;
	}
	public void setComments(Integer comments) {
		this.comments = comments;
	}
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Board [boardType=" + boardType + ", bno=" + bno + ", title=" + title + ", content=" + content + ", writer="
				+ writer + ", views=" + views + ", comments=" + comments + ", likes=" + likes + ", regDate=" + regDate
				+ ", comment=" + comment + "]";
	}
	
}
