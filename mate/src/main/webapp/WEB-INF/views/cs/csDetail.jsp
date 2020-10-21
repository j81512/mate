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
<div id="reply-container">
			<form action="${ pageContext.request.contextPath }/cs/csReplyEnroll.do" method="POST">
				<div class="form-group">				
					<input type="hidden" name="memberId" value="${ loginMember.memberId != null ? loginMember.memberId : 'ㅋㅋㅋ'}" />
				</div>
				<div class="form-group">
					<input type="hidden" name="csNo" value="${ cs.csNo }" />
				</div>
				<div class="form-group">
					<textarea class="form-control col-sm-10" name="content"  rows="10"></textarea>
				</div>
				<div class="button-group">
					<input type="submit" class="btn btn-primary" value="등록하기" />
				</div>
			</form>
		</div>
	<div class="container">
		<div class="row">
	        <div class="csReplyList"></div>
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
	     
	     console.log(csNo);
	    $.ajax({
	        url : "${ pageContext.request.contextPath}/cs/csReplyList.do",
	        method: 'get',
	        dataType: 'json',
	        contentType: "application/json; charset=utf-8;",
	        data :  {"csNo" :csNo},
	        success : function(data){
	            var html =''; 
	         /*    console.log(data); */
	            $.each(data, function(key, value){                
		            	html += '<div class="csReplyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
		            	html += "<div class='csReplyInfo'>" + "작성자 :" + value.memberId;
		            	html += '<a onclick="csReplyDelete('+ value.csReplyNo +');" class="btn btn-default"> 삭제 </a> </div>';
		            	html += '<div class="csReplyContent'+ value.csReplyNo+'"> <p> 내용 : '+value.content +'</p>';
		            	html += '</div></div>';
	            });
	          		
	            $(".csReplyList").html(html);
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

