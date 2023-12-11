package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.leafbug.todolist.dao.UserDAO;
import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;
	
	//ȸ������
	@Override
	public int addUser(User user) throws Exception {
		return userDAO.insert(user);
	}
	
	//�α��� id/pwd ����
	@Override
	public User findUser(String id) throws Exception {
		return userDAO.select(id);
	}
	
	//�̸��� �ߺ�üũ��
	@Override
	public User findUserEmail(String email) throws Exception {
		return userDAO.selectEmail(email);
	}
	
	//���� ����
	@Override
	public int removeUser(String id) throws Exception {
		return userDAO.delete(id);
	}
	
	//���� ��� ��ȸ
	@Override
	public List<User> getUserAll(SearchCondition sc) throws Exception {
		return userDAO.selectUserAll(sc);
	}
	
	//���� �� ��ȸ
	@Override
	public int getCntUserAll(SearchCondition sc) throws Exception {
		return userDAO.selectCntUserAll(sc);
	}
	
	//id, pwd ã��
	@Override
	public User findUserInfo(User user) throws Exception {
		return userDAO.selectUserInfo(user);
	}
	
	//uuid ����
	@Override
	public int modifyUuid(Map map) throws Exception {
		return userDAO.updateUuid(map);
	}
	
	//uuid�� ���� ���� ��ȸ
	@Override
	public User findUuid(Map map) throws Exception {
		return userDAO.selectUuid(map);
	}
	
	//���� �޸� ��������
	@Override
	public User getMainMemo(Map map) throws Exception {
		return userDAO.selectMainMemo(map);
	}
	
	//���� �޸� �����ϱ�
	@Override
	public int modifyMainMemo(User user) throws Exception {
		return userDAO.updateMainMemo(user);
	}
	
}















