<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
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

<jsp:include page="/WEB-INF/views/common/headerE.jsp"/>

<div class="container">
	<div id="buy" class="tab-pane fade active show in">
		<div class="col-md-15">
		    <div class="form-area">
		    	<table id="purchaseLog-table" class="table">
			    	<tr>
			    		<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/empManage.do';">
							  <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>지점/업체 관리
							</button>
			    		</th>
						<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/ProductInfo.do';">
							  <span class="glyphicon glyphicon-gift" aria-hidden="true"></span>상품 관리
							</button>
			    		</th>
			    	
			    	<!-- 로그인된 관리자 상태가 지점일 경우 -->
			    	<c:if test="${loginEmp.status eq 1 }">
				    	<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/ProductReceive.do';">
							  <span class="glyphicon glyphicon-save" aria-hidden="true"></span>입고 관리
							</button>
				    	</th>
			    	</c:if>
			    	<!-- 로그인된 관리자 상태가 제조사일 경우 -->
			    	<c:if test="${loginEmp.status eq 2 }">
				    	<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/ProductRequestList.do';">
							  <span class="glyphicon glyphicon-save" aria-hidden="true"></span>발주 관리
							</button>
				    	</th>
			    	</c:if>
			    	</tr>
			    	<tr>
			    		<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/EmpDetail.do';">
							  <span class="glyphicon glyphicon-stats" aria-hidden="true"></span>현황 조회
							</button>
			    		</th>
				    	<th>
				    	<!-- 호근 게시판 url 수정함 -->
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/EmpBoardList.do';">
							  <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>게시판
							</button>
				    	</th>	
			    		<th>
					    	<button type="button" 
					    			class="btn btn-default btn-lg"
					    			onclick="location.href='${ pageContext.request.contextPath }/ERP/ErpLogout.do';">
							  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>로그아웃
							</button>
			    		</th>
			    	</tr>
			    </table>
    		</div>
		</div>
	</div>
</div> 	
<jsp:include page="/WEB-INF/views/common/footerE.jsp"/>		
  </body>
</html>
