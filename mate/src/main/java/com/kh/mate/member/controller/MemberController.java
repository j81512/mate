package com.kh.mate.member.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.member.model.service.MemberService;
import com.kh.mate.member.model.vo.Member;




@Controller
@SessionAttributes({"loginMember"})
public class MemberController {

	private static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/memberEnroll.do",
					method = RequestMethod.GET)
	public ModelAndView memberEnroll(ModelAndView mav) {
		mav.addObject("name", "홍길동");
		mav.setViewName("member/memberEnroll");
		return mav;
	}
		
	@RequestMapping(value = "/memberEnroll.do",
					method = RequestMethod.POST)
	public String memberEnroll(RedirectAttributes redirectAttr, 
						   Member member) {
	
	String rawPassword = member.getPassword();
	String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
	member.setPassword(encodedPassword);
	
	log.debug("member = " + member);
	
	int result = memberService.insertMember(member);
	String msg = result > 0 ? "회원 가입 성공!" : "회원 가입 실패!";
	redirectAttr.addFlashAttribute("msg", msg);
	
	return "redirect:/";
	}
	
	
	@RequestMapping(value = "/memberLogin.do", 
					method = RequestMethod.GET)
	public String memberLogin() {
		return "member/memberLogin";
	}
		
	@RequestMapping(value = "/memberLogin.do", 
					method = RequestMethod.POST)
	public String memberLogin(@RequestParam("memberId") String memberId,
			 				  @RequestParam("password") String password,
			 				  Model model,
			 				  HttpSession session,
			 				  RedirectAttributes redirectAttr) {
		log.debug("memberId = " + memberId);
		log.debug(bcryptPasswordEncoder.encode(password));
		
		Member loginMember = memberService.selectOneMember(memberId); 
		log.debug("loginMember = " + loginMember);
		
		String location = "/";

		if(
			loginMember != null &&
			bcryptPasswordEncoder.matches(password, loginMember.getPassword())
		) {
			model.addAttribute("loginMember", loginMember);

			String next = (String)session.getAttribute("next");
			if(next != null)
				location = next;			
		}
		else {
			redirectAttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
		}
		
		return "redirect:" + location;
		}
	
}
