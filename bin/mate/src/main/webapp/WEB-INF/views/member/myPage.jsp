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
#purchaseLog-table table{
	border: 1px solid black;
	text-align: center;
}
#purchaseLog-table td, #purchaseLog-table th{
	border: 1px solid black;
	padding: 10px;
	text-align: center;
}

.review-modal{
	display:none;
	position:fixed; 
	width:100%; height:100%;
	top:0; left:0; 
	background:rgba(0,0,0,0.3);
	z-index: 1001;
}

.review-modal-section{
	position:fixed;
	top:50%; left:50%;
	transform: translate(-50%,-50%);
	background:white;
	min-width: 50%;
}

.modal-close{
	display:block;
	position:absolute;
	width:30px; height:30px;
	border-radius:50%; 
	border: 3px solid #000;
	text-align:center; 
	line-height: 30px;
	text-decoration:none;
	color:#000; font-size:20px; 
	font-weight: bold;
	right:10px; top:10px;
}

.review-modal-head{
	padding: 3%; 
	background-color : gold;
	border: 1px solid #000;
}
.review-modal-body{
	padding: 3%;
	border: 1px solid #000;
}
.review-modal-footer{
	padding: 1%;
	border: 1px solid #000;
}
[name=score]{
	display: none;
}
.modal-submit{
	position:absolute;
	right: 1%;
}
.modal-cancel{
	position:absolute;
	right: 8%;
}
.score-img{
	height: 20px;
	weith: 20px;
}
.score-img-a{
	display: none;
}
.score-img:hover{
	cursor: pointer;
	background-color: yellow;
}
#review-content{
	resize: none;
}
</style>
<script>
	

	$(function(){

		$(".score-img").click(function(){
			var value = $(this).attr("data-value");
			var $scoreImgs = $(".score-img");

			$scoreImgs.each(function(i, scoreImg){

				if($(scoreImg).attr("data-value") <= value){
					if($(scoreImg).hasClass("score-img-b")) $(scoreImg).fadeOut(0);
					if($(scoreImg).hasClass("score-img-a")) $(scoreImg).fadeIn(0);
				}
				else{
					if($(scoreImg).hasClass("score-img-b")) $(scoreImg).fadeIn(0);
					if($(scoreImg).hasClass("score-img-a")) $(scoreImg).fadeOut(0);
				}
			});
			
			$("#review-score").val(value);
			
		});
		
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

function openReviewModal(no){
	$("#review-modal-"+no).fadeIn(300);
}

function closeReviewModal(no){
	$("#review-modal-"+no).fadeOut(300);
	$("#review-content").val("");
	$(".score-img-b").fadeIn(0);
	$(".score-img-a").fadeOut(0);
	$("#review-score").val("");
}




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
			<table id="purchaseLog-table" class="table">
				<thead class="thead-dark">
					<tr>
						<th scope="col">#</th>
						<th scope="col">주문번호</th>
						<th scope="col">구매날짜</th>
						<th scope="col">상품번호</th>
						<th scope="col">상품명</th>
						<th scope="col">수량</th>
						<th scope="col">상태</th>
						<th scope="col">리뷰</th>
					</tr>
				</thead>
				<c:if test="${ !empty mapList }">
					<tbody>
						<tr>
						<c:forEach items="${ mapList }" var="purchase" varStatus="vs">
							<th scope="row">${ vs.count }</th>
							<td>${ purchase.purchaseNo }</td>
							<td><fmt:formatDate value="${ purchase.purchaseDate }" pattern="yyyy-MM-dd HH:mm"/></td>
							<td>${ purchase.productNo }</td>
							<td>${ purchase.productName }</td>
							<td>${ purchase.amount }</td>
							<td>${ purchase.status == 0 ? "<input type='button' value='환불/교환' /><input type='button' value='구매확정' />" : purchase.status == 1 ? "구매확정" : "환불/교환" }</td>
							<td>
								<c:if test="${ empty purchase.reviewNo }">
									<input class="review-btn" type='button' value='리뷰 작성 하기' onclick="openReviewModal(${ purchase.purchaseLogNo });"/>
								</c:if>
								<c:if test="${ ! empty purchase.reviewNo }">
									리뷰 작성 완료	
								</c:if>
							</td>
							<div class="review-modal" id="review-modal-${ purchase.purchaseLogNo }">
								<div class="review-modal-section">
									<div class="review-modal-head">
										<a href="javascript:closeReviewModal(${ purchase.purchaseLogNo });" class="modal-close">X</a>
										<p class="review-modal-title">제목</p>
									</div>
									<form action="${ pageContext.request.contextPath }/product/insertReview.do">
									<div class="review-modal-body">
										<label for="review-content">내용</label>
										<textarea name="comments" id="review-content" cols="97" rows="10"></textarea>
									</div>
									<div class="review-modal-footer">
										평점
										<img class="score-img-b score-img" src="../resources/images/star1.png" id="score-img-1" alt="" data-value="1" />
										<img class="score-img-a score-img" src="../resources/images/star2.png" id="score-img-1" alt="" data-value="1" />
										<img class="score-img-b score-img" src="../resources/images/star1.png" id="score-img-2" alt="" data-value="2" />
										<img class="score-img-a score-img" src="../resources/images/star2.png" id="score-img-2" alt="" data-value="2" />
										<img class="score-img-b score-img" src="../resources/images/star1.png" id="score-img-3" alt="" data-value="3" />
										<img class="score-img-a score-img" src="../resources/images/star2.png" id="score-img-3" alt="" data-value="3" />
										<img class="score-img-b score-img" src="../resources/images/star1.png" id="score-img-4" alt="" data-value="4" />
										<img class="score-img-a score-img" src="../resources/images/star2.png" id="score-img-4" alt="" data-value="4" />
										<img class="score-img-b score-img" src="../resources/images/star1.png" id="score-img-5" alt="" data-value="5" />
										<img class="score-img-a score-img" src="../resources/images/star2.png" id="score-img-5" alt="" data-value="5" />
										<input type="number" name="score" id="review-score" />
										<input class="modal-cancel modal-btn" type="button" value="취소" onclick="closeReviewModal(${ purchase.purchaseLogNo });"/>
										<input class="modal-submit modal-btn" type="submit" value="등록" />
										<input type="hidden" name="purchaseLogNo" value="${ purchase.purchaseLogNo }" />
									</div>
									</form>
								</div>
							</div>
						</c:forEach>
						</tr>
					</tbody>
				</c:if>
				<c:if test="${ empty mapList }">
					<tr>
						<td colspan="8">구매 내역이 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</table>

		</div>
	</div>
</div>
</div>
<jsp:include page="/WEB-INF/views/common/footerS.jsp" />