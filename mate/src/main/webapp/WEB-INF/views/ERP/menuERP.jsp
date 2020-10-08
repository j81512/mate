<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">

  </head>
  <body>
    <script 
    	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js">
    </script>   
    <script 
    	src="js/bootstrap.min.js">
    </script>
    
    <div>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/EmpManage.do';">
			  <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>지점/업체 관리
			</button>
    	</li>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/ProductInfo.do';">
			  <span class="glyphicon glyphicon-gift" aria-hidden="true"></span>상품 관리
			</button>
    	</li>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/ProductReceive.do';">
			  <span class="glyphicon glyphicon-save" aria-hidden="true"></span>입고 관리
			</button>
    	</li>
    </div>
    <div>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/EmpDetail.do';">
			  <span class="glyphicon glyphicon-stats" aria-hidden="true"></span>현황 조회
			</button>
    	</li>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/EmpList.do';">
			  <span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>게시판
			</button>
    	</li>	
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/menu/ErpLogout.do';">
			  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>로그아웃
			</button>
    	</li>	
    </div>
   
		
		
  </body>
</html>
