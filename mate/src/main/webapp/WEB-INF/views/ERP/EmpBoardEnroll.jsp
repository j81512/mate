<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 호근 헤더 처리-->
<title>emp게시판</title>
<script>
$(function(){
	CKEDITOR.replace("content_",{
		filebrowserUploadUrl : "${ pageContext.request.contextPath }/ERP/empBoardimageFileUpload.do"
	});
});

function revoke(){
	var reCofrim = confirm("정말로 취소하시겠습니까?");
	if(reCofrim)
		history.go(-1);
}

$("#erpBoardFrm").submit(function(){

	return false;
});

</script>
<jsp:include page="/WEB-INF/views/common/headerE.jsp" />


		<form action="${ pageContext.request.contextPath }/ERP/empBoardCkEnroll.do"
			  method="POST"
			  id="erpBoardFrm"
			  enctype="multipart/form-data">
			   <div class="form-group">
			   	<input type="text" name="title"  id="title_" />
			   	<input type="text" name="empId"  id="empId_" value="${loginEmp.empId }" readOnly/>
			   	<input type="text" name="empName"  id="empName" value="${loginEmp.empName}" readOnly/>
			   </div>
			  <div class="form-group">
			  	<textarea name="content" id="content_"></textarea>
			  </div>
				
			 <div class="button-gruop">
			 	<input type="submit"  value="등록하기"/>
			 	<input type="button"  value="취소" onclick="revoke();"/>
			 </div>
		</form>

 <!--호근 푸터 처리  -->
<jsp:include page="/WEB-INF/views/common/footerE.jsp" />