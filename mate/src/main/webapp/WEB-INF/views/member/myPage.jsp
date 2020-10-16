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
		
		$("#memberFrm .btn-delete").click(function(){
			var $memberId = $("#memberId_");
			var $frm = $("#memberFrm");
			var $memberPWD = $frm.find("[name=memberPWD]").val();
			var $memberPCK = $frm.find("[name=memberPCK]").val();
			
			var member = {
					memberId : $memberId.val(),
					memberPWD : $memberPWD
				};
			
			console.log(member);
			 var delConfirm = confirm("정말로 삭제하시겠습니까?");
			if(delConfirm){
				$.ajax({
					url: "${ pageContext.request.contextPath}/member/memberDelete.do",
					method: "POST",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(member),
					success: window.location.href = "${ pageContext.request.contextPath }",
					error:function(err, status, xhr){
						console.log(err);
						console.log(status);
						console.log(xhr);
					}					
				});
			}else{
				alert("취소되었습니다");
				return;
			}
		
		});
		
	});

	$(function(){
		$("#memberFrm").submit(function(){
			var $frm = $("#memberFrm");
			var $memberPWD = $frm.find("[name=memberPWD]");
			var $memberPCK = $frm.find("[name=memberPCK]");
			
		    if($memberPWD.val() != $memberPCK.val() ){
				alert("비밀 번호가 일치 하지 않습니다.");
				$memberPCK.select();
				return false;
			}

			return true;
		});
		
		$(".guide").hide();

		$("#memberPWD_").keyup(function(){
			var $this = $(this);
			var $memberId = $("#memberId_");
			if($this.val().length < 2){
				$(".guide").hide();
				$("#idValid").val(0);
				return;
			}
			$.ajax({
				url : "${ pageContext.request.contextPath}/member/checkPasswordDuplicate.do",
				data : {
					memberId : $memberId.val(),
					memberPWD : $this.val()
				},
				method : "GET",
				dataType : "json",
				success : function(data){
					console.log(data);
					var $ok = $(".guide.ok");
					var $error = $(".guide.error");
					var $idValid = $("#idValid");
					if(data.isAvailable){
						$ok.show();
						$error.hide();
						$idValid.val(1);				
					}else{
						$ok.hide();
						$error.show();
						$idValid.val(0);				
					}
					
				},
				error : function(xhr, status, err){
						console.log(xhr, status, err);
				}
					

			});
		
		});
		
	});



</script>
<jsp:include page="/WEB-INF/views/common/headerS.jsp" />
<!-- 수정  -->
<div class="row">
	<div class="col-sm-6">
	  <ul class="nav nav-pills" >
	    <li class="" style="width:50%"><a class="btn btn-lg btn-default" data-toggle="tab" href="#buy">구매내역</a></li> 
	    <li class=" " style="width:48%"><a class=" btn btn-lg btn-default" data-toggle="tab" href="#menu1">정보수정</a></li>
	  </ul>
	</div>
</div>
<br />
<div class="tab-content">
<div id="menu1" class="tab-pane fade">
	<div class="col-md-15">
	    <div class="form-area">  
			<form action="${ pageContext.request.contextPath}/member/memberUpdate.do" method="post" id="memberFrm">
				<div class="form-group">
				 	<label class="control-label " for="memberId_">아이디:</label>
					<input type="text" class="form-control" placeholder="아이디 (4글자이상)"name="memberId" id="memberId_" readonly value="${ loginMember.memberId }" required> 
				</div>
				<div class="form-group">
				  	<label class="control-label" for="memberPCK">비밀번호:</label>
					<input type="hidden" class="form-control" name="memberPCK" id="memberPCK_"  value="${ loginMember.memberPWD}" required> 
					<input type="password" class="form-control" name="memberPWD" id="memberPWD_"  value="" required> 
					<span class="guide ok" style="color:blue;">비밀 번호가 일치 합니다.</span> 
					<span class="guide error" style="color:red;">비밀 번호가 일치하지 않습니다.</span>
					<input type="hidden" id="idValid" value="0"/> 
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
				<div class="buttons-group">
					<button type="submit" class="btn btn-success btn-update" id="memberUpdate">정보수정</button>
					<button type="submit" class="btn btn-danger btn-delete" id="memberDelete">회원탈퇴</button>
					<button type="button" class="btn btn-warning" onclick="location.href='${pageContext.request.contextPath }'">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- 구매 내역  -->
<div id="buy" class="tab-pane fade">
	<div class="col-md-15">
	    <div class="form-area">  
			<table>
				<tr>
					<th></th>
					<th>날짜</th>
					<th>상품번호</th>
					<th>상품명</th>
					<th>수량</th>
					<th>상태</th>
				</tr>
				<c:if test="${ !empty mapList }">
					<tr>
					<c:forEach items="mapList" var="purchase" varStatus="vs">
						<td>${ vs.count }</td>
						<td>${ purchase.purchaseDate }</td>
						<td>${ purchase.productNo }</td>
						<td>${ purchase.productName }</td>
						<td>${ purchase.amount }</td>
						<td>${ purchase.status == 0 ? "<input type='button' value='환불/교환' /><input type='button' value='구매확정' />" : purchase.status == 1 ? "구매확정<input type='button' value='리뷰쓰기' />" : "환불/교환" }</td>
					</c:forEach>
					</tr>
				</c:if>
				<c:if test="${ empty mapList }">
					<tr>
						<td colspan="7">구매 내역이 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/common/footerS.jsp" />