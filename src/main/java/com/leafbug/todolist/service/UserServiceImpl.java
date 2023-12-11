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
	
	//회원가입
	@Override
	public int addUser(User user) throws Exception {
		return userDAO.insert(user);
	}
	
	//로그인 id/pwd 대조
	@Override
	public User findUser(String id) throws Exception {
		return userDAO.select(id);
	}
	
	//이메일 중복체크용
	@Override
	public User findUserEmail(String email) throws Exception {
		return userDAO.selectEmail(email);
	}
	
	//유저 삭제
	@Override
	public int removeUser(String id) throws Exception {
		return userDAO.delete(id);
	}
	
	//유저 목록 조회
	@Override
	public List<User> getUserAll(SearchCondition sc) throws Exception {
		return userDAO.selectUserAll(sc);
	}
	
	//유저 수 조회
	@Override
	public int getCntUserAll(SearchCondition sc) throws Exception {
		return userDAO.selectCntUserAll(sc);
	}
	
	//id, pwd 찾기
	@Override
	public User findUserInfo(User user) throws Exception {
		return userDAO.selectUserInfo(user);
	}
	
	//uuid 수정
	@Override
	public int modifyUuid(Map map) throws Exception {
		return userDAO.updateUuid(map);
	}
	
	//uuid로 유저 정보 조회
	@Override
	public User findUuid(Map map) throws Exception {
		return userDAO.selectUuid(map);
	}
	
	//메인 메모 가져오기
	@Override
	public User getMainMemo(Map map) throws Exception {
		return userDAO.selectMainMemo(map);
	}
	
	//메인 메모 수정하기
	@Override
	public int modifyMainMemo(User user) throws Exception {
		return userDAO.updateMainMemo(user);
	}
	
}















