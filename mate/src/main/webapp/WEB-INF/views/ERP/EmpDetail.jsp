<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

</head>
  <body>

    <div>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/ERP/StockLog.do';">
			  <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>재고
			</button>
    	</li>
    	<!-- 로그인 회원이 지점이 아닐 경우 '발주'메뉴 노출 -->
    	<c:if test="${loginEmp.status ne 1 }">
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/ERP/OrderLog.do';">
			  <span class="glyphicon glyphicon-gift" aria-hidden="true"></span>발주
			</button>
    	</li>
    	</c:if>
    </div>
    <div>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/ERP/PriceLog.do';">
			  <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>매출
			</button>
    	</li>	
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/ERP/ReceiveLog.do';">
			  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>입출고
			</button>
    	</li>	
    </div>
 	
		
  </body>
</html>
