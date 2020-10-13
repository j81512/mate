<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%--한글깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp">
	<jsp:param value="글등록" name="csInsert"/>
</jsp:include>			
	
		<!-- 내용, 작성자(수정불가), 공지 체크박스(관리자만), 첨부파일 -->
	<form id="csFrm" action="<%= request.getContextPath() %>/cs/insertCs" method="get" enctype="multipart/form-data">
		<p>
		<label for="csTitle">제목</label>
		<input type="text" name="title" id="csTitle" />
		</p>
		<p>
		<label for="csTitle">내용</label>
		<input type="text" name="content" id="csContent" />
		</p>
		<p>
		<label for="loginMember">작성자</label>
		<input type="text" name="memberId" id="loginMember" value="${ loginMember.getMemberId }" readonly>
		</p>
		<p>
		<label for="secret">비밀글 설정</label>
		<input type="checkbox" id="secret" name="secret" value="1"/>
		</p>
		<p>
		<label for="secret">공지 여부</label>
		<input type="checkbox" id="notice" name="notice" value="1"/>
		</p>
		<p>
		<label for="csimages" id="cs-file-upload">파일 찾아보기</label>
		<input type="file" name="csimages" id="csimages"/>
		</p>
		<button type="button" onclick="insertCs();" class="list-group-item list-group-item-action">등록하기</button>
	</form>
<script>
function insertCs(){
	$("#csFrm").attr("action","${pageContext.request.contextPath}/cs/insertCs.do")
			   .attr("method", "POST")
			   .submit();
}
</script>
