<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	CKEDITOR.replace('content',{
				filebrowserUploadUrl : "${ pageContext.request.contextPath }/cke/fileUpload.do"
		});
});

$(function(){
	//파일 선택 | 취소 파일라벨명을 변경한다.
	$("[name=upFile]").on("change", function(){
			var file = $(this).prop('files')[0];
			//console.log("this = " + $(this).val()); //선택된 파일이 this로 넘어옴
			//console.log(file);
			//console.log($(this).prop('files')); // 0:File, length:1 배열로 파일의 정보 넘어옴
			var $label = $(this).next(".custom-file-label");

			if(file == undefined){
				$label.html("파일을 선택하세요");		
			}else{
				$label.html(file.name);
			}
				
		});

	//가격 range이용시
	$("#price").on("change", function(){

		var $price = $(this).val();
		console.log($price);
		var $container = $("#priceValue");

		$container.val($price);

	});

	
});

</script>
<style>
div#form-container{
	width:650px;
	padding:15px;
	border:1px solid lightgray;
	border-radius: 10px;
}
div#form-container label.custom-file-label{text-align:left;}
</style>
</head>
<body>
<div id="form-container" class="mx-auto">
<form action = "${ pageContext.request.contextPath }/product/productEnroll.do"
	  method = "POST"
	  enctype = "multipart/form-data">
  			<!-- 상품명 -->
  <div class="form-group row">
    <label for="productName" class="col-sm-2 col-form-label">상품명</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="productName" name="productName" required>
    </div>
  </div>
 			 <!-- 카테고리 -->
  <fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">카테고리</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category1" value="figure" checked>
          <label class="form-check-label" for="category1">피규어</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category2" value="plamodel">
          <label class="form-check-label" for="category2">프라모델</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category3" value="rccar" >
          <label class="form-check-label" for="category3">RC카</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category4" value="drone" >
          <label class="form-check-label" for="category4">드론</label>
        </div>
      </div>
    </div>
  </fieldset>
 			 <!-- 섬네일 이미지 -->
  <div class="input-group mb-3" style="padding:0px;">
   <div class="input-group-prepend" style="padding:0px;">
     <span class="input-group-text">섬네일 사진 1</span>
   </div>
   <div class="custom-file">
     <input type="file" class="custom-file-input" name="upFile" id="upFile1" >
     <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
   </div>
  </div>
  <div class="input-group mb-3" style="padding:0px;">
   <div class="input-group-prepend" style="padding:0px;">
     <span class="input-group-text">섬네일 사진 2</span>
   </div>
   <div class="custom-file">
     <input type="file" class="custom-file-input" name="upFile" id="upFile1" >
     <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
   </div>
  </div>
  <div class="input-group mb-3" style="padding:0px;">
   <div class="input-group-prepend" style="padding:0px;">
     <span class="input-group-text">섬네일 사진 3</span>
   </div>
   <div class="custom-file">
     <input type="file" class="custom-file-input" name="upFile" id="upFile1" >
     <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
   </div>
  </div>
  			<!-- 내용 -->
  <div class="form-group">
   <textarea name="content"></textarea>
  </div>
  			<!-- 가격 -->
  <div class="form-group">
	<label for="price">가격</label>
	<input type="range" name="price" id="price" class="custom-range" min="0" max="30000000" step="10000"/>
	<input type="text" name="" id="priceValue" value="" required/> 원
  </div>
  
  <!-- 등록자  -->
  <input type="hidden" name="empId" value="testId"/>
  
  <div class="form-group row">
    <div class="col-sm-10">
      <button type="submit" class="btn btn-primary">등록</button>
    </div>
  </div>
</form>
</div>
</body>
</html>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>