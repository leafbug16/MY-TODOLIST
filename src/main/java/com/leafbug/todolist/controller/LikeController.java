package com.leafbug.todolist.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.leafbug.todolist.dao.BoardDAO;
import com.leafbug.todolist.service.LikeService;

@Controller
public class LikeController {
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	LikeService ls;
	
	//정보 표시
	@ResponseBody
	@RequestMapping("/showLike")
	public ResponseEntity<Map<String, Object>> showLike(Integer bno, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		try {
			int res = ls.getLikeCount(bno, session.getAttribute("id")+"");
			map.put("res", res);		
			int resAll = ls.getLikeCountAll(bno);
			map.put("resAll", resAll);
			return new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
	}
	
	//좋아요 추가
	@PostMapping("/addLike")
	@ResponseBody
	public ResponseEntity<String> addLike(Integer bno, HttpSession session) {
		try {
			int res = ls.addLike(bno, session.getAttribute("id")+"");
			if(res != 1) throw new Exception("add failed");
			return new ResponseEntity<>("ADD_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("ADD_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//좋아요 해제
	@PostMapping("/removeLike")
	@ResponseBody
	public ResponseEntity<String> removeLike(Integer bno, HttpSession session) {
		try {
			int res = ls.removeLike(bno, session.getAttribute("id")+"");
			if(res != 1) throw new Exception("remove failed");
			return new ResponseEntity<>("REMOVE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("REMOVE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	
}


























