package com.kh.mate.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.mate.member.model.vo.Member;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	private static Logger log = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		if(loginMember == null) {
	
			FlashMap map = new FlashMap();
			map.put("msg", "로그인후 이용할 수 있습니다.");
			FlashMapManager manager = RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(map, request, response);

			String next = request.getRequestURL().toString();
//		    log.debug("next@url= " + next);
			if(request.getQueryString() != null) 
				next += "?" + request.getQueryString();
				log.debug("next@url + queryString= " + next);
				//그리고 이걸 session에 저장해야한다.
				session.setAttribute("next", next);
		
			response.sendRedirect(request.getContextPath() + "/member/memberLogin.do");
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
	
	
	
	
}
