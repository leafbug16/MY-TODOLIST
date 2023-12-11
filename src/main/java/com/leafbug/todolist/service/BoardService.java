package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Board;
import com.leafbug.todolist.model.SearchCondition;

public interface BoardService {

	List<Board> getSearchResultPageAll(SearchCondition sc) throws Exception;

	List<Board> getSearchResultPageGuide(SearchCondition sc) throws Exception;

	List<Board> getSearchResultPageNotice(SearchCondition sc) throws Exception;

	List<Board> getSearchResultPageFree(SearchCondition sc) throws Exception;
	
	List<Board> getSearchResultPageReport(SearchCondition sc) throws Exception;

	int getSearchResultCntAll(SearchCondition sc) throws Exception;

	int getSearchResultCntGuide(SearchCondition sc) throws Exception;

	int getSearchResultCntNotice(SearchCondition sc) throws Exception;

	int getSearchResultCntFree(SearchCondition sc) throws Exception;
	
	int getSearchResultCntReport(SearchCondition sc) throws Exception;

	Board read(Integer bno) throws Exception;

	int write(Board board) throws Exception;

	int modify(Board board) throws Exception;

	int remove(Integer bno) throws Exception;

	List<Board> getResultPageLike(Map map) throws Exception;

	int getResultCntLike(Map map) throws Exception;

	int getCntMyPost(Map map) throws Exception;

	List<Board> getMyPost(Map map) throws Exception;

	List<Board> getMyComment(Map map) throws Exception;

	int getCntMyComment(Map map) throws Exception;
	
	List<Board> getMyReport(Map map) throws Exception;
	
	int getCntMyReport(Map map) throws Exception;


}