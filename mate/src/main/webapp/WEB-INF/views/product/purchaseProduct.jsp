<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<c:if test="${ empty recentAddr }">
	<script>
	$(function(){
		var $input = $(".form-control");

		$input.removeAttr("readonly");
	});
	</script>
</c:if>

<!--전체 감쌀 div <div class="container-purchase-form"></div> -->
<form action="">

	<!-- 주소 불러오기 버튼 만들기 -->
	
	
	<div id="container-addr">
		<div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputEmail4">배송지 명</label>
		      <input type="text" class="form-control" id="addressName" name="addressName" value="${ recentAddr != null ? recentAddr.addressName : '' }" readonly>
		    </div>
		    <div class="form-group col-md-6">
		      <label for="inputPassword4">회원 ID</label>
		      <input type="text" class="form-control" id="memberId" value="${ recentAddr != null ? recentAddr.memberId : '' }" readonly>
		    </div>
	    </div>
		<div class="form-row">
		    <div class="form-group col-md-6">
		      <label for="inputEmail4">수취인 성명</label>
		      <input type="text" class="form-control" id="recieverName" value="${ recentAddr != null ? recentAddr.recieverName : ''}" readonly>
		    </div>
		    <div class="form-group col-md-6">
		      <label for="inputPassword4">수취인 연락처</label>
		      <input type="text" class="form-control" id="recieverPhone" value="${ recentAddr != null ? recentAddr.recieverPhone : ''}" readonly>
		    </div>
	    </div>
	    
	    <div class="form-group">
		    <label for="addr1">우편 번호</label>
	    	<input class="form-control" style="width: 40%; display: inline;" 
	    	 	   placeholder="${ recentAddr != null ? recentAddr.addr1 : '우편번호'}" name="addr1" 
	    	 	   id="addr1" type="text" readonly >
			<button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button> 	
		</div>
		<div class="form-group">
		    <label for="addr2">도로명 주소</label>
			<input class="form-control" style="top: 5px;" 
				   placeholder="${ recentAddr != null ? recentAddr.addr2 : '도로명 주소'}" 
				   name="addr2" id="addr2" type="text" readonly />
	    </div>
		<div class="form-group">
		    <label for="addr3">상세 주소</label>
			<input class="form-control" 
				   placeholder="${ recentAddr != null ? recentAddr.addr3 : '상세주소'}" 
				   name="addr3" id="addr3" type="text" readonly />
	    </div>
	</div>
	
	
	<div class="container-product">
	<table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">상품 이미지</th>
	      <th scope="col">상품명</th>
	      <th scope="col">카테고리</th>
	      <th scope="col">가격</th>
	      <th scope="col">수량</th>
	      <th scope="col">가격</th>
	      <th scope="col">삭제</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<tr>
	  		<td>1</td>
	  		<td>상품 이미지 자리</td>
	  		<td>${ purProduct.productName }</td>
	  		<td>${ purProduct.productName }</td>
	  		<td>
	  			<c:if test="${ c.selectedProduct.category eq 'fg' }">
	    		피규어
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'pm' }">
	    		프라모델
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'rc' }">
	    		RC카
	    		</c:if>
	    		<c:if test="${ c.selectedProduct.category eq 'dr' }">
	    		드론
	    		</c:if>
	  		</td>
	  		<td></td>
	  		<td></td>
	  		<td></td>
	  	</tr>
	  </tbody>
	</table>
	</div>


</form>

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
           
           document.getElementById('addr1').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('addr2').value = fullRoadAddr;
           /* document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}
</script>
<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>