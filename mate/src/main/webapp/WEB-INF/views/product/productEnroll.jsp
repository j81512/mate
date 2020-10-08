<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품추가</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${ pageContext.request.contextPath }/resources/ckeditor/ckeditor.js"></script>
<script>
$(function(){
	CKEDITOR.replace('ckeditor');
});
</script>
</head>
<body>
<textarea name="ckeditor" id="ckeditor"></textarea>
</body>
</html>