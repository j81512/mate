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
	$("[name=product_main_image1]").on("change", function(){
			var file = $(this).prop('files')[0];
			var $label = $(this).next(".custom-file-label");

			if(file == undefined){
				$label.html("파일을 선택하세요");		
			}else{
				$label.html(file.name);
			}
				
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
<form>
  <div class="form-group row">
    <label for="productName" class="col-sm-2 col-form-label">상품명</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="productName">
    </div>
  </div>
  <fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">카테고리</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input" type="radio" name="categories" id="category1" value="category1" checked>
          <label class="form-check-label" for="category1">피규어</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="radio" name="categories" id="category2" value="category2">
          <label class="form-check-label" for="category2">프라모델</label>
        </div>
        <div class="form-check disabled">
          <input class="form-check-input" type="radio" name="categories" id="category3" value="category3" >
          <label class="form-check-label" for="category3">RC카</label>
        </div>
        <div class="form-check disabled">
          <input class="form-check-input" type="radio" name="categories" id="category4" value="category4" >
          <label class="form-check-label" for="category4">드론</label>
        </div>
      </div>
    </div>
  </fieldset>
  
  <div class="custom-file">
    <label for="custom-file-label">파일을 선택하세요</label>
    <input type="file" class="custom-file-input" id="product_main_image1" name="product_main_image1">
  </div>
  <div class="form-group">
    <label for="product_main_image1">섬네일 사진 2</label>
    <input type="file" class="form-control-file" id="product_main_image2">
  </div>
  <div class="form-group">
    <label for="product_main_image1">섬네일 사진 3</label>
    <input type="file" class="form-control-file" id="product_main_image3">
  </div>
  
  <div class="form-group">
   <textarea name="content"></textarea>
  </div>
  <div class="form-group row">
    <div class="col-sm-10">
      <button type="submit" class="btn btn-primary">등록</button>
    </div>
  </div>
</form>
</div>
</body>
</html>