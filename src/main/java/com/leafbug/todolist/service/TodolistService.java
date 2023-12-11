package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

public interface TodolistService {

	//���� ���̵� �´� ���ϸ�� ����Ʈ ��������
	List<Todolist> getLists(Todolist todolist) throws Exception;

	//���ϸ�� �ϳ� ��������
	Todolist getlist(Integer lno) throws Exception;

	//���ϸ�� �ø���
	int write(Todolist todolist) throws Exception;

	//���ϸ�� ���� ����
	int modify(Todolist todolist) throws Exception;

	//���ϸ�� �ϳ� ����
	int remove(Todolist todolist) throws Exception;

	//���ϸ�� ��ü ����
	int removeAll(Todolist todolist) throws Exception;
	
	//�����ü������ ����� ���� ��ü����
	int removeAllTodoAll(Todolist todolist) throws Exception;
	
	
	//��� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� ��ü ��������
	List<Todo> getTodoLists(Todo todo) throws Exception;
	
	//���� �߰��ϱ�
	int writeTodo(Todo todo) throws Exception;
	
	//���� �����ϱ�
	int modifyTodo(Todo todo) throws Exception;
	
	//���� �����ϱ�
	int removeTodo(Todo todo) throws Exception;
	
	//���� ��ü����
	int removeTodoAll(Todo todo) throws Exception;
	
	//���� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//�޸� ��������
	Todolist getMemo(Map map) throws Exception;
	
	//�޸� �Է��ϱ�
	int modifyMemo(Todolist todolist) throws Exception;
	
	//���� ���� ���� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� endDate �����ϱ�
	int modifyEndDate(Todo todo) throws Exception;
	
	//dday �����ϱ�
	int modifyDday(Todo todo) throws Exception;
	
	//dplusday �����ϱ�
	int modifyDplusday(Todo todo) throws Exception;
	
	//startend �����ϱ�
	int modifyStartend(Todo todo) throws Exception;
	
	//repeat ����
	int modifyRepeat(Todo todo) throws Exception;
	
	//complete (üũ�ڽ�) üũ ����
	int modifyComplete(Todo todo) throws Exception;
	
	//�Ϸ�Ƚ��+1
	int modifyCompletes(Todo todo) throws Exception;
	
	//�󼼸޸� ����
	int modifyAdditionalMemo(Todo todo) throws Exception;
	
	//todolist2.jsp ������
	//���� ���� ��� ��������
	List<Todo> getMainTodos(Todo todo) throws Exception;
	
	//���� �޸� ��������
	Memo getMainMemo(Map map) throws Exception;
	
	//���� �޸� �����ϱ�
	int modifyMainMemo(Memo memo) throws Exception;
	
}




























