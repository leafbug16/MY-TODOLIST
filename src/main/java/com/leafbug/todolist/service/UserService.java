package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

public interface UserService {

	//ȸ�� ����
	int addUser(User user) throws Exception;

	//�α��� id, pwd ����
	User findUser(String id) throws Exception;
	
	//�̸��� �ߺ�üũ��
	User findUserEmail(String email) throws Exception;

	//user ����
	int removeUser(String id) throws Exception;

	List<User> getUserAll(SearchCondition sc) throws Exception;

	int getCntUserAll(SearchCondition sc) throws Exception;
	
	//id, pwd ã��
	User findUserInfo(User user) throws Exception;
	
	//uuid ����
	int modifyUuid(Map map) throws Exception;
	
	//uuid�� ���� ���� ��ȸ
	User findUuid(Map map) throws Exception;
	
	//���� �޸� ��������
	User getMainMemo(Map map) throws Exception;
	
	//���� �޸� ����
	int modifyMainMemo(User user) throws Exception;

}











