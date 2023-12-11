package com.leafbug.todolist.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

@Repository
public class UserDAOImpl implements UserDAO {
	@Autowired
	SqlSession session;
	String namespace = "userMapper.";
	
	//ȸ������
	@Override
	public int insert(User user) throws Exception {
		return session.insert(namespace+"insert", user);
	}
	
	//�α��� id, pwd ���� üũ
	@Override
	public User select(String id) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		return session.selectOne(namespace+"select", map);
	}
	
	//�̸��� �ߺ�üũ��
	@Override
	public User selectEmail(String email) throws Exception {
		Map map = new HashMap();
		map.put("email", email);
		return session.selectOne(namespace+"selectEmail", map);
	}
	
	//���� ����
	@Override
	public int delete(String id) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		return session.delete(namespace+"delete", map);
	}
	
	//���� ��� ��ȸ
	@Override
	public List<User> selectUserAll(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"selectUserAll", sc);
	}
	
	//���� �� ��ȸ
	@Override
	public int selectCntUserAll(SearchCondition sc) throws Exception {
		return session.selectOne(namespace+"selectCntUserAll", sc);
	}
	
	//���̵� ��й�ȣ ã��
	@Override
	public User selectUserInfo(User user) throws Exception {
		return session.selectOne(namespace+"selectUserInfo", user);
	}
	
	//uuid ����
	@Override
	public int updateUuid(Map map) throws Exception {
		return session.update(namespace+"updateUuid", map);
	}
	
	//uuid�� ����� ���� ��ȸ
	@Override
	public User selectUuid(Map map) throws Exception {
		return session.selectOne(namespace+"selectUuid", map);
	}
	
	//���� �޸� �Է�
	@Override
	public User selectMainMemo(Map map) throws Exception {
		return session.selectOne(namespace+"selectMainMemo", map);
	}
	
	//���� �޸� ����
	@Override
	public int updateMainMemo(User user) throws Exception {
		return session.update(namespace+"updateMainMemo", user);
	}
	
	
}

















