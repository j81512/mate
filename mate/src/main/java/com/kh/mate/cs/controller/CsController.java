package com.kh.mate.cs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping("/cs/csSubmit1.do")
	public String devSubmit3(Cs cs) {
		System.out.println("cs = " + cs);
		return "cs/csResult";
	}
	
}
