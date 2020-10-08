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
	    			onclick="location.href='${ pageContext.request.contextPath }/.do';">
			  <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>쇼핑몰
			</button>
    	</li>
    	<li>
	    	<button type="button" 
	    			class="btn btn-default btn-lg"
	    			onclick="location.href='${ pageContext.request.contextPath }/erp/menuERP.do';">
			  <span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>ERP
			</button>
    	</li>
    </div>
     
		
		
  </body>
</html>
