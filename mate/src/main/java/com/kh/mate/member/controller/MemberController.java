package com.kh.mate.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.mate.common.Paging;
import com.kh.mate.erp.model.service.ErpService;
import com.kh.mate.erp.model.vo.EmpBoard;
import com.kh.mate.kakao.KakaoRESTAPI;
import com.kh.mate.member.model.service.MemberService;
import com.kh.mate.member.model.vo.Address;
import com.kh.mate.member.model.vo.Member;
import com.kh.mate.naver.NaverLoginBO;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Slf4j
@Controller
@SessionAttributes({"loginMember"})
public class MemberController {

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private MemberService memberService;
	
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
		
		
		mav.setViewName("member/login");
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
		map.put("memberPWD", (String) responseOBJ.get("id"));
		map.put("memberName", (String) responseOBJ.get("name"));
		map.put("gender", (String) responseOBJ.get("gender"));
		map.put("memberId", (String) responseOBJ.get("email"));
		
		Member member = memberService.selectOneMember((String)responseOBJ.get("email"));
		
		log.debug("테스트 = {}", (String)responseOBJ.get("gender"));
		log.debug("member = {}", member);
		if( member == null || member.getMemberId() == null) {
			
			log.debug("naverMap = {}", map);
			model.addAttribute("snsMember", map);
			return "member/login";
		}else {
			
			log.debug("map = {}", map);
			session.setAttribute("loginMember", member);
//			model.addAttribute("loginMember", member);
			return "redirect:/";
			
		}
	


	}

	/*
	 *호근 카카오 로그인 및 회원가입
	 */
	@RequestMapping(value = "/kakaocallback.do", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String KakaoInfo(Model model, @RequestParam("code") String code, HttpServletRequest request,
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
		Member member = memberService.selectOneMember(kakaoAccount.path("email").asText());
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", kakaoAccount.path("email").asText());
		map.put("memberPWD", userInfo.path("id").asText());
		map.put("memberName", properties.path("nickname").asText());
		map.put("gender", (String)kakaoAccount.path("gender").asText() != "male"  ? "M" : "F");
			
//		log.debug("member = {}", member);
//		// 값 확인
//		log.debug("properties = {}", properties);
		log.debug("kakao_account = {}", kakaoAccount);
		log.debug("map = {}", map);
		log.debug("테스트 = {}", (String)kakaoAccount.path("gender").toString());
		
		if( member == null || member.getMemberId() == null) {
			
			log.debug("kakaoMap = {}", map);
			model.addAttribute("snsMember", map);
			return "member/login";
		}else {
			
			log.debug("map = {}", map);
			session.setAttribute("loginMember", member);
			return "redirect:/";
			
		}	
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
		  
		 
		return "member/login";
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
	
	@ResponseBody
	@GetMapping("/member/pCheck.do/{num}")
	public ModelAndView pCheck(ModelAndView mav, @PathVariable("num")String num) {
		
		log.debug("num = {}", num);
		
		mav.addObject("num", num);
		mav.setViewName("member/phoneCheckNum");
		return mav;
	}
	
	@PostMapping("/member/loginCheck.do")
	public String memberLogin(@RequestParam("memberId") String userId
			  ,@RequestParam("memberPWD") String password
			  ,RedirectAttributes redirectAttr
			  ,Model model
			  ,HttpSession session) {
		log.debug("userId = {}", userId);
		log.debug("password ={}", password);

		Member loginMember = memberService.selectOneMember(userId);
		
		log.debug("loginMember = {}", loginMember);
		String location = "/";
		
		if(	loginMember != null && (loginMember.getMemberPWD().equals(password))
				&& (loginMember.getMemberId().equals(userId))) {
			model.addAttribute("loginMember", loginMember);
			String next = (String)session.getAttribute("next");
			if( next != null) 
				location = next;
		
		}
		else {
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
			log.debug("location = " + location);
		}
		return "redirect:" + location;
	}
	
	@RequestMapping("/member/logout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
			
		}
		return "redirect:/";
	}
	
	@ResponseBody
	@GetMapping("/member/myPage.do")
	public ModelAndView myPage(@ModelAttribute("loginMember") Member loginMember,ModelAndView mav) {
		
		log.debug("loginMember = {}", loginMember);
		
		List<Map<String, Object>> mapList = memberService.selectAllPurchase(loginMember.getMemberId());
		
		mav.addObject("loginMember", loginMember);
		mav.addObject("mapList", mapList);
		mav.setViewName("member/myPage");
		return mav;
	}
	
	@PostMapping("/member/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		Map<String, Object> map = new HashMap<>();
		try {
			
			int result = memberService.insertMember(member);
			map.put("msg", "회원 가입 축하드립니다~!");
			redirectAttr.addFlashAttribute("msg", map);

		}catch(Exception e) {
			log.error("error = {}", e);
			map.put("msg", "회원 가입에 실패하셨습니다.");
			redirectAttr.addFlashAttribute("msg", map);
		}
		return "redirect:/member/memberLogin.do";
		
	}
	
	@PostMapping("/member/memberUpdate.do")
	public String memberUpdate(Member member,RedirectAttributes redirectAttr) {
		
			log.debug("member = {}", member);
			try {
				
				Map<String, Object> map = new HashMap<>();
				map.put("memberId", member.getMemberId());
				map.put("memberPWD", member.getMemberPWD());
				map.put("memberName", member.getMemberName());
				map.put("gender", member.getGender());
				map.put("phone", member.getPhone());
		
				int result = memberService.updateMember(map);
				log.debug("result = {}", result);
				log.debug("map = {}", map);
				String msg = "정보 변경에 성공하였습니다.";
				redirectAttr.addFlashAttribute("msg", msg);
			
				
			}catch(Exception e) {
				log.error("error = {}", e);
				String msg = "정보 변경에 실패하였습니다.";
				redirectAttr.addFlashAttribute("msg", msg);
			}
			
			return "redirect:/member/myPage.do";
		
	}
	
	@PostMapping("/member/memberDelete.do")
	public String memberDelete(@RequestBody Member member,RedirectAttributes redirectAttr
								,SessionStatus sessionStatus) {
		
		log.debug("member = {}", member);
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("memberId", member.getMemberId());
			map.put("memberPWD", member.getMemberPWD());
			
			int result = memberService.deleteMember(map);
			log.debug("result = {}", result);
			log.debug("map = {}", map);
			String msg = "아이디가 삭제 되었습니다";
		
			if(!sessionStatus.isComplete())
			sessionStatus.setComplete();
		
		}catch(Exception e) {
			String msg = "아이디가 삭제 되지 않았습니다.";
			redirectAttr.addFlashAttribute("msg", msg);
			log.error("error = {}", e);
		}
		return "redirect:/";
		
	}
	
	@RequestMapping("/member/checkPasswordDuplicate.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam("memberId") String memberId, @RequestParam("memberPWD") String memberPWD){
		Map<String, Object> map = new HashMap<>();
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("member = {}", member);
		
		boolean isAvailable = member.getMemberPWD().equals(memberPWD) == true;
		log.debug("isVailable ={}", isAvailable);
		map.put("memeberId" , memberId);
		map.put("isAvailable", isAvailable);
				
		return map;
	}
	

	//종완
	@RequestMapping("/member/kakaopay.do")
	public String kakaoPay(@RequestParam("memberId") String memberId,
						   @RequestParam("sum") String sum,
						   @RequestParam("purchaseNo") int purchaseNo,
						   Model model) {
		log.debug("memberId,sum = {}, {}, {}",memberId, sum);
		log.debug("purchaseNo = {}", purchaseNo);
		
		Member member = memberService.selectOneMember(memberId);
		log.debug("member = {}", member);
		
		model.addAttribute("member", member);
		model.addAttribute("sum", sum);
		model.addAttribute("purchaseNo", purchaseNo);
		
		return "product/kakaoPay";
	}
	
	@RequestMapping("/member/paySuccess.do")
	public String paySuccess(@RequestParam("purchaseNo") int purchaseNo,
			                 RedirectAttributes rAttr){
		
		int result = memberService.successPurchase(purchaseNo);
		
		return "redirect:/member/myPage.do";
	}
	
	@RequestMapping("/member/payFail.do")
	public String payFail(@RequestParam("purchaseNo") int purchaseNo,
						  @RequestParam("memberId") String memberId,
            			  RedirectAttributes rAttr){
		
		int result = memberService.failPurchase(purchaseNo);
		
		rAttr.addFlashAttribute("msg", "결제실패하였습니다. 다시 결제해주세요.");
		
		return "redirect:/product/selectCart.do?memberId=" + memberId;
	}
	
	//준혁
	@ResponseBody
	@RequestMapping("/member/selectMemberAddress.do")
	public List<Address> selectMemberAddress(@RequestParam("memberId") String memberId){
		
		List<Address> list = memberService.selectMemberAddress(memberId);
		log.debug("list@Controller = {}", list);
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/member/checkAddressName.do")
	public Map<String, Object> checkAddressName(@RequestParam("addressName") String addressName,
												@RequestParam("memberId") String memberId){
		
		Map<String, Object> param = new HashMap<>();
		param.put("addressName", addressName);
		param.put("memberId", memberId);
		int cnt = memberService.checkAddressName(param);
		
		if(cnt > 0) {
			param.put("isAvailable", false);
		}
		else {
			param.put("isAvailable", true);
		}
		return param;
	}
	
	@ResponseBody
	@PostMapping("/member/addressEnroll.do")
	public Boolean addressEnroll(@RequestParam("memberId") String memberId,
								@RequestParam("addressName") String addressName,
								@RequestParam("receiverName") String receiverName,
								@RequestParam("receiverPhone") String receiverPhone,
								@RequestParam("addr1") String addr1,
								@RequestParam("addr2") String addr2,
								@RequestParam("addr3") String addr3){
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("addressName", addressName);
		param.put("receiverName", receiverName);
		param.put("receiverPhone", receiverPhone);
		param.put("addr1", addr1);
		param.put("addr2", addr2);
		param.put("addr3", addr3);
		
		int result = memberService.insertAddress(param);
		
		return result > 0 ? true : false;
	}
	
	//호근 어드민용 멤버리스트 추가
	@GetMapping("/Member/MemberList.do")
	public String AdminMemberList(Model model, HttpServletRequest request, HttpServletResponse response
								,@RequestParam(required=false) String searchType, @RequestParam(required=false) String searchKeyword) {
		
		
		int numPerPage = 10;
		int cPage = 1;
		try {
			
			cPage = Integer.parseInt(request.getParameter("cPage"));
		}catch(NumberFormatException e) {
			
		}
		
		Map<String, String> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		
//		log.debug("map = {}", map);
		List<Member> memberList = memberService.searchMember(searchType,searchKeyword,cPage, numPerPage);
		int totalContents = memberService.getSearchContents(map);
	
		String url = request.getRequestURI();
		String pageBar = Paging.getPageBarHtml(cPage, numPerPage, totalContents, url);
		
		log.debug("member = {}", memberList);
		model.addAttribute("memberList", memberList);
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchKeyword",searchKeyword);
		model.addAttribute("pageBar", pageBar);
		
		return "member/AdminMemberPage";
	}
}
