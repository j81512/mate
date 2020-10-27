
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<!DOCTYPE html>
<html lang="ko">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<style>
 	div#search-member_id {display:inline-block;}
    div#search-member_name{display:none;} 
    div#search-gender{display:none;}
</style>
<title>회원관리</title>
<script>
$(function(){
	$("tr[data-no]").click(function(){
		var memberId = $(this).attr("data-no");
		console.log(memberId);
		location.href = "${ pageContext.request.contextPath }/Member/AdminMemberDelete.do?no=" + memberId;
	});

	$("#searchType").change(function(){
		console.log($(this).val());
		
		var type = $(this).val();
		console.log(type);
		$(".search-type").hide().filter("#search-"+type).css("display","inline-block");
		
		
	});
   		
});
</script>
<jsp:include page="/WEB-INF/views/common/headerE.jsp" />
<div class="container">
	<div id="board-container" class="mx-auto text-center">
	<!-- 게시글 검색 -->
	<div class="form-group row justify-content-center">
			<div class="w100" style="padding-right:10px">
				<select class="form-control form-control-sm" name="searchType" id="searchType">
					<option value="member_id">아이디</option>
					<option value="member_name">이름</option>
					<option value="gender">성별</option>
				</select>
			</div>
		  <div id="search-member_id" class="search-type">
	            <form action="${ pageContext.request.contextPath}/Member/MemberList.do" method="get">
	                <input type="hidden" name="searchType" value="member_id"/>
	                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." value="${ searchType eq 'title' ? searchKeyword : ''}" />
	                <button type="submit"  class="btn btn-sm btn-primary">검색</button>			
	            </form>	
	        </div>
	        <div id="search-member_name" class="search-type">
	            <form action="${ pageContext.request.contextPath}/Member/MemberList.do" method="get">
	                <input type="hidden" name="searchType" value="member_name"/>
	                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요." value="${ searchType eq 'content' ? searchKeyword : ''}"/>
	                <button type="submit"  class="btn btn-sm btn-primary">검색</button>			
	            </form>	
	        </div>
			<div id="search-gender" class="search-type">
            <form action="${ pageContext.request.contextPath}/Member/MemberList.do" method="get">      
                <input type="hidden" name="searchType" value="gender" />
                <input type="radio"  name="searchKeyword" value="M" ${ searchKeyword eq 'M' ? "checked" : ""}> 남자 
                <input type="radio"  name="searchKeyword" value="F" ${ searchKeyword eq 'F' ? "checked" : ""}> 여자 
                <button type="submit" class="btn btn-sm btn-primary">검색</button>
            </form>
        </div>
	
	<table id="tbl-board" class="table table-striped table-hover">
         <tr>
        	<th>회원 아이디</th>
			<th>회원 이름</th>
			<th>성별</th>
			<th>핸드폰 번호</th> 
			<th>가입일</th>
		</tr>
		<c:if test="${ not empty memberList }">
		<c:forEach items="${ memberList }" var="member">
		<tr data-no="${ member.memberId }">
			<td>${ member.memberId }</td>
			<td>${ member.memberName }</td>
			<td>${ member.gender eq 'M' ? '남자' : '여자' }</td>
			<td>${ member.phone }</td>
			<td><fmt:formatDate value="${ member.enrollDate }" pattern="yyyy-MM-dd"/></td>
		</tr>
		</c:forEach>
		</c:if>
	</table>
	<!-- 페이징 바 -->
		<nav aria-label="..." style="text-align: center;">
		<div class="pageBar">
			<ul class="pagination">
			<c:if test="${not empty pageBar }">
			<c:forEach items="${ pageBar }" var="p">
				<li>
					  	${ p }
					</li>
				</c:forEach>
				</c:if>
				</ul>
			</div>
			</nav>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footerE.jsp" />
