package com.leafbug.todolist.dao;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

public interface UserDAO {

	//회원가입
	int insert(User user) throws Exception;

	//로그인 id, pwd 대조 체크
	User select(String id) throws Exception;
	
	//이메일 중복체크용
	User selectEmail(String email) throws Exception;
	
	//유저 삭제
	int delete(String id) throws Exception;

	List<User> selectUserAll(SearchCondition sc) throws Exception;

	int selectCntUserAll(SearchCondition sc) throws Exception;
	
	//id pwd 찾기
	User selectUserInfo(User user) throws Exception;
	
	//uuid 수정
	int updateUuid(Map map) throws Exception;
	
	//uuid로 유저 정보 조회
	User selectUuid(Map map) throws Exception;
	
	//메인 메모 가져오기
	User selectMainMemo(Map map) throws Exception;
	
	//메인 메모 수정
	int updateMainMemo(User user) throws Exception;

}