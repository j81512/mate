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

<form action="">

	<!-- 최근 입력 주소 or 새로 주소 입력할 지 선택하는 라디오 버튼 제시  -->
	<div class="form-check form-check-inline">
		<input class="form-check-input" type="radio" name="addrBtn" id="recentAdr" value="0" onchange="displayView();" ${ not empty recentAddr ? 'checked' : '' }/>
		<label class="form-check-label" for="recentAdr">최근 주소 사용</label>
		<input class="form-check-input" type="radio" name="addrBtn" id="newAdr" value="1" onchange="displayView();" ${ not empty recentAddr ? '' : 'checked' }/>
		<label class="form-check-label" for="newAdr">새 주소 입력</label>
    </div>
	
	<div id="container-addr-recent">
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
		    <label for="inputAddress">Address 1</label>
		    <input type="text" class="form-control" id="inputAddress1" placeholder="${ recentAddr != null ? recentAddr.addr1 : ''}" readonly>
		</div>
		<div class="form-group">
		    <label for="inputAddress2">Address 2</label>
		    <input type="text" class="form-control" id="inputAddress2" placeholder="${ recentAddr != null ? recentAddr.addr2 : ''}" readonly>
	    </div>
		<div class="form-group">
		    <label for="inputAddress2">Address 3</label>
		    <input type="text" class="form-control" id="inputAddress3" placeholder="${ recentAddr != null ? recentAddr.addr3 : '' }" readonly>
	    </div>
	</div>


</form>

<script>
function displayView(){

	

}
</script>
<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>