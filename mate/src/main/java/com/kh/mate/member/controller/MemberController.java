package com.kh.mate.member.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.mate.naver.NaverLoginBO;

import lombok.extern.slf4j.Slf4j;


import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.mate.naver.NaverLoginBO;


@Slf4j
@Controller
public class MemberController {

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	/**
	 * 
	 * 로그인 연동시 한방에 처리할 수 있게 함
	 */
	//일반 회원 login

	@RequestMapping(value = "/member/memberLogin.do"
			,method = {RequestMethod.GET, RequestMethod.POST})
		public String memberLogin(Model model, HttpSession session) {
		// 호근 초기 로그인 화면 수정함 
		log.debug("login 호출 확인");
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		log.debug("naverAuthUrl = {}", naverAuthUrl);
		model.addAttribute("url", naverAuthUrl);
		return "member/login";
	}
	//naver login 이부분 필요없어서 날림

	//naverLogin 성공시
	@RequestMapping(value = "/callback.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException, java.text.ParseException {
		log.debug("callback 호출 확인");
	
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAcessToken(session, code, state);
		log.debug("oauthToken = {}", oauthToken);
		
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		
		// 네이버에서 불러온값 형변환 해야함
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		JSONObject responseOBJ = (JSONObject)jsonObj.get("response");
		//response의 nickname값 파싱
		String nickname = (String)responseOBJ.get("name");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse((String)responseOBJ.get("birthday"));
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		
		//자동 회원가입 되게 하기.
		Map<String, Object> map = new HashMap<>();
		map.put("id", (String)responseOBJ.get("id"));
		map.put("name", (String)responseOBJ.get("name"));
		map.put("gender", (String)responseOBJ.get("gender"));
		map.put("email", (String)responseOBJ.get("email"));
		//날짜 형변환이 안됨
		//		map.put("birthday", sdf1.format(date));
		
		log.debug("map = {}", map);
	
//		log.debug("nickname= {}", nickname);
		// 값확인용
//		log.debug("responseOBJ= {}", responseOBJ);
		//로그인 사용자 정보 읽어 오는것
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		log.debug("apiResult = {}", apiResult);
		session.setAttribute("naverName", nickname);
		model.addAttribute("loginNaverMember", apiResult);
		
		return "member/login";

	}
	
}
