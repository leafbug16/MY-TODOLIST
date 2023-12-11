package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leafbug.todolist.dao.TodolistDAO;
import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

@Service
public class TodolistServiceImpl implements TodolistService {
	@Autowired
	TodolistDAO tDAO;
	
	//유저 아이디에 맞는 할일목록 리스트 가져오기
	@Override
	public List<Todolist> getLists(Todolist todolist) throws Exception {
		return tDAO.selectAll(todolist);
	}
	
	//할일목록 하나 가져오기
	@Override
	public Todolist getlist(Integer lno) throws Exception {
		return tDAO.select(lno);
	}
	
	//할일목록 추가
	@Override
	public int write(Todolist todolist) throws Exception {
		return tDAO.insert(todolist);
	}
	
	//할일목록 제목 수정
	@Override
	public int modify(Todolist todolist) throws Exception {
		return tDAO.update(todolist);
	}
	
	//할일목록 하나 삭제
	@Override
	public int remove(Todolist todolist) throws Exception {
		return tDAO.delete(todolist);
	}
	
	//할일목록 전체 삭제
	@Override
	public int removeAll(Todolist todolist) throws Exception {
		return tDAO.deleteAll(todolist);
	}
	
	//목록전체삭제와 연결된 할일 전체삭제
	@Override
	public int removeAllTodoAll(Todolist todolist) throws Exception {
		return tDAO.deleteTodoAll(todolist);
	}
	
	
	//목록 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//할일 모두 가져오기
	@Override
	public List<Todo> getTodoLists(Todo todo) throws Exception {
		return tDAO.todoSelectAll(todo);
	}
	
	//할일 추가하기
	@Override
	public int writeTodo(Todo todo) throws Exception {
		return tDAO.todoInsert(todo);
	}
	
	//할일 수정하기
	@Override
	public int modifyTodo(Todo todo) throws Exception {
		return tDAO.todoUpdate(todo);
	}
	
	//할일 삭제하기
	@Override
	public int removeTodo(Todo todo) throws Exception {
		return tDAO.todoDelete(todo);
	}
	
	//할일 전체삭제
	@Override
	public int removeTodoAll(Todo todo) throws Exception {
		return tDAO.todoDeleteAll(todo);
	}
	
	//할일 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//메모 가져오기
	@Override
	public Todolist getMemo(Map map) throws Exception {
		return tDAO.memoSelect(map);
	}
	
	//메모 입력하기
	@Override
	public int modifyMemo(Todolist todolist) throws Exception {
		return tDAO.memoUpdate(todolist);
	}
	
	//할일 세팅 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//endDate 수정하기
	@Override
	public int modifyEndDate(Todo todo) throws Exception {
		return tDAO.endDateUpdate(todo);
	}
	
	//dday 수정하기
	@Override
	public int modifyDday(Todo todo) throws Exception {
		return tDAO.ddayUpdate(todo);
	}
	
	//dplusday 수정하기
	@Override
	public int modifyDplusday(Todo todo) throws Exception {
		return tDAO.dplusdayUpdate(todo);
	}
	
	//startend 수정하기
	@Override
	public int modifyStartend(Todo todo) throws Exception {
		return tDAO.startendUpdate(todo);
	}
	
	//repeat 수정
	@Override
	public int modifyRepeat(Todo todo) throws Exception {
		return tDAO.repeatUpdate(todo);
	}
	
	//complete (체크박스) 체크 수정
	@Override
	public int modifyComplete(Todo todo) throws Exception {
		return tDAO.completeUpdate(todo);
	}
	
	//완료횟수 +1
	@Override
	public int modifyCompletes(Todo todo) throws Exception {
		return tDAO.updateCompletes(todo);
	}
	
	@Override
	public int modifyAdditionalMemo(Todo todo) throws Exception {
		return tDAO.updateAdditionalMemo(todo);
	}
	
	//todolist2.jsp 공사중
	//유저 할일 모두 가져오기
	@Override
	public List<Todo> getMainTodos(Todo todo) throws Exception {
		return tDAO.selectMainTodos(todo);
	}
	
	//메인 메모 가져오기
	@Override
	public Memo getMainMemo(Map map) throws Exception {
		return tDAO.selectMainMemo(map);
	}
	
	//메인 메모 수정하기
	@Override
	public int modifyMainMemo(Memo memo) throws Exception {
		System.out.println("service거침");
		return tDAO.updateMainMemo(memo);
	}
	
}






























