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
	
	//���� ���̵� �´� ���ϸ�� ����Ʈ ��������
	@Override
	public List<Todolist> getLists(Todolist todolist) throws Exception {
		return tDAO.selectAll(todolist);
	}
	
	//���ϸ�� �ϳ� ��������
	@Override
	public Todolist getlist(Integer lno) throws Exception {
		return tDAO.select(lno);
	}
	
	//���ϸ�� �߰�
	@Override
	public int write(Todolist todolist) throws Exception {
		return tDAO.insert(todolist);
	}
	
	//���ϸ�� ���� ����
	@Override
	public int modify(Todolist todolist) throws Exception {
		return tDAO.update(todolist);
	}
	
	//���ϸ�� �ϳ� ����
	@Override
	public int remove(Todolist todolist) throws Exception {
		return tDAO.delete(todolist);
	}
	
	//���ϸ�� ��ü ����
	@Override
	public int removeAll(Todolist todolist) throws Exception {
		return tDAO.deleteAll(todolist);
	}
	
	//�����ü������ ����� ���� ��ü����
	@Override
	public int removeAllTodoAll(Todolist todolist) throws Exception {
		return tDAO.deleteTodoAll(todolist);
	}
	
	
	//��� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� ��� ��������
	@Override
	public List<Todo> getTodoLists(Todo todo) throws Exception {
		return tDAO.todoSelectAll(todo);
	}
	
	//���� �߰��ϱ�
	@Override
	public int writeTodo(Todo todo) throws Exception {
		return tDAO.todoInsert(todo);
	}
	
	//���� �����ϱ�
	@Override
	public int modifyTodo(Todo todo) throws Exception {
		return tDAO.todoUpdate(todo);
	}
	
	//���� �����ϱ�
	@Override
	public int removeTodo(Todo todo) throws Exception {
		return tDAO.todoDelete(todo);
	}
	
	//���� ��ü����
	@Override
	public int removeTodoAll(Todo todo) throws Exception {
		return tDAO.todoDeleteAll(todo);
	}
	
	//���� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//�޸� ��������
	@Override
	public Todolist getMemo(Map map) throws Exception {
		return tDAO.memoSelect(map);
	}
	
	//�޸� �Է��ϱ�
	@Override
	public int modifyMemo(Todolist todolist) throws Exception {
		return tDAO.memoUpdate(todolist);
	}
	
	//���� ���� ���� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//endDate �����ϱ�
	@Override
	public int modifyEndDate(Todo todo) throws Exception {
		return tDAO.endDateUpdate(todo);
	}
	
	//dday �����ϱ�
	@Override
	public int modifyDday(Todo todo) throws Exception {
		return tDAO.ddayUpdate(todo);
	}
	
	//dplusday �����ϱ�
	@Override
	public int modifyDplusday(Todo todo) throws Exception {
		return tDAO.dplusdayUpdate(todo);
	}
	
	//startend �����ϱ�
	@Override
	public int modifyStartend(Todo todo) throws Exception {
		return tDAO.startendUpdate(todo);
	}
	
	//repeat ����
	@Override
	public int modifyRepeat(Todo todo) throws Exception {
		return tDAO.repeatUpdate(todo);
	}
	
	//complete (üũ�ڽ�) üũ ����
	@Override
	public int modifyComplete(Todo todo) throws Exception {
		return tDAO.completeUpdate(todo);
	}
	
	//�Ϸ�Ƚ�� +1
	@Override
	public int modifyCompletes(Todo todo) throws Exception {
		return tDAO.updateCompletes(todo);
	}
	
	@Override
	public int modifyAdditionalMemo(Todo todo) throws Exception {
		return tDAO.updateAdditionalMemo(todo);
	}
	
	//todolist2.jsp ������
	//���� ���� ��� ��������
	@Override
	public List<Todo> getMainTodos(Todo todo) throws Exception {
		return tDAO.selectMainTodos(todo);
	}
	
	//���� �޸� ��������
	@Override
	public Memo getMainMemo(Map map) throws Exception {
		return tDAO.selectMainMemo(map);
	}
	
	//���� �޸� �����ϱ�
	@Override
	public int modifyMainMemo(Memo memo) throws Exception {
		System.out.println("service��ħ");
		return tDAO.updateMainMemo(memo);
	}
	
}






























