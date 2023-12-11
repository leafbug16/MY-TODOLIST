package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;

@Repository
public class TodolistDAOImpl implements TodolistDAO {
	@Autowired
	SqlSession session;
	String namespace = "todolistMapper.";
	
	//���� ���̵� �´� ���ϸ�� ����Ʈ ��������
	@Override
	public List<Todolist> selectAll(Todolist todolist) throws Exception {
		return session.selectList(namespace+"selectAll", todolist);
	}
	
	//���ϸ�� �ϳ� ��������
	@Override
	public Todolist select(Integer lno) throws Exception {
		return session.selectOne(namespace+"select", lno);
	}
	
	//���ϸ�� �߰�
	@Override
	public int insert(Todolist todolist) throws Exception {
		return session.insert(namespace+"insert", todolist);
	}
	
	//���ϸ�� ���� ����
	@Override
	public int update(Todolist todolist) throws Exception {
		return session.update(namespace+"update", todolist);
	}
	
	//���ϸ�� �ϳ� ����
	@Override
	public int delete(Todolist todolist) throws Exception {
		return session.delete(namespace+"delete", todolist);
	}
	
	//���ϸ�� ��ü ����
	@Override
	public int deleteAll(Todolist todolist) throws Exception {
		return session.delete(namespace+"deleteAll", todolist);
	}
	
	//�����ü������ ����� ���� ��ü����
	@Override
	public int deleteTodoAll(Todolist todolist) throws Exception {
		return session.delete(namespace+"deleteTodoAll", todolist);
	}
	
	
	//��� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//���� ��� ��������
	@Override
	public List<Todo> todoSelectAll(Todo todo) throws Exception {
		return session.selectList(namespace+"todoSelectAll", todo);
	}
	
	//���� �߰��ϱ�
	@Override
	public int todoInsert(Todo todo) throws Exception {
		return session.insert(namespace+"todoInsert", todo);
	}
	
	//���� �����ϱ�
	@Override
	public int todoUpdate(Todo todo) throws Exception {
		return session.update(namespace+"todoUpdate", todo);
	}
	
	//���� �����ϱ�
	@Override
	public int todoDelete(Todo todo) throws Exception {
		return session.delete(namespace+"todoDelete", todo);
	}
	
	//���� ��ü ����
	@Override
	public int todoDeleteAll(Todo todo) throws Exception {
		return session.delete(namespace+"todoDeleteAll", todo);
	}
	
	
	//���� �� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//�޸� ��������
	@Override
	public Todolist memoSelect(Map map) throws Exception {
		return session.selectOne(namespace+"memoSelect", map);
	}
	
	//�޸� �Է��ϱ�
	@Override
	public int memoUpdate(Todolist todolist) throws Exception {
		return session.update(namespace+"memoInsert", todolist);
	}
	
	//���� ���� ���� @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//endDate �����ϱ�
	@Override
	public int endDateUpdate(Todo todo) throws Exception {
		return session.update(namespace+"endDateUpdate", todo);
	}
	
	//dday ����
	@Override
	public int ddayUpdate(Todo todo) throws Exception {
		return session.update(namespace+"ddayUpdate", todo);
	}
	
	//dplusday ����
	@Override
	public int dplusdayUpdate(Todo todo) throws Exception {
		return session.update(namespace+"dplusdayUpdate", todo);
	}
	
	//startend ����
	@Override
	public int startendUpdate(Todo todo) throws Exception {
		return session.update(namespace+"startendUpdate", todo);
	}
	
	//repeat ����
	@Override
	public int repeatUpdate(Todo todo) throws Exception {
		return session.update(namespace+"repeatUpdate", todo);
	}
	
	//complete (üũ�ڽ�) üũ ����
	@Override
	public int completeUpdate(Todo todo) throws Exception {
		return session.update(namespace+"completeUpdate", todo);
	}
	
	//complete Ƚ�� �ø���
	@Override
	public int updateCompletes(Todo todo) throws Exception {
		return session.update(namespace+"updateCompletes", todo);
	}
	
	//�󼼸޸� ����
	@Override
	public int updateAdditionalMemo(Todo todo) throws Exception {
		return session.update(namespace+"updateAdditionalMemo", todo);
	}
	
	//todolist2.jsp ������
	//���� ���� ��� ��������
	@Override
	public List<Todo> selectMainTodos(Todo todo) throws Exception {
		return session.selectList(namespace+"selectMainTodos", todo);
	}
	
	//���� �޸� ��������
	@Override
	public Memo selectMainMemo(Map map) throws Exception {
		return session.selectOne(namespace+"selectMainMemo", map);
	}
	
	//���� �޸� �����ϱ�
	@Override
	public int updateMainMemo(Memo memo) throws Exception {
		System.out.println("DAO��ħ");
		return session.update(namespace+"updateMainMemo", memo);
	}

}

































