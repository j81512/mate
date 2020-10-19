package com.kh.mate.cs.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.mate.cs.model.service.CsReplyServiceImpl;
import com.kh.mate.cs.model.vo.CsReply;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/reply/*")
@Slf4j
public class CsReplyController {

	@Autowired
	private CsReplyServiceImpl csReplyService;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@RequestMapping("insert.do")
	public void insert(@ModelAttribute CsReply vo, HttpSession session) {
		String memberId = (String) session.getAttribute("memberId");
		vo.setMemberId(memberId);
		csReplyService.ReplyInsert(vo);
	}
}
