package com.leafbug.todolist.service;

import java.util.List;

import com.leafbug.todolist.model.Comment;

public interface CommentService {

	//특정 게시글 댓글 수 조회
	int getCount(Integer bno) throws Exception;

	//특정 게시글 댓글 모두 조회
	List<Comment> getList(Integer bno) throws Exception;

	//특정 댓글 하나 조회
	Comment read(Integer cno) throws Exception;

	//댓글 작성
	int write(Comment comment) throws Exception;

	//댓글 수정
	int modify(Comment comment) throws Exception;

	//댓글 삭제
	int remove(Integer cno, Integer bno) throws Exception;

}