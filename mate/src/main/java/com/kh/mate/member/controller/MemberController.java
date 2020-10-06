package com.kh.mate.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.member.model.service.MemberService;
import com.kh.mate.member.model.vo.Member;




@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})
public class MemberController {

	private static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping(value = "/memberEnroll.do",
					method = RequestMethod.POST)
	public String memberEnroll(RedirectAttributes redirectAttr, 
						   Member member) {
	
	String rawPassword = member.getPassword();
	String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
	member.setPassword(encodedPassword);
	
	log.debug("member = " + member);
	
	//업무로직
	int result = memberService.insertMember(member);
	String msg = result > 0 ? "회원 가입 성공!" : "회원 가입 실패!";
	redirectAttr.addFlashAttribute("msg", msg);
	
	return "redirect:/";
}
}
