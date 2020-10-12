package com.kh.mate.erp.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.erp.model.service.ErpService;
import com.kh.mate.erp.model.vo.EMP;


@Controller
public class ErpContorller {

	private static Logger log = LoggerFactory.getLogger(ErpContorller.class);
	
	@Autowired
	private ErpService erpService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
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
	
	@RequestMapping("/ERP/EmpManage.do")
	public ModelAndView empManage(ModelAndView mav) {
		
		mav.setViewName("/ERP/EmpManage");
		return mav;
	}
	
	@RequestMapping(value="/ERP/EmpEnroll.do",
					method= RequestMethod.GET)
	public ModelAndView EmpEnroll(ModelAndView mav) {
		
		mav.setViewName("ERP/EmpEnroll");
		return mav;
	}
	
	@RequestMapping(value="/ERP/EmpEnroll.do",
					method= RequestMethod.POST)
	public String EmpEnroll(RedirectAttributes redirectAttr,
							EMP emp) {
		
		String rawPassword = emp.getEmpPassword();
		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
		emp.setEmpPassword(encodedPassword);
		
		log.debug("emp = " + emp);
		
		int result = erpService.insertEmp(emp);
		String msg = result > 0 ? "생성 성공" : "생성 실패";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/";
	}
	
	@RequestMapping("/ERP/checkIdDuplicate.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam("empId") String empId){
		Map<String, Object> map = new HashMap<>();
		
		boolean isAvailable = erpService.selectOneEmp(empId) == null;
		
		map.put("empId", empId);
		map.put("isAvailable", isAvailable);
		
		return map;
	}
}
