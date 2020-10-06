package com.kh.mate.cs.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.cs.model.service.CsService;
import com.kh.mate.cs.model.vo.Cs;


@Controller
public class CsController {

	@Autowired
	private CsService csService;
	
	@RequestMapping("/cs/cs.do")
	public String cs(Cs cs) {
		System.out.println("cs = " + cs);
		return "cs/csForm";
	}

	@RequestMapping(value = "/cs/insertCs.do", method = RequestMethod.POST)
	public String insertCs(Cs cs, RedirectAttributes redirectAttr) {
		System.out.println("cs = " + cs);
		
		int result = csService.insertCs(cs);
		String msg = (result > 0) ? "글이 성공적으로 등록되었습니다" : "글이 등록되지 않았습니다";
		System.out.println("msg = " + msg);
		
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/cs/cs.do";
	}
	
	@RequestMapping("/cs/csList.do")
	public String csList() {
		List<Cs> list = csService.selectCsList();
		System.out.println("list = " + list);
		return "cs/csList";
	}
	
}
