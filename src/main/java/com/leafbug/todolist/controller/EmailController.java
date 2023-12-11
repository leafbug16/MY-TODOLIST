package com.leafbug.todolist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.leafbug.todolist.model.User;
import com.leafbug.todolist.service.MailService;
import com.leafbug.todolist.service.UserService;

@Controller
public class EmailController {
	@Autowired
	private MailService mailService;
	@Autowired
	UserService us;

	@RequestMapping("/findUserInfo")
	@ResponseBody
	public ResponseEntity<String> sendEmail(String email) throws Exception {
		String msg = "";
		User user = new User();
		user.setEmail(email);
		user = us.findUserInfo(user);
		String addr = "rkdxhd1423@gmail.com";
		String subject = "MY TODOLIST 아이디/비밀번호";
		
		if (user != null && user.getId() != null) {
        String body = "아이디 : "+user.getId()+" 비밀번호 : "+user.getPwd();
        mailService.sendEmail(email, addr, subject, body);
        msg = "success";
	    } else {
	      msg = "fail";
	    }
		return new ResponseEntity<String>(msg, HttpStatus.OK);
	}

}

