package com.kh.mate.erp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.mate.erp.model.service.ErpService;

@Controller
public class ErpContorller {

	private static Logger log = LoggerFactory.getLogger(ErpContorller.class);
	
	@Autowired
	private ErpService erpService;
	
	@RequestMapping("/ERP/menu.do")
	public ModelAndView Menu(ModelAndView mav) {
		
		mav.setViewName("/ERP/menu");
		return mav;
	}
	
	@RequestMapping("/ERP/erpMain.do")
	public ModelAndView erpMain(ModelAndView mav) {
		
		mav.setViewName("/ERP/erpMain");
		return mav;
	}
	
	@RequestMapping("/ERP/ProductInfo.do")
	public ModelAndView productInfo(ModelAndView mav) {
		
		mav.setViewName("/ERP/ProductInfo");
		return mav;
	}
}
