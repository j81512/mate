<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품추가</title>
</head>
<body>

	<div>
		<form name="productFrm"
			action="${pageContext.request.contextPath}/product/productEnroll.do"
			method="POST"
			enctype="multipart/form-data">
			
			<label>상품명</label>
			<input type="text" placeholder="상품명" name="productName" id="productName"/>
			<br />
			<label>브랜드</label>
			<select class="brand" name="brand" id="brand">
			  <option selected>브랜드</option>
			  <option value="1">One</option>
			  <option value="2">Two</option>
			  <option value="3">Three</option>
			</select>
			<br />
			<label>카테고리</label>
			<select class="category" name="category" id="category">
			  <option selected>카테고리 선택</option>
			  <option value="PM">프라모델</option>
			  <option value="FG">피규어</option>
			  <option value="RC">rc카</option>
			  <option value="DR">드론</option>
			</select>
			<br />
			<label>가격</label>
			<input type="number" name="price" id="price" />
			<br />
			<label for="content">내용</label>
			<input type="text" name="content" id="content" />
			<br />
			<label class="custom-file-label" for="inputGroupFile01">이미지파일 선택</label>
			<input type="file" class="custom-file-input" id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
			<br />
			
			<input type="submit" value="등록" />
			 
		</form>
	</div>

</body>
</html>