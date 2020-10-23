<%@page import="com.kh.mate.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% Member loginMember = (Member)session.getAttribute("loginMember"); %>
<jsp:include page="/WEB-INF/views/common/headerS.jsp">
	<jsp:param value="고객센터" name="csTitle"/>
</jsp:include>

<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no]{
	cursor: pointer;
}
</style>


	<form id="csMyListFrm" 
    	  action="${pageContext.request.contextPath}/cs/cs.do" 
    	  class="form-inline" 
    	  method="get"> 
    <input type="checkbox" id="csMyListFrm" type="submit" />
    <label for="csMyListFrm"><span>내글만보기</span></label>
    </form>
		<form id="csDeleteFrm" 
	  	  action="${ pageContext.request.contextPath }/cs/deleteCs.do" 
	  	  method="POST">
	<input type="hidden" name="csNo" />
	</form>
	
	
	
<section id="cs-container" class="container">
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goInsertCs();"/>


	<table id="tbl-cs" class="table table-striped table-hover">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>첨부파일</th>	
	</tr>
	 <c:forEach items="${ list }" var="cs">
	<tr data-no="${ cs.csNo }">
		<td>${ cs.csNo }</td>
		<td>${ cs.title }</td>
		<td>${ cs.memberId }</td>
		<td><fmt:formatDate value="${ cs.regDate }" pattern="yy/MM/dd HH:mm:ss"/></td>
		<td>
			<c:if test="${ ! empty cs.csImage }">
				<img src="${ pageContext.request.contextPath }/resources/images/file.png" style="width : 16px;"/>
			</c:if> 
		</td>
		<td>
		<button type="button" class="btn btn-outline-secondary" onclick="updateDev(${ dev.no });">수정</button>
		</td>
	</tr>
	</c:forEach>
	</table>


	
</section> 

	
  	

<script>
function goInsertCs(){
	location.href = "${pageContext.request.contextPath}/cs/insertCs.do";
}
function deleteCs(csNo){
	if(confirm("정말 삭제하시겠습니까?") == false)
		return;
	var $frm = $("#csDeleteFrm");
	$frm.find("[name=csNo]").val(csNo);
	$frm.submit();
}
$(function(){
	$("tr[data-no]").click(function(){
		var csNo = $(this).attr("data-no");
		location.href = "${ pageContext.request.contextPath }/cs/csDetail.do?csNo=" + csNo;
	});
});

</script>