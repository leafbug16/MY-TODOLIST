package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

public interface TodolistDAO {

	//���� ���̵� �´� ���ϸ�� ����Ʈ ��������
	List<Todolist> selectAll(Todolist todolist) throws Exception;

	//���ϸ�� �ϳ� ��������
	Todolist select(Integer lno) throws Exception;

	//���ϸ�� �ø���
	int insert(Todolist todolist) throws Exception;

	//���ϸ�� ���� ����
	int update(Todolist todolist) throws Exception;

	//���ϸ�� �ϳ� ����
	int delete(Todolist todolist) throws Exception;

	//���ϸ�� ��ü ����
	int deleteAll(Todolist todolist) throws Exception;
	
	//�����ü������ ����� ���� ��ü����
	int deleteTodoAll(Todolist todolist) throws Exception;
	
	//��� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� ��� ��������
	List<Todo> todoSelectAll(Todo todo) throws Exception;
	
	//���� �߰��ϱ�
	int todoInsert(Todo todo) throws Exception;
	
	//���� �����ϱ�
	int todoUpdate(Todo todo) throws Exception;
	
	//���� �����ϱ�
	int todoDelete(Todo todo) throws Exception;
	
	//���� ��ü����
	int todoDeleteAll(Todo todo) throws Exception;
	
	//���� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//�޸� ��������
	Todolist memoSelect(Map map) throws Exception;
	
	//�޸� �Է��ϱ�
	int memoUpdate(Todolist todolist) throws Exception;
	
	//���� ���� ���� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� endDate �����ϱ�
	int endDateUpdate(Todo todo) throws Exception;
	
	//dday����
	int ddayUpdate(Todo todo) throws Exception;
	
	//dplusday ����
	int dplusdayUpdate(Todo todo) throws Exception;
	
	//startend ����
	int startendUpdate(Todo todo) throws Exception;
	
	//repeat ����
	int repeatUpdate(Todo todo) throws Exception;
	
	//complete (üũ�ڽ�) üũ ����
	int completeUpdate(Todo todo) throws Exception;
	
	//�Ϸ�Ƚ��+1
	int updateCompletes(Todo todo) throws Exception;
	
	//�󼼸޸� ����
	int updateAdditionalMemo(Todo todo) throws Exception;
	
	//todolist2.jsp ������
	//���� ���� ��� ��������
	List<Todo> selectMainTodos(Todo todo) throws Exception;
	
	//���� �޸� ��������
	Memo selectMainMemo(Map map) throws Exception;
	
	//���� �޸� �����ϱ�
	int updateMainMemo(Memo memo) throws Exception;

}




















