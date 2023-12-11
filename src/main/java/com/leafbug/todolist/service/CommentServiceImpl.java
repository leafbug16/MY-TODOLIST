package com.leafbug.todolist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leafbug.todolist.dao.BoardDAO;
import com.leafbug.todolist.dao.CommentDAO;
import com.leafbug.todolist.model.Comment;

@Service
public class CommentServiceImpl implements CommentService {
	private BoardDAO boardDAO;
	private CommentDAO commentDAO;
	public CommentServiceImpl() {}
	@Autowired
	public CommentServiceImpl(BoardDAO boardDAO, CommentDAO commentDAO) {
		this.boardDAO = boardDAO;
		this.commentDAO = commentDAO;
	}
	
	//특정 게시글 댓글 수 조회
	@Override
	public int getCount(Integer bno) throws Exception {
		return commentDAO.count(bno);
	}
	
	//특정 게시글 댓글 모두 조회
	@Override
	public List<Comment> getList(Integer bno) throws Exception {
		return commentDAO.selectAll(bno);
	}
	
	//특정 댓글 하나 조회
	@Override
	public Comment read(Integer cno) throws Exception {
		return commentDAO.select(cno);
	}
	
	//댓글 작성
	@Override
	public int write(Comment comment) throws Exception {
		boardDAO.updateCommentCnt(comment.getBno(), 1);
		return commentDAO.insert(comment);
	}
	
	//댓글 수정
	@Override
	public int modify(Comment comment) throws Exception {
		return commentDAO.update(comment);
	}
	
	//댓글 삭제
	@Override
	public int remove(Integer cno, Integer bno) throws Exception {
		int rowCnt = boardDAO.updateCommentCnt(bno, -1);
		rowCnt = commentDAO.delete(cno);
		return rowCnt;
	}
	
}
