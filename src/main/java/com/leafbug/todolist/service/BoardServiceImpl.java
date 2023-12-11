package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leafbug.todolist.dao.BoardDAO;
import com.leafbug.todolist.model.Board;
import com.leafbug.todolist.model.SearchCondition;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	@Override
	public List<Board> getSearchResultPageAll(SearchCondition sc) throws Exception {
		return boardDAO.searchSelectPageAll(sc);
	}
	
	@Override
	public List<Board> getSearchResultPageGuide(SearchCondition sc) throws Exception {
		return boardDAO.searchSelectPageGuide(sc);
	}
	
	@Override
	public List<Board> getSearchResultPageNotice(SearchCondition sc) throws Exception {
		return boardDAO.searchSelectPageNotice(sc);
	}
	
	@Override
	public List<Board> getSearchResultPageFree(SearchCondition sc) throws Exception {
		return boardDAO.searchSelectPageFree(sc);
	}
	
	@Override
	public List<Board> getSearchResultPageReport(SearchCondition sc) throws Exception {
		return boardDAO.searchSelectPageReport(sc);
	}
	
	@Override
	public int getSearchResultCntAll(SearchCondition sc) throws Exception {
		return boardDAO.searchResultCntAll(sc);
	}
	
	@Override
	public int getSearchResultCntGuide(SearchCondition sc) throws Exception {
		return boardDAO.searchResultCntGuide(sc);
	}
	
	@Override
	public int getSearchResultCntNotice(SearchCondition sc) throws Exception {
		return boardDAO.searchResultCntNotice(sc);
	}
	
	@Override
	public int getSearchResultCntFree(SearchCondition sc) throws Exception {
		return boardDAO.searchResultCntFree(sc);
	}
	
	@Override
	public int getSearchResultCntReport(SearchCondition sc) throws Exception {
		return boardDAO.searchResultCntReport(sc);
	}
	
	//게시판 읽기 = 게시판 조회 + 조회수 1증가
	@Override
	public Board read(Integer bno) throws Exception {
		Board board = boardDAO.select(bno); // 조회 후 읽었으므로 조회수 1 증가
		boardDAO.increaseViews(bno);
		return board;
	}
	
	//게시판 글 쓰기
	@Override
	public int write(Board board) throws Exception {
		return boardDAO.insert(board);
	}
	
	//수정
	@Override
	public int modify(Board board) throws Exception {
		return boardDAO.update(board);
	}
	
	//삭제
	@Override
	public int remove(Integer bno) throws Exception {
		return boardDAO.delete(bno);
	}
	
	//좋아요 누른 글 목록 조회
	@Override
	public List<Board> getResultPageLike(Map map) throws Exception {
		return boardDAO.selectPageLike(map);
	}
	
	@Override
	public int getResultCntLike(Map map) throws Exception {
		return boardDAO.selectCntLike(map);
	}
	
	//내가 쓴 글 목록 조회
	@Override
	public List<Board> getMyPost(Map map) throws Exception {
		return boardDAO.selectMyPost(map);
	}
	
	@Override
	public int getCntMyPost(Map map) throws Exception {
		return boardDAO.selectCntMyPost(map);
	}
	
	@Override
	public List<Board> getMyComment(Map map) throws Exception {
		return boardDAO.selectMyComment(map);
	}
	
	@Override
	public int getCntMyComment(Map map) throws Exception {
		return boardDAO.selectCntMyComment(map);
	}
	
	//내가 쓴 report 목록 조회
	@Override
	public List<Board> getMyReport(Map map) throws Exception {
		return boardDAO.selectMyReport(map);
	}
	
	@Override
	public int getCntMyReport(Map map) throws Exception {
		return boardDAO.selectCntMyReport(map);
	}
	
	
}






