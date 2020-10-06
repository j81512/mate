package com.kh.mate.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParser;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.mate.naver.NaverLoginBO;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
public class MemberController {

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	//일반 회원 login
	@RequestMapping(value = "/member/memberLogin.do"
			,method = RequestMethod.GET)
		public String memberLogin() {
		return "member/login";
	}
	//naver login 
	@RequestMapping(value = "/member/login.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String Login(Model model, HttpSession session) {

		log.debug("login 호출 확인");
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		log.debug("naverAuthUrl = {}", naverAuthUrl);
		model.addAttribute("url", naverAuthUrl);
		//view
		return "member/naverLogin";
	}
	
	//naverLogin 성공시
	@RequestMapping(value = "/callback.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException {
		log.debug("callback 호출 확인");
	
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAcessToken(session, code, state);
		log.debug("oauthToken = {}", oauthToken);
		
		//로그인 사용자 정보 읽어 오는것
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		model.addAttribute("result", apiResult);
		
		return "member/naverSuccess";
	}
	
}
