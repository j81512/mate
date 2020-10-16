<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
	integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4"
	crossorigin="anonymous">
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/loginForm.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
<style>
.form-area
{
    background-color: #FAFAFA;
	padding: 10px 40px 60px;
	margin: 10px 0px 60px;
	border: 1px solid GREY;
}
</style>
<script>
	$(function(){

		$("#memberFrm .btn-update").click(function(){
			var $memberId = $("#memberId_");
			var $frm = $("#memberFrm");
			var member = {
					memberId : $memberId.val(),
					memberPWD : $frm.find("[name=memberPWD]").val(),
					memberName : $frm.find("[name=memberName]").val(),
					gender : $frm.find("[name=gender]:checked").val(),
					phone : $frm.find("[name=phone]").val()
				};
			 
			console.log(member);
			$.ajax({
				url: "${ pageContext.request.contextPath}/member/memberUpdate.do",
				method: "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(member),
				success:function(data){
					console.log(data.msg);
					alert(data.msg);
				},
				error:function(err, status, xhr){

				}					
			});
		});
		
		$("#memberFrm .btn-delete").click(function(){
			var $memberId = $("#memberId_");
			var $frm = $("#memberFrm");
			var member = {
					memberId : $memberId.val(),
					memberPWD : $frm.find("[name=memberPWD]").val(),
				};
			 
			console.log(member);
			$.ajax({
				url: "${ pageContext.request.contextPath}/member/memberDelete.do",
				method: "POST",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(member),
				success:function(data){
					alert(data.msg);
				},
				error:function(err, status, xhr){

				}					
			});
		});
		
	});
</script>
<jsp:include page="/WEB-INF/views/common/headerS.jsp" />

<div>
	<button type="button" class="btn btn-success">구매내역</button>
	<button type="button" class="btn btn-success">내정보수정</button>

</div>
<div class="col-md-15">
    <div class="form-area">  
		<form action="" id="memberFrm">
			<div class="form-group">
			 	<label class="control-label " for="memberId_">아이디:</label>
			 	
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)"name="memberId" id="memberId_" readonly value="${ loginMember.memberId }" required> 
			</div>
			<div class="form-group">
			  	<label class="control-label" for="memberPWD_">비밀번호:</label>
				<input type="password" class="form-control"  name="memberPWD" id="memberPWD_" value="${ loginMember.memberPWD}" required> 
			</div>
			<div class="form-group">
			  	<label class="control-label" for="memberName_">이름:</label>
				<input type="text" class="form-control" placeholder="이름" name="memberName" id="memberName_" value="${ loginMember.memberName}" required> 
			</div>
			<div class="form-group">
			  	<label class="control-label " for="phone_">전화번호:</label>
				<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone"  id="phone_" value="${ loginMember.phone }" id="phone" maxlength="11"required> 
			</div>
			<div class="form-check form-check-inline">
			  <label class="control-label " for="gender">성별:</label>
				<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" ${ loginMember.gender eq  "M" ? "checked" :"" }>
				<label  class="form-check-label" for="gender0">남</label>&nbsp;
				<input type="radio" class="form-check-input" name="gender" id="gender1" value="F" ${ loginMember.gender eq  "F" ? "checked" :"" } >
				<label  class="form-check-label" for="gender1">여</label>
			</div>
			<div class="form-group">
				<button type="button" class="btn btn-success btn-update" id="memberUpdate">정보수정</button>
				<button type="button" class="btn btn-danger btn-delete" id="memberDelete">회원탈퇴</button>
				<button type="button" class="btn btn-warning" onclick="location.href='${pageContext.request.contextPath }'">닫기</button>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footerS.jsp" />