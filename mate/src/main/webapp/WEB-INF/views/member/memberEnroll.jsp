<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>

	<div id="enroll-container" class="mx-auto text-center">
	<form id="memberEnrollFrm" 
		  action="memberEnroll.do" 
		  method="post">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="4글자이상"
							   name="memberId" 
							   id="memberId_"
							   required>
						<span class="guide ok">이 아이디는 사용가능합니다.</span>
						<span class="guide error">이 아이디는 사용할 수 없습니다.</span>
						<!-- 0:사용불가, 1:사용가능 -->
						<input type="hidden" id="idValid" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password_" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="password2" required>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" required>
				</td>
			</tr> 
			<tr>
				<th>성별 </th>
				<td>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" checked>
						<label  class="form-check-label" for="gender0">남</label>&nbsp;
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F">
						<label  class="form-check-label" for="gender1">여</label>
					</div>
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</div>
			 
<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>