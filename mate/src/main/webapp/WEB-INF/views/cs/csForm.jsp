<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>
function insertCs(){
	$("#csFrm").attr("action","${pageContext.request.contextPath}/cs/insertCs.do")
			   .attr("method", "POST")	
			   .submit();
}
</script>