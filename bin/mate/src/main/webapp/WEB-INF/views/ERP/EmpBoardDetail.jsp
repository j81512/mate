<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<!-- 호근 헤더 처리-->
<title></title>
<script>
$(document).ready(function(){
    replyList(); //페이지 로딩시 댓글 목록 출력 
});

	function replyList(){
	    var boardNo = $("#boardNo").val();
	     
	     console.log(boardNo);
	    $.ajax({
	        url : "${ pageContext.request.contextPath}/ERP/empReplyList.do",
	        method: 'get',
	        dataType: 'json',
	        contentType: "application/json; charset=utf-8;",
	        data :  {"boardNo" :boardNo},
	        success : function(data){
	            var html =''; 
	         /*    console.log(data); */
	            $.each(data, function(key, value){                
		            	html += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
		            	html += "<div class='replyInfo'>" + "작성자 :" + value.empName;
		            	html += '<a onclick="replyUpdate('+ value.boardReplyNo +',\''+value.content+'\');" class="btn btn-primary"> 수정 </a>';
		            	html += '<a onclick="replyDelete('+ value.boardReplyNo +');" class="btn btn-default"> 삭제 </a> </div>';
		            	html += '<div class="replyContent'+ value.boardReplyNo+'"> <p> 내용 : '+value.content +'</p>';
		            	html += '</div></div>';
	            });
	          		
	            $(".replyList").html(html);
	        }
	    });
	}


	function replyInfo(replyNo, content){

		var reply = {
					replyNo : replyNo,
					content : content	
				}
		
		$.ajax({

		});
	}

</script>
<jsp:include page="/WEB-INF/views/common/headerE.jsp" />

	<div id="board-container" class="mx-auto text-center">
		<input type="text" class="form-control" 
			   placeholder="번호" name="boardNo" id="boardNo" 
			   value="${empBoard.boardNo }" required>
		<input type="text" class="form-control" 
			   placeholder="카테고리" name="category" id="category" 
			   value="${empBoard.category }" required>
		<input type="text" class="form-control" 
			   placeholder="제목" name="title" id="title" 
			   value="${empBoard.title }" required>
		<input type="text" class="form-control" 
			   name="memberId" 
			   value="${ empBoard.empId }" readonly required>
		
	    <textarea class="form-control" name="content" 
	    		  placeholder="내용" required>
	    		  ${ empBoard.content != null  ? empBoard.content : '내용'}
	    		  </textarea>
		</div>
		
		<div id="reply-container">
			<form action="${ pageContext.request.contextPath }/ERP/empReplyEnroll.do" method="POST">
				<input type="text" name="empId" value="${ loginEmp.empId != null ? '왜널인데?' : 'loginEmp.empId'}" />
				<input type="hidden" name="boardNo" value="${ empBoard.boardNo }" />
				<textarea name="content" cols="30" rows="10">
				
				</textarea>
				<input type="submit" value="등록하기" />
			</form>
		</div>
		
		<!-- 댓글 목록-->
	<div class="container">
        <div class="replyList"></div>
    </div>


		
<jsp:include page="/WEB-INF/views/common/footerE.jsp" />