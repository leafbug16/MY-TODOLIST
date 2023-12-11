package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Board;
import com.leafbug.todolist.model.SearchCondition;

public interface BoardDAO {

	List<Board> searchSelectPageAll(SearchCondition sc) throws Exception;

	List<Board> searchSelectPageGuide(SearchCondition sc) throws Exception;

	List<Board> searchSelectPageNotice(SearchCondition sc) throws Exception;

	List<Board> searchSelectPageFree(SearchCondition sc) throws Exception;

	int searchResultCntAll(SearchCondition sc) throws Exception;

	int searchResultCntGuide(SearchCondition sc) throws Exception;

	int searchResultCntNotice(SearchCondition sc) throws Exception;

	int searchResultCntFree(SearchCondition sc) throws Exception;

	Board select(Integer bno) throws Exception;

	int increaseViews(Integer bno) throws Exception;

	int insert(Board board) throws Exception;

	int update(Board board) throws Exception;

	int delete(Integer bno) throws Exception;

	int updateCommentCnt(Integer bno, Integer comments);

	int updateLikeCnt(Integer bno, Integer likes);

	List<Board> selectPageLike(Map map) throws Exception;

	int selectCntLike(Map map) throws Exception;

	List<Board> selectMyPost(Map map) throws Exception;

	int selectCntMyPost(Map map) throws Exception;

	List<Board> selectMyComment(Map map) throws Exception;

	int selectCntMyComment(Map map) throws Exception;

	List<Board> searchSelectPageReport(SearchCondition sc) throws Exception;

	int searchResultCntReport(SearchCondition sc) throws Exception;
	
	List<Board> selectMyReport(Map map) throws Exception;
	
	int selectCntMyReport(Map map) throws Exception;

}