package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

public interface TodolistDAO {

	//유저 아이디에 맞는 할일목록 리스트 가져오기
	List<Todolist> selectAll(Todolist todolist) throws Exception;

	//할일목록 하나 가져오기
	Todolist select(Integer lno) throws Exception;

	//할일목록 늘리기
	int insert(Todolist todolist) throws Exception;

	//할일목록 제목 수정
	int update(Todolist todolist) throws Exception;

	//할일목록 하나 삭제
	int delete(Todolist todolist) throws Exception;

	//할일목록 전체 삭제
	int deleteAll(Todolist todolist) throws Exception;
	
	//목록전체삭제와 연결된 할일 전체삭제
	int deleteTodoAll(Todolist todolist) throws Exception;
	
	//목록 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//할일 모두 가져오기
	List<Todo> todoSelectAll(Todo todo) throws Exception;
	
	//할일 추가하기
	int todoInsert(Todo todo) throws Exception;
	
	//할일 수정하기
	int todoUpdate(Todo todo) throws Exception;
	
	//할일 삭제하기
	int todoDelete(Todo todo) throws Exception;
	
	//할일 전체삭제
	int todoDeleteAll(Todo todo) throws Exception;
	
	//할일 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//메모 가져오기
	Todolist memoSelect(Map map) throws Exception;
	
	//메모 입력하기
	int memoUpdate(Todolist todolist) throws Exception;
	
	//할일 세팅 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//할일 endDate 수정하기
	int endDateUpdate(Todo todo) throws Exception;
	
	//dday수정
	int ddayUpdate(Todo todo) throws Exception;
	
	//dplusday 수정
	int dplusdayUpdate(Todo todo) throws Exception;
	
	//startend 수정
	int startendUpdate(Todo todo) throws Exception;
	
	//repeat 수정
	int repeatUpdate(Todo todo) throws Exception;
	
	//complete (체크박스) 체크 수정
	int completeUpdate(Todo todo) throws Exception;
	
	//완료횟수+1
	int updateCompletes(Todo todo) throws Exception;
	
	//상세메모 수정
	int updateAdditionalMemo(Todo todo) throws Exception;
	
	//todolist2.jsp 공사중
	//유저 할일 모두 가져오기
	List<Todo> selectMainTodos(Todo todo) throws Exception;
	
	//메인 메모 가져오기
	Memo selectMainMemo(Map map) throws Exception;
	
	//메인 메모 수정하기
	int updateMainMemo(Memo memo) throws Exception;

}




















