<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="고객센터" name="csTitle"/>
</jsp:include>

<style>
div#cs-container{width:60%; margin:0 auto;text-align:center;}
</style>

<div id="cs-container">
	<form id="csEnrollFrm" 
    	  action="${pageContext.request.contextPath}/cs/insertCs.do" 
    	  class="form-inline" 
    	  method="get"> 
        <button class="btn btn-outline-success" type="submit" >문의글등록</button>
    </form>
  	<form id="csmyEnrollFrm" 
    	  action="${pageContext.request.contextPath}/cs/cs.do" 
    	  class="form-inline" 
    	  method="get"> 
        <button class="btn btn-outline-success" type="submit" >내글만보기</button>
    </form>
    <form id="csDeleteFrm" 
    	  action="${pageContext.request.contextPath}/cs/deleteCs.do" 
    	  class="form-inline" 
    	  method="post"> 
        <button class="btn btn-outline-danger" type="submit" >게시글삭제</button>
    </form>
<table class="table">
<tr>
	<th scope="col">번호</th>
	<th scope="col">제목</th>
	<th scope="col">작성자</th>
	<th scope="col">작성일</th>
</tr>

 <c:forEach items="${ list }" var="cs">
<tr>
	<td>${ cs.csno }</td>
	<td>${ cs.title }</td>
	<td>${ cs.membeId }</td>
	<td><fmt:formatDate value="${ cs.regDate }" pattern="yy/MM/dd HH:mm:ss"/></td>
	<td>
	   <button 
	      	type="button" 
	      	class="btn btn-outline-danger"
	      	class="form-inline" 
	      	onclick="deleteCs(${ cs.no });">삭제</button>    	
	</td>
</tr>

</c:forEach>
</table>
<form id="csDeleteFrm" 
	  action="${ pageContext.request.contextPath }/cs/deleteCs.do" 
	  method="POST">
	<input type="hidden" name="no" />
</form>
</div>
<script>
function deleteCs(no){
	if(confirm("정말 삭제하시겠습니까?") == false)
		return;
	var $frm = $("#csDeleteFrm");
	$frm.find("[name=no]").val(no);
	$frm.submit();
}
</script>