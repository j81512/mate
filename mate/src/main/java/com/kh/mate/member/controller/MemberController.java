package com.kh.mate.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.mate.kakao.KakaoRESTAPI;
import com.kh.mate.naver.NaverLoginBO;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.Coolsms;

@Slf4j
@Controller
public class MemberController {

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

//	구글 관련 추가
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;

	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	public void setGoogleConnectionFactory(GoogleConnectionFactory googleConnectionFactory) {
		this.googleConnectionFactory = googleConnectionFactory;
	}

	public void setGoogleOAuth2Parameters(OAuth2Parameters googleOAuth2Parameters) {
		this.googleOAuth2Parameters = googleOAuth2Parameters;
	}

	/*
	 * 
	  *로그인 연동시 한방에 처리할 수 있게 함
	 */
	// 일반 회원 login
	@RequestMapping(value = "/member/memberLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView memberLogin(ModelAndView mav, HttpSession session) {
		// 호근 초기 로그인 화면 수정함
//		log.debug("login 호출 확인");
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
//		log.debug("naverAuthUrl = {}", naverAuthUrl);
		mav.setViewName("member/login");
		mav.addObject("url", naverAuthUrl);
		// 카카오 값 받아오기
		String kakaoUrl = KakaoRESTAPI.getAuthorizationUrl(session);
		mav.addObject("kakaoUrl", kakaoUrl);
//		log.debug("kakaoUrl = {}", kakaoUrl);

		// 구글 관련 코드
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String googleurl = oauthOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		log.debug("oauthOperations = {}", oauthOperations);
		log.debug("googleurl = {}", googleurl);
		mav.addObject("googleUrl", googleurl);

		return mav;
	}

	// naverLogin 성공시
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException, java.text.ParseException {
		log.debug("callback 호출 확인");

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAcessToken(session, code, state);
		log.debug("oauthToken = {}", oauthToken);

		apiResult = naverLoginBO.getUserProfile(oauthToken);

		// 네이버에서 불러온값 형변환 해야함
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		JSONObject responseOBJ = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
//		String nickname = (String)responseOBJ.get("name");

		// 자동 회원가입 되게 하기.
		Map<String, Object> map = new HashMap<>();
		map.put("id", (String) responseOBJ.get("id"));
		map.put("name", (String) responseOBJ.get("name"));
		map.put("gender", (String) responseOBJ.get("gender"));
		map.put("email", (String) responseOBJ.get("email"));
		// 날짜 형변환이 안됨
		// map.put("birthday", sdf1.format(date));

		log.debug("map = {}", map);

//		log.debug("nickname= {}", nickname);
		// 값확인용
//		log.debug("responseOBJ= {}", responseOBJ);
		// 로그인 사용자 정보 읽어 오는것
//		log.debug("apiResult = {}", apiResult);

		model.addAttribute("NaverMember", map);

		return "member/memberEnroll";

	}

	/*
	 *호근 카카오 로그인 및 회원가입
	 */
	@RequestMapping(value = "/kakaocallback.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public ModelAndView KakaoInfo(ModelAndView mav, @RequestParam("code") String code, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		JsonNode node = KakaoRESTAPI.getAccessToken(code);
		log.debug("node = {}", node);
		// accessToken이 사용자의 로그인한 모든 정보가 들어있음
		JsonNode accessToken = node.get("access_token");
		// 사용자 정보
		JsonNode userInfo = KakaoRESTAPI.getKakaoUserInfo(accessToken);
		// 확인 하기
		log.debug("userInfo = {}", userInfo);
		// 유저 정보 카카오에 가져오기 Get properties
		JsonNode properties = userInfo.path("properties");
		JsonNode kakaoAccount = userInfo.path("kakao_account");
		// 자동회원가입
		Map<String, Object> map = new HashMap<>();
		map.put("kemail", kakaoAccount.path("email").asText());
		map.put("kname", kakaoAccount.path("nickname").asText());
		map.put("kid", kakaoAccount.path("id").asText());
		map.put("kgender", kakaoAccount.path("gender").asText());

		// 값 확인
		log.debug("properties = {}", properties);
		log.debug("kakao_account = {}", kakaoAccount);
		log.debug("map = {}", map);

		mav.setViewName("member/memberEnroll");

		return mav;
	}

	//해결해본다
	// 구글 로그인 정보값
	@RequestMapping(value = "/googlecallback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code) {

		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
				null);
		log.debug("oauthOperations= ", oauthOperations);
		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();
		
		  if(expireTime != null && expireTime < System.currentTimeMillis()) {
			  accessToken = accessGrant.getRefreshToken();
			  log.debug(" refresh accessToken = {}", accessToken); 
		  }
		  
		  log.debug("accessGrant= ", accessGrant);
		log.debug("accessToken= ", accessToken);
		  
		 
		return "member/memberEnroll";
	}
	
	@ResponseBody
	@PostMapping("/member/phoneSend.do")
	public String PhoneSend(@RequestParam("receiver") String phone) {
		log.debug("phone = {}", phone);
		String apiKey = "NCSZXRWYBWEC2I0X";
		String apiSecret = "RHGHGCDLP8OWCBRQYCFEJPWORMDXAMO3";
		Message coolsms = new Message(apiKey,apiSecret);
		
		HashMap<String, String> map = new HashMap<>();
		Random rnd = new Random();
		String checkNum = "";
		
		for(int i = 0 ; i < 6 ; i++) {
			
			String ran = Integer.toString(rnd.nextInt(10));
				checkNum += ran;
		
		}
		
		map.put("type", "SMS");
		map.put("to", phone);
//		map.put("from", "01026596065");
		map.put("text", "본인확인"
						+"인증번호(" + checkNum+ ")입력시 정상처리 됩니다.");	
		
		log.debug("map = {}", map);
		try {
			JSONObject obj = (JSONObject) coolsms.send(map);
		} catch (CoolsmsException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return checkNum;
	}
}
