<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp">
	<jsp:param value="게시판상세보기" name="csDetail"/>
</jsp:include>

<style>
div#board-container{width:400px;}
input, button, textarea {margin-bottom:15px;}
button {
	overflow: hidden;
}
/* 부트스트랩 : 파일라벨명 정렬*/
div#board-container label.custom-file-label{text-align:left;}
</style>

<div id="cs-container" class="mx-auto text-center">
	<input type="text" class="form-control" 
		   placeholder="제목" name="csTitle" id="title" 
		   value="${ cs.title }" readonly required>
	<input type="text" class="form-control" 
		   name="memberId" 
		   value="${ cs.memberId }" readonly required>
		   
	<button type="button" 
			class="btn btn-outline-success btn-block"
			onclick="fileDownload(${ cs.csNo });">
		첨부파일 - ${ cs.csImage.originalFilename }
	</button>

    <textarea class="form-control" name="content" 
    		  placeholder="내용" readonly required>${ cs.content }</textarea>
	<input type="datetime-local" class="form-control" name="regDate" 
		   value='<fmt:formatDate value="${ cs.regDate }" pattern="yyyy-MM-dd'T'HH:mm"/>' readonly>
</div>
	<button type="button" class="btn btn-outline-secondary" onclick="updateCs(${ cs.csNo });">수정</button>
    <button type="button" class="btn btn-outline-danger" onclick="deleteCs(${ cs.csNo });">삭제</button>
<form action="${ pageContext.request.contextPath }/cs/deleteCs.do" method="POST" id="deleteFrm">
	<input type="hidden" name="csNo" id="hidden-no"/>
</form>
<div>
	<table id="tbl-cs-reply" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>답변</th>
			<th>작성일</th>
			<th>작성자</th>
		</tr>
		 <c:forEach items="${ list }" var="cr">
	<tr data-no="${ cr.csReplyNo }">
		<td>${ cr.content }</td>
		<td><fmt:formatDate value="${ cr.regDate }" pattern="yy/MM/dd HH:mm:ss"/></td>
		<td>${ cr.memberId }</td>
		<td>
		<button type="button" class="btn btn-outline-secondary" type="submit">등록</button>
		</td>
	</tr>
	</c:forEach>
	
	
	</table>
</div>
<div>
		
			작성자 : <input type="text" name="replyer" id="newReplyWriter" />
	
			내용 : <textarea name="replytext" id="newReplyText" cols="30" rows="3"></textarea>
	
		<button id="btnReplyAdd" class="btn btn-primary">등록</button>
</div>
	
<script>
	function fileDownload(csNo){
		location.href = "${ pageContext.request.contextPath }/cs/fileDownload.do?csNo=" + csNo;
	}
	
	function deleteCs(csNo){
		if(confirm("정말 삭제 하시겠습니까?") == false) return;
		$("#hidden-no").val(csNo);
		$("#deleteFrm").submit();
	}
</script>

