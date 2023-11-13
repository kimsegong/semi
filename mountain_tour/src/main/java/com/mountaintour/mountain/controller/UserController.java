package com.mountaintour.mountain.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mountaintour.mountain.service.UserService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/user")
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	
	@GetMapping("/login.form")
	public String loginForm(HttpServletRequest request, Model model) throws Exception{
		//referer : 이전 주소가 저장되는 요청 Header 값
		String referer = request.getHeader("referer");
		model.addAttribute("referer", referer == null ? request.getContextPath() + "/main.do" : referer);
		
		return "user/login";
	}
	
	@PostMapping("/login.do")
	public void login(HttpServletRequest request, HttpServletResponse response) throws Exception{
		userService.login(request, response);
	}
	
	@GetMapping("/logout.do")
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request, response);
	}
	
	@GetMapping("/agree.form")
	public String agreeFrom() {
		return "user/agree";
	}
}