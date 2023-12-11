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
	
	//회원가입
	@Override
	public int insert(User user) throws Exception {
		return session.insert(namespace+"insert", user);
	}
	
	//로그인 id, pwd 대조 체크
	@Override
	public User select(String id) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		return session.selectOne(namespace+"select", map);
	}
	
	//이메일 중복체크용
	@Override
	public User selectEmail(String email) throws Exception {
		Map map = new HashMap();
		map.put("email", email);
		return session.selectOne(namespace+"selectEmail", map);
	}
	
	//유저 삭제
	@Override
	public int delete(String id) throws Exception {
		Map map = new HashMap();
		map.put("id", id);
		return session.delete(namespace+"delete", map);
	}
	
	//유저 목록 조회
	@Override
	public List<User> selectUserAll(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"selectUserAll", sc);
	}
	
	//유저 수 조회
	@Override
	public int selectCntUserAll(SearchCondition sc) throws Exception {
		return session.selectOne(namespace+"selectCntUserAll", sc);
	}
	
	//아이디 비밀번호 찾기
	@Override
	public User selectUserInfo(User user) throws Exception {
		return session.selectOne(namespace+"selectUserInfo", user);
	}
	
	//uuid 수정
	@Override
	public int updateUuid(Map map) throws Exception {
		return session.update(namespace+"updateUuid", map);
	}
	
	//uuid로 사용자 정보 조회
	@Override
	public User selectUuid(Map map) throws Exception {
		return session.selectOne(namespace+"selectUuid", map);
	}
	
	//메인 메모 입력
	@Override
	public User selectMainMemo(Map map) throws Exception {
		return session.selectOne(namespace+"selectMainMemo", map);
	}
	
	//메인 메모 수정
	@Override
	public int updateMainMemo(User user) throws Exception {
		return session.update(namespace+"updateMainMemo", user);
	}
	
	
}

















