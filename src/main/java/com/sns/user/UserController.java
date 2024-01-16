package com.sns.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {

	/**
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	// http://localhost/user/sign-up-view
	@GetMapping("/sign-up-view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp");
		return "template/layout";
	}
	
	/**
	 * 로그인 화면
	 * @param model
	 * @return
	 */
	// http://localhost/user/sign-in-view
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	/**
	 * 로그아웃 API
	 * @param session
	 * @return
	 */
	// http://localhost/user/sign-out
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		// 세션 삭제
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		// 리다이렉트
		return "redirect:/user/sign-in-view";
	}
}
