package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

public interface TodolistService {

	//유저 아이디에 맞는 할일목록 리스트 가져오기
	List<Todolist> getLists(Todolist todolist) throws Exception;

	//할일목록 하나 가져오기
	Todolist getlist(Integer lno) throws Exception;

	//할일목록 늘리기
	int write(Todolist todolist) throws Exception;

	//할일목록 제목 수정
	int modify(Todolist todolist) throws Exception;

	//할일목록 하나 삭제
	int remove(Todolist todolist) throws Exception;

	//할일목록 전체 삭제
	int removeAll(Todolist todolist) throws Exception;
	
	//목록전체삭제와 연결된 할일 전체삭제
	int removeAllTodoAll(Todolist todolist) throws Exception;
	
	
	//목록 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//할일 전체 가져오기
	List<Todo> getTodoLists(Todo todo) throws Exception;
	
	//할일 추가하기
	int writeTodo(Todo todo) throws Exception;
	
	//할일 수정하기
	int modifyTodo(Todo todo) throws Exception;
	
	//할일 삭제하기
	int removeTodo(Todo todo) throws Exception;
	
	//할일 전체삭제
	int removeTodoAll(Todo todo) throws Exception;
	
	//할일 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//메모 가져오기
	Todolist getMemo(Map map) throws Exception;
	
	//메모 입력하기
	int modifyMemo(Todolist todolist) throws Exception;
	
	//할일 세팅 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//할일 endDate 수정하기
	int modifyEndDate(Todo todo) throws Exception;
	
	//dday 수정하기
	int modifyDday(Todo todo) throws Exception;
	
	//dplusday 수정하기
	int modifyDplusday(Todo todo) throws Exception;
	
	//startend 수정하기
	int modifyStartend(Todo todo) throws Exception;
	
	//repeat 수정
	int modifyRepeat(Todo todo) throws Exception;
	
	//complete (체크박스) 체크 수정
	int modifyComplete(Todo todo) throws Exception;
	
	//완료횟수+1
	int modifyCompletes(Todo todo) throws Exception;
	
	//상세메모 수정
	int modifyAdditionalMemo(Todo todo) throws Exception;
	
	//todolist2.jsp 공사중
	//유저 할일 모두 가져오기
	List<Todo> getMainTodos(Todo todo) throws Exception;
	
	//메인 메모 가져오기
	Memo getMainMemo(Map map) throws Exception;
	
	//메인 메모 수정하기
	int modifyMainMemo(Memo memo) throws Exception;
	
}




























