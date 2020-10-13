package com.kh.mate.cs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.cs.model.service.CsService;
import com.kh.mate.cs.model.vo.Cs;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j //PSA
@RequestMapping("/cs")
public class CsController {

	@Autowired
	private CsService csService;
	
	@RequestMapping("/cs.do")
	public String cs(Model model) {
		log.debug("고객센터 인덱스 페이지 요청");
		List<Cs> list = null;
		try {
			list = csService.selectCsList();
			model.addAttribute("list", list);
		} catch(Exception e) {
			log.error("문의 목록 조회 오류", e);
			throw e;
		}
		log.debug("list = {}", list);
		return "cs/cs";
	}

	@RequestMapping(value = "/insertCs.do", method = RequestMethod.GET)
	public String insertCs() {
			return "cs/insertCs";
	}
	
	@RequestMapping(value = "/insertCs.do", method = RequestMethod.POST)
	public String insertsCs(RedirectAttributes redirectAttr,
							@RequestParam(value = "secret", defaultValue = "0") String secret_,
							@RequestParam("title") String title,
							@RequestParam("content") String content,
							@RequestParam("memberId") String memberId,
							@RequestParam(value = "notice", defaultValue = "0") String notice_){
		
		Cs cs = new Cs();
		cs.setContent(content);
		cs.setTitle(title);
		cs.setMemberId(memberId);
		cs.setSecret(secret_.equals("1") ? 1 : 0);
		cs.setNotice(notice_.equals("1") ? 1 : 0);
		
		int result = csService.insertCs(cs);
		String msg = (result > 0 ) ? "문의글이 등록되었습니다" : "문의글 등록에 실패했습니다";
		redirectAttr.addFlashAttribute("msg", msg);
		return "redirect:/cs/cs.do";
	}
	
	@RequestMapping(value = "/deleteCs.do",
			method = RequestMethod.POST)
	public String deleteCs(@RequestParam("csNo") String csNo_, 
						 RedirectAttributes redirectAttr){
	log.debug("문의글 삭제 번호 = {}", csNo_);
	int csNo = Integer.parseInt(csNo_);
	try {
		int result = csService.deleteCs(csNo);
		String msg = (result > 0) ? "문의글 등록에 성공했습니다" : "문의글 삭제에 실패했습니다";
		redirectAttr.addFlashAttribute("msg", msg);
	} catch(Exception e) {
		log.error("문의글 삭제 오류", e);
		throw e;
	}
	return "redirect:/cs/cs.do";
	}

}
