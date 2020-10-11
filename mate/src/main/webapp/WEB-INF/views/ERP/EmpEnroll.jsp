<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div id="enroll-container" class="mx-auto text-center">
	<form id="empEnrollFrm" 
		  action="EmpEnroll.do" 
		  method="post">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="empId-container">
						<input type="text" 
							   class="form-control" 
							   placeholder="4글자이상"
							   name="empId" 
							   id="empId_"
							   required>
						<span class="guide ok">이 아이디는 사용가능합니다.</span>
						<span class="guide error">이 아이디는 사용할 수 없습니다.</span>
						<!-- 0:사용불가, 1:사용가능 -->
						<input type="hidden" id="idValid" value="0" />
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password_" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="password2" required>
				</td>
			</tr>  
			<tr>
				<th>지점/업체명</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" required>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" class="form-control" placeholder="" name="address" id="address">
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
	</form>
</div>
<script>
	$.ajax({
		url : "${ pageContext.request.contextPath }/ERP/checkIdDuplicate.do",
		data : {
			memberId : $this.val()
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
			}
			else{
				$ok.hide();
				$error.show();
				$idValid.val(0);
			}
			
		},
		error : function(xhr, status, err){
			console.log("처리실패!");
			console.log(xhr);
			console.log(status);
			console.log(err);
		}
	});

});

$("#password2").blur(function(){
	var $p1 = $("#password_"), $p2 = $("#password2");
	if(p1.val() != p2.val()){
		alert("패스워드가 일치하지 않습니다.");
		$p1.focus();
	}
});
	
$("#empEnrollFrm").submit(function(){

	var $empId = $("#empId_");
	if(/^\w{4,}$/.test($empId.val()) == false) {
		alert("아이디는 최소 4자리이상이어야 합니다.");
		$empId.focus();
		return false;
	}

	var $idValid = $("#idValid");
	if($idValid.val() == 0){
		alert("사용가능한 아이디를 입력하세요.");
		$empId.select();
		return false;
	}
	
	
	return true;
});
</script>

