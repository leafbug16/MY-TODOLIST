package com.leafbug.todolist.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.leafbug.todolist.model.User;
import com.leafbug.todolist.service.UserService;

@Controller
@RequestMapping("/login")
public class LoginController {
	@Autowired
	UserService userService;
	
	@GetMapping("/form")
	public String loginForm(HttpServletRequest request, Model m, HttpSession session) throws Exception {
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("auto")) {
	            	Map map = new HashMap();
	            	map.put("uuid", cookie.getValue());
	            	User user = userService.findUuid(map);
	            	session.setAttribute("id", user.getId());
	            	session.setMaxInactiveInterval(60*60*24*365);
	            	return "redirect:/todolist/main";
	            }
	        }
	    }
	    if(session.getAttribute("id")!=null && !session.getAttribute("id").equals("")) {
	    	return "redirect:/todolist/main";
	    }
	    
	    m.addAttribute("sessionId", session.getAttribute("id")+"");
	    return "index";
	}
	
	@PostMapping("/action")
	public String loginAction(String toURL, String id, String pwd, boolean auto, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redatt) throws Exception {
		User user = userService.findUser(id);
		if (user == null || !user.getId().equals(id) || !user.getPwd().equals(pwd)) {
			redatt.addFlashAttribute("msg", "login-failed");
			return "redirect:/login/form";
		}
		
		int res = 0;
		//uuid积己
		if(auto) {
			String uuid = UUID.randomUUID().toString();
			Map map = new HashMap();
			map.put("id", id);
			map.put("uuid", uuid);
			res = userService.modifyUuid(map);
			Cookie cookie = new Cookie("auto", uuid);
			cookie.setMaxAge(60*60*24*7); //1林老
			response.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("auto", "");
			cookie.setMaxAge(0);
			response.addCookie(cookie);	
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("id", id);
		session.setMaxInactiveInterval(60*60*24*7);
		return "redirect:/todolist/main";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		//auto 捻虐 昏力
		Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("auto")) {
	            	cookie.setMaxAge(0);
	            	response.addCookie(cookie);
	            }
	        }
	    }
		return "redirect:/login/form";
	}
}
