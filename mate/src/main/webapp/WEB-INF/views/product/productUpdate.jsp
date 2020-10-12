<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
<style>
div#form-container{
	width:650px;
	padding:15px;
	border:1px solid lightgray;
	border-radius: 10px;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script>
$(function(){
	CKEDITOR.replace('content',{
				filebrowserUploadUrl : "${ pageContext.request.contextPath }/product/imageFileUpload.do"
		});
});

</script>
</head>
<body>
<div id="form-container" class="mx-auto">
<form action = "${ pageContext.request.contextPath }/product/productUpdate.do"
	  method = "POST"
	  enctype = "multipart/form-data"
	  id="productEUpdateFrm">
  			<!-- 상품명 -->
  <div class="form-group row">
    <label for="productName" class="col-sm-2 col-form-label">상품명</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="productName" name="productName" value="${ product.productName }" required>
    </div>
  </div>
 			 <!-- 카테고리 -->
  <fieldset class="form-group">
    <div class="row">
      <legend class="col-form-label col-sm-2 pt-0">카테고리</legend>
      <div class="col-sm-10">
        <div class="form-check">
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category1" value="fg" ${ product.category eq "fg" ? "checked" : ""  }>
          <label class="form-check-label" for="category1">피규어</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category2" value="pl" ${ product.category eq "pl" ? "checked" : ""  }>
          <label class="form-check-label" for="category2">프라모델</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category3" value="rc" ${ product.category eq "rc" ? "checked" : ""  }>
          <label class="form-check-label" for="category3">RC카</label>
          <input class="form-check-input-col-xs-3" type="radio" name="category" id="category4" value="dr" ${ product.category eq "dr" ? "checked" : ""  }>
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
   <textarea name="content">${ product.content }</textarea>
  </div>
  			<!-- 가격 -->
  <div class="form-group">
	<label for="price">가격</label>
	<input type="range" id="priceRange" class="custom-range" min="0" max="30000000" step="1000"/>
	<input type="text" name="price" id="priceValue" value="${ product.price }" required/> 원
  </div>
  
  <!-- 등록자  -->
  <input type="hidden" name="empId" value="testId"/>
  
  <div class="form-group col">
    <div class="col-sm-10">
      <button type="submit" class="btn btn-primary">등록</button>
    </div>
    <div class="col-sm-10">
      <button type="button" class="btn btn-danger" onclick="return goBackWithDel();">취소</button>
    </div>
  </div>
</form>
</div>
</body>
</html>