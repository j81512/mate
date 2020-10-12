<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>

	<!-- 휴대폰 인증관련 modal -->
<form id="register-form"
					action="${pageContext.request.contextPath}/member/memberEnroll.do "
					method="post" role="form" style="display: none;">
					<h3 class="heading-desc">핸드폰인증</h3>
					<div class="form-group">
						<input type="text" name="id" id="id" tabindex="1"
							class="form-control" placeholder="아이디를 입력해 주세요" value="">
					</div>
					<div class="form-group">
						<div class="row">
							<div class="col-sm-6 col-sm-offset-3">
								<button class="btn btn-lg btn-block purple-bg" type="submit">
									인증하기</button>
							</div>
						</div>
					</div>
			 
<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>