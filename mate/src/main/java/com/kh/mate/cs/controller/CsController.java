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
		return "cs/cs";
	}

	@RequestMapping(value = "/insertCs.do", method = RequestMethod.POST)
	public String insertCs(Cs cs, RedirectAttributes redirectAttr) {
		System.out.println("cs = " + cs);
		
		try {
			int result = csService.insertCs(cs);
			redirectAttr.addFlashAttribute("msg","문의글이 성공적으로 등록되었습니다");
		} catch(Exception e) {
			redirectAttr.addFlashAttribute("msg","문의글 등록에 실패했습니다");
		}
			return "redirect:/cs/cs.do";
	}
	@RequestMapping(value = "/deleteCs.do",
			method = RequestMethod.POST)
	public String deleteCs(@RequestParam String csno, 
						 RedirectAttributes redirectAttr){
	log.debug("문의글 삭제");
	Map<String, String> param = new HashMap<>();
	param.put("csno", csno);

	
	try {
		int result = csService.deleteCs(param);
		String msg = (result > 0) ? "문의글 등록에 성공했습니다" : "문의글 삭제에 실패했습니다";
		redirectAttr.addFlashAttribute("msg", msg);
	} catch(Exception e) {
		log.error("문의글 삭제 오류", e);
		throw e;
	}
	return "redirect:/cs/cs.do";
	}

}
