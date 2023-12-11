package com.leafbug.todolist.service;

import java.util.List;
import java.util.Map;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.SearchCondition;
import com.leafbug.todolist.model.User;

public interface UserService {

	//회원 가입
	int addUser(User user) throws Exception;

	//로그인 id, pwd 대조
	User findUser(String id) throws Exception;
	
	//이메일 중복체크용
	User findUserEmail(String email) throws Exception;

	//user 삭제
	int removeUser(String id) throws Exception;

	List<User> getUserAll(SearchCondition sc) throws Exception;

	int getCntUserAll(SearchCondition sc) throws Exception;
	
	//id, pwd 찾기
	User findUserInfo(User user) throws Exception;
	
	//uuid 수정
	int modifyUuid(Map map) throws Exception;
	
	//uuid로 유저 정보 조회
	User findUuid(Map map) throws Exception;
	
	//메인 메모 가져오기
	User getMainMemo(Map map) throws Exception;
	
	//메인 메모 수정
	int modifyMainMemo(User user) throws Exception;

}











