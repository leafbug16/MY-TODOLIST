package com.leafbug.todolist.dao;

import java.util.List;

import com.leafbug.todolist.model.Comment;

public interface CommentDAO {

	int count(Integer bno) throws Exception;

	List<Comment> selectAll(Integer bno) throws Exception;

	Comment select(Integer cno) throws Exception;

	int insert(Comment comment) throws Exception;

	int update(Comment comment) throws Exception;

	int deleteAll(Integer bno) throws Exception;

	int delete(Integer cno) throws Exception;

}