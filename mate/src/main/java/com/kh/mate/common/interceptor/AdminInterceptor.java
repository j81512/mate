package com.kh.mate.common.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class AdminInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();	
		EMP loginEmp = (EMP)session.getAttribute("loginEmp");
		Member loginMember =(Member)session.getAttribute("loginMember");
		if( !loginEmp.getEmpId().equals("admin") || !loginMember.getMemberId().equals("admin") )  {
			
			FlashMap map = new FlashMap();
			if(loginMember != null) {
				map.put("msg", "관리자만 이용 가능 합니다.");
				FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
				manager.saveOutputFlashMap(map, request, response);
				log.debug("여기호출됨?");
				response.sendRedirect(request.getContextPath() + "/cs/cs.do");
				return false;
			}
			if(loginEmp != null) {
				map.put("msg", "관리자만 이용 가능 합니다.");
				FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
				manager.saveOutputFlashMap(map, request, response);
				
				response.sendRedirect(request.getContextPath() + "/ERP/erpMain.do");
				return false;
			}
			return false;
		}
		
		
		
		
		return super.preHandle(request, response, handler);
	}
	

}
