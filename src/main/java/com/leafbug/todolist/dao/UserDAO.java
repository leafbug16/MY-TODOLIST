package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

public interface UserDAO {

	//ȸ������
	int insert(User user) throws Exception;

	//�α��� id, pwd ���� üũ
	User select(String id) throws Exception;
	
	//�̸��� �ߺ�üũ��
	User selectEmail(String email) throws Exception;
	
	//���� ����
	int delete(String id) throws Exception;

	List<User> selectUserAll(SearchCondition sc) throws Exception;

	int selectCntUserAll(SearchCondition sc) throws Exception;
	
	//id pwd ã��
	User selectUserInfo(User user) throws Exception;
	
	//uuid ����
	int updateUuid(Map map) throws Exception;
	
	//uuid�� ���� ���� ��ȸ
	User selectUuid(Map map) throws Exception;
	
	//���� �޸� ��������
	User selectMainMemo(Map map) throws Exception;
	
	//���� �޸� ����
	int updateMainMemo(User user) throws Exception;

}