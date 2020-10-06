<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
function csSubmit1(){
	$("#devFrm").attr("action",
	  "${pageContext.request.contextPath}/cs/csSubmit.do").submit();
}
</script>