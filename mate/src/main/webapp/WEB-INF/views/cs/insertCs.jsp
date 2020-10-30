<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%--한글깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp">
	<jsp:param value="문의글 등록" name="csInsert"/>
</jsp:include>			
<style>
div#cs-container{width:400px; margin:0 auto; text-align:center;}
div#cs-container input{margin-bottom:15px;}
/* 부트스트랩 : 파일라벨명 정렬*/
div#cs-container label.custom-file-label{text-align:left;}
</style>	

<script>
function insertCs(){
	$("#csFrm").attr("action","${pageContext.request.contextPath}/cs/insertCs.do")
			   .attr("method", "POST")
			   .submit();
}
function csValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(function(){
	//파일 선택/취소 파일라벨명을 변경
	$("[name=upFile]").on("change", function(){
		var file = $(this).prop('files')[0];
		var $label = $(this).next(".custom-file-label");

		if(file == undefined) $label.html("파일을 선택하세요.");
		else $label.html(file.name);
	});
});
function goBackWithDel(){

	history.go(-1);
	
}
</script>

<div id="cs-container">	
	<form name="csFrm" action="${pageContext.request.contextPath}/cs/insertCs.do" method="post" enctype="multipart/form-data" onsubmit="return csValidate();">

		<input type="text" class="form-control" placeholder="제목" name="title" id="title" required>
		<input type="text" class="form-control" name="memberId" value="${loginMember.memberId}" readonly required>
		
		<div class="input-group mb-3" style="padding:0px;">
		<div class="input-group-prepend" style="padding:0px;">
		 <span class="input-group-text">첨부파일1</span>
		</div>
		<div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" >
		    <label class="custom-file-label" for="upFile">파일을 선택하세요</label>
		</div>
		</div>
	    <textarea class="form-control" name="content" placeholder="내용" required></textarea>
		<br />
		<label for="secret">비밀글 설정</label>
		<input type="checkbox" id="secret" name="secret" value="1"/>
		<c:if test="${ loginMember.memberId eq 'admin'}">
		<label for="notice">공지 여부</label>
		<input type="checkbox" id="notice" name="notice" value="1"/>
		</c:if>		
		<input type="submit" class="btn btn-outline-success" value ="등록하기">
		<button type="button" class="btn btn-danger" onclick="goBackWithDel();">취소</button>
	</form>
</div>