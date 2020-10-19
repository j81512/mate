<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/><%-- 한글 깨짐 방지 --%>
<jsp:include page="/WEB-INF/views/common/headerS.jsp"/>

	<div id="company-div">	
	
			<c:forEach items="${ mapList }" var="company">
				<div class="companyList-div">
					${ company.empName }
					<input type="hidden" name="companyName" value="${ company.empName }" />
					<input type="hidden" name="companyPhone" value="${ company.phone }" />
					<input type="hidden" name="companyAddress" value="${ company.addr2 }" />
					<input type="hidden" name="companyAddressDetail" value="${ company.addr3 }" />
				</div>
			</c:forEach>
		
	</div>
	<div id="map" style="width:500px;height:400px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f16f27e7564ae5efd073c689a6db2a9&libraries=services,clusterer,drawing"></script>
<script>

	$(".companyList-div").click(function(){
		var name = $(this).find("[name=companyName]").val();
		var phone = $(this).find("[name=companyPhone]").val();
		var address = $(this).find("[name=companyAddress]").val();
		var addressDetail = $(this).find("[name=companyAddressDetail]").val();
		
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(0,0),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);

		var geocoder = new kakao.maps.services.Geocoder();

		geocoder.addressSearch(address, function(result, status) {

		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });

		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">' + name + '<hr style="margin: 3px;"/>' + addressDetail + '<br />' + phone + '</div>'
		        });
		        infowindow.open(map, marker);

		        map.setCenter(coords);
		    } 
		});  

	});

</script>

<jsp:include page="/WEB-INF/views/common/footerS.jsp"/>