package com.mountaintour.mountain.controller;



import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mountaintour.mountain.dto.UserDto;
import com.mountaintour.mountain.service.UserService;

import lombok.RequiredArgsConstructor;

@RequestMapping(value="/user")
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	
	@GetMapping("/login.form")
	  public String loginForm(HttpServletRequest request, Model model) throws Exception {
	    // referer : 이전 주소가 저장되는 요청 Header 값
	    String referer = request.getHeader("referer");
	    model.addAttribute("referer", referer == null ? request.getContextPath() + "/main.do" : referer);
	    // 네이버로그인-1
	    model.addAttribute("naverLoginURL", userService.getNaverLoginURL(request));
	    return "user/login";
	  }
	
	@GetMapping("/naver/getAccessToken.do")
	public String getAccessToken(HttpServletRequest request) throws Exception{
		// 네이버 로그인 -2
		String accessToken = userService.getNaverLoginAccessToken(request);
		return "redirect:/user/naver/getProfile.do?accessToken=" + accessToken;
	}
	
	@GetMapping("/naver/getProfile.do")
	public String getProfile(HttpServletRequest request, HttpServletRequest response, Model model) throws Exception{
		// 네이버 로그인 -3
		UserDto naverProfile = userService.getNaverProfile(request.getParameter("accessToken"));
		//네이버 로그인 후속 작업(처음 시도 : 간편가입, 이미 가입 : 로그인)
		UserDto user = userService.getUser(naverProfile.getEmail());
		if(user == null) {
			//네이버 간편가입 페이지로 이동
			model.addAttribute("naverProfile", naverProfile);
			return "user/naver_join"; 
		} else {
			//naverProfile로 로그인 처리하기
			userService.naverLogin(request, null, naverProfile);
			return "redirect:/main.do";
		}
	}
	@PostMapping("/naver/join.do")
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		userService.naverJoin(request, response);
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
	
	@GetMapping("/join.form")
	public String joinForm(@RequestParam(value="service", required=false, defaultValue="off") String service
						  , @RequestParam(value="event", required=false, defaultValue ="off") String event
						  , Model model) {
		String rtn = null;
		if(service.equals("off")) {
			rtn = "redirect:/main.do";
		} else {
			model.addAttribute("event", event); //user폴더 join.jsp로 전달하는 event는 "on"또는 "off"값을 가진다. 
			rtn = "user/join";
		}
		return rtn;
		
	}
    @GetMapping(value="/checkEmail.do", produces=MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> checkEmail(@RequestParam String email){
    	return userService.checkEmail(email);
    }
    
    @GetMapping(value="/sendCode.do", produces=MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> sendCode(@RequestParam String email){
    	return userService.sendCode(email);
    }
	
    @PostMapping("/join.do")
    public void join(HttpServletRequest request, HttpServletResponse response) {
    	userService.join(request, response);
    }
    
	@GetMapping("/mypage.form")
	public String mypageForm() {
	    return "user/mypage";
	  }
	
	@PostMapping(value="/modify.do", produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, Object>> modify(HttpServletRequest request){
		return userService.modify(request);
	}
	
	@GetMapping("/modifyPw.form")
	public String modifyPwForm() {
		return "user/pw";
	}
	
	@PostMapping("/modifyPw.do")
	public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyPw(request, response);
	}
	
	@PostMapping("/leave.do")
	public void leave(HttpServletRequest request, HttpServletResponse response) {
		userService.leave(request, response);
	}
	
	//아이디, 비밀번호 찾기
	@PostMapping("/findIdCheck.do")
	public String findId(HttpServletRequest request, HttpServletResponse response) {
		userService.findId(request,response);
		return"";
	}
	
	@GetMapping("/findIdCheck.form")
	public String findIdCheck() {
		return "user/findIdCheck";
	}
	
	//아이디 찾기-일치검사
	//아이디 찾기 
		@RequestMapping(value = "/find_id.do", method = RequestMethod.POST, produces="application/json")
		@ResponseBody
		public UserDto find_id(@RequestParam("name") String name, @RequestParam("mobile") String mobile) {
			
		UserDto result = userService.find_id(name, mobile);
			
		return result;
		}
		
	
	
	//찜하기
	@GetMapping("/heart.form")
	public String heartProduct() {
	    return "user/heartProduct";
	  }
	
	@ResponseBody
	@RequestMapping(value = "/heartList.do?page={p}", method = RequestMethod.GET, produces="application/json")
	public Map<String, Object> heartProductList(@PathVariable(value = "p", required = false) Optional<String> opt, HttpServletRequest request) {
	  int page = Integer.parseInt(opt.orElse("1"));
	   return userService.heartProduct(page, request);
	    		
	  }
	
	
	
}

	