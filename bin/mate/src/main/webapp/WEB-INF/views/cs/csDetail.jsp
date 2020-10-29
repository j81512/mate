<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
<div class="container">	
	<div id="cs-container" class="mx-auto text-center">
		<input type="text" class="form-control" 
			   placeholder="제목" name="csTitle" id="title" 
			   value="${ cs.title }" readonly required>
		<input type="text" class="form-control" 
			   name="memberId" 
			   value="${ cs.memberId }" readonly required>
			 
		<c:if test="${ not empty csImage }">
		<button type="button" 
				class="btn btn-outline-success btn-block"
				onclick="fileDownload(${ cs.csNo });">
			첨부파일 - ${ csImage.originalFilename }
		</button>
		</c:if>	   
	
	    <textarea class="form-control" name="content" 
	    		  placeholder="내용" readonly required>${ cs.content }</textarea>
		<input type="datetime-local" class="form-control" name="regDate" 
			   value='<fmt:formatDate value="${ cs.regDate }" pattern="yyyy-MM-dd'T'HH:mm"/>' readonly>
	</div>
		<c:if test="${ loginMember.memberId eq cs.memberId || loginMember.memberId eq 'admin' }">
		<button type="button" class="btn btn-outline-secondary" onclick="updateCs(${ cs.csNo });">수정</button>
	    <button type="button" class="btn btn-outline-danger" onclick="deleteCs(${ cs.csNo });">삭제</button>
		</c:if>
	<form action="${ pageContext.request.contextPath }/cs/deleteCs.do" method="POST" id="deleteFrm">
		<input type="hidden" name="csNo" id="hidden-no"/>
	</form>
	<div>


</div>
	<div class="replyList-container">
	
	
	</div>
		<div id="reply-container">
			<form action="${ pageContext.request.contextPath }/cs/csReplyEnroll.do" method="POST">
				<div class="form-group">				
					<input type="hidden" name="memberId" value="${ loginMember.memberId != null ? loginMember.memberId : 'ㅋㅋㅋ'}" />
				</div>
				<div class="form-group">
					<input type="hidden" name="csNo" id="csNo" value="${ cs.csNo }" />
				</div>
				<div class="form-group">
					<textarea class="form-control col-sm-10" name="content"  rows="10"></textarea>
				</div>
				<div class="button-group">
					<input type="submit" class="btn btn-primary" value="등록하기" />
				</div>
			</form>
		</div>
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
	$(document).ready(function(){
	    csReplyList(); 
	});	
	function csReplyList(){
	    var csNo = $("#csNo").val();
	    var loginMember = '${loginMember.memberId}';
	     console.log(csNo);
	    $.ajax({
	        url : "${ pageContext.request.contextPath}/cs/csReplyList.do",
	        method: 'get',
	        dataType: 'json',
	        contentType: "application/json; charset=utf-8;",
	        data :  {"csNo" :csNo},
	        success : function(data){
	            var html ='<table id="tbl-cs-reply" class="table table-striped table-hover">'
			        	+'<tr>'
						+'<th>번호</th>'
						+'<th>답변</th>'
						+'<th>작성일</th>'
						+'<th>작성자</th>'
						+'</tr>'; 
	      		 console.log(data);
	      		 var vs = 1;
	      		 
	            $.each(data, function(key, value){   
	            		html +=  '<tr data-no="'+ value.csNo+'" >';         
		       		 	html += '<th>'+ vs++ +'</th>';
		            	html += "<th>" + value.content + "</th>";
		            	html += '<th>'+ moment(value.regDate).format("YYYY-MM-DD")+'</th>';
		            	html += '<th>'+ value.memberName +'</th>'; 
		            	html += '</tr>';
		     
	            });
	            html += '</table>';
	          $(".replyList-container").html(html);  
	        
	        }
	    });
	}

	
	function csReplyDelete(csReplyNo) {
		var csReplyNo = csReplyNo;

		$.ajax({
			url : "${ pageContext.request.contextPath }/cs/csReply.do",
			method : "POST",
			dataType: 'json',
			data : {
				"csReplyNo" : csReplyNo
			},
			success : function(data){
				console.log(data);
				if(data.isAvailable) {
					alert("삭제 되었습니다.");
					location.reload();
				}
			},
			error : function(xhr, status ,err){
				console.log(xhr);
				console.log(status);
				console.log(err);
			}	
		});
	}
</script>

