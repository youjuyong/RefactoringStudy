<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%@ page session="false" %>-->
<html>
<head>
	<title>Home</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
$(document).ready(function(){
		
	// 6.8 매개 변수 객체 만들기
	// 온도 측정값 배열에서 정상 작동 범위를 벗어난 것이 있는지 검토 하는 코드를 매개변수들을 클래스로 만들기
	
	const station = {
			name: "ZB1",
			readings: [
				{temp: 47, time: "2016-11-10 09:10"},
				{temp: 53, time: "2016-11-10 09:20"},
				{temp: 58, time: "2016-11-10 09:30"},
				{temp: 53, time: "2016-11-10 09:40"},
				{temp: 51, time: "2016-11-10 09:50"},
			]
	};
	
	let operatingPlan = {
			temperatureFloor : 50,
			temperatureCeiling : 55
	}
	
	function readingsOutsideRange (station, min, max) {
		return station.readings
				.filter(r => r.temp < min || r.temp > max);
	}
	
	let alerts = readingsOutsideRange(station, operatingPlan.temperatureFloor,
										   operatingPlan.temperatureCeiling);
	
	
	$.each(alerts, function(index,value) {
		console.log(alerts[index]);
	});
		
});

</script>
</head>
<body>
</body> 
</html>
