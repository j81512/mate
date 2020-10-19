﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>
<div id="enroll-container" class="mx-auto text-center">
	<form id="infoFrm"
		  name = "infoFrm" 
		  method="post">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="empId-container">
						<input type="text" 
							   class="form-control" 
							   name="empId" 
							   id="empId_"
							   value="${ emp.empId }"
							   readonly="readonly">
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="hidden" class="form-control" name="adminPCK" id="adminPCK_"  value="${ loginMember.memberPWD}" required>
					<input type="password" class="form-control" name="password_" id="password_">
					<span class="guide ok" style="color:blue;">비밀 번호가 일치 합니다.</span> 
					<span class="guide error" style="color:red;">비밀 번호가 일치하지 않습니다.</span>
					<input type="hidden" id="idValid" value="0"/> 
				</td>
			</tr>
			<tr>
				<th>지점/업체 선택</th>
				<td>	
					<input type="radio" name="status" id="status" value="1" ${ emp.status eq "1" ? "checked" : "" }>지점
					<input type="radio" name="status" id="status" value="2" ${ emp.status eq "2" ? "checked" : "" }>제조사				
				</td>
			</tr>  	
			<tr>
				<th>지점/업체명</th>
				<td>	
					<input type="text" class="form-control" name="empName" id="empName" value="${ emp.empName }">
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="empPhone" id="empPhone" value="${ emp.empPhone }" maxlength="11" required>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호" name="empAddr1" id="empAddr1" type="text" value="${ emp.empAddr1 }"readonly="readonly" >
    				<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button> 	
					<input class="form-control" style="top: 5px;" placeholder="도로명 주소" name="empAddr2" id="empAddr2" type="text" value="${ emp.empAddr2 }"readonly="readonly" />
					<input class="form-control" placeholder="상세주소" name="empAddr3" id="empAddr3" value="${ emp.empAddr3 }"type="text"  />
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit" value="수정" id="infoUpdate"></button>
					<button type="submit" value="삭제" id="infoDelete"></button>
					<button type="button" value="취소" ></button>				
				</td>
			</tr>
		</table>
	</form>
</div>

<!-- 주소API -->
<!-- 주소검색용 스크립트 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="/resources/js/addressapi.js"></script>
<script>
function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
          // $("[name=addr1]").val(data.zonecode);
          // $("[name=addr2]").val(fullRoadAddr);
           
           document.getElementById('empAddr1').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('empAddr2').value = fullRoadAddr;
           /* document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
</script>
<script>
	$(function(){
		$("#infoFrm .btn-delete").click(function(){
			var $empId = $("#empId_");
			var $frm = $("#infoFrm");
			var $adminPwd = $frm.find("[name=password_]").val();

			var admin = {
					empId : $empId.val(),
					adminPwd : $adminPwd
				};
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
		$("#infoFrm").submit(function(){
			var $ frm = $("infoFrm");
			var $ 
			})
		})
		
		
	
</script>
