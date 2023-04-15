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
		// 8.8 반복문을 파이프라인으로 바꾸기
		// 내회사의 지점 사무실 정보를 CSV 형태로 정리한것이다.
		
		const data = `office, country, telephone
					  Chicago, USA, +1 312 373 1000
					  Beijing, China, +86 4008 900 505
					  Bangalore, India, +91 80 4064 9570
					  Proto Alergre, Brazil, +55 51 3079 3550
					  Chennai, India, +91 44 660 44766`
		
		// 다음 함수는 인도에 자리한 사무실을 찾아서 도시명과 전화번호를 반환한다.
		function acquireData(input) {
			const lines = input.split("\n");
			let firstLine = true;
			const result = [];
			for (const line of lines) {
				
				if (firstLine) {
					firstLine = false;
					continue;
				}
				if(line.trim() === "") continue;
				const record = line.split(",");
				if( record[1].trim() === "India" ){
					result.push({city: record[0].trim(), phone: record[2].trim()});
				}
			}
			
		/* 	$.each(result, function(index, value) {
				console.log(result[index]);
			}); */
		}
		
		acquireData(data);
		
		
});

</script>
</head>
<body>
</body> 
</html>
