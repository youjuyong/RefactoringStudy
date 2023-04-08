<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%@ page session="false" %>-->
<html>
<head>
	<title>Home</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
</style>
<script>
	$(document).ready(function(){
		// 다양한 연극을 외주로 받아서 공연하는 극단이 있다. 공연요청ㅇ; 들어오면 연극의 장르와 관객규모를
		// 기초로 비용을 책정한다. 현재 이극단은 두가지 장르로 , 비극(tragedy)와 희극(comedy)만 공연한다.
		// 그리고 공연료와 별개로 표인트(volume credit)를 지급해서 다음번 의뢰시 공연료를 할인 받을수도 있다.
		let plays = {
				hamlet : {
							name : "Hamlet", 
							type : "tragedy"
						  },
				as_like : {
							name : "As You Like It",
							type : "comedy"
						  },
				othello : {
							name : "Othello",
							type : "tragedy"
						  }
		}
		
		let invoices = {
				customer : "BigCo",
				perfomances : [
					{
						playID : "hamlet",
						audience : 55
					},
					{
						playID : "as_like",
						audience : 35
					},
					{
						playID : "othello",
						audience : 40
					}
				]
		}
		statement(invoices, plays);
		
		function statement(invoices, plays) {
			let result =  renderPlainText(invoices ,plays);
			console.log(result);
		}
		
		function renderPlainText(invoices, plays) {
			let result = "청구 내역(고객명 : "+invoices.customer+")";
			for(let perf of invoices.perfomances){
			
				// 청구 내역을 출력한다.
				result += " "+playFor(perf).name + " : " + usd(amountFor(perf)) + "(" + perf.audience + "석)\n";
			}
			
			result += "총액 : " + usd(totalAmount());
			result += "적립 포인트 : " + totalVolumeCredits() + "점\n";
			return result;
		
			function totalAmount() {
				let result = 0;
				
				for(let perf of invoices.perfomances){
					result += amountFor(perf);
				}
				return result;
			}
			
			// 토탈 값 함수
			function totalVolumeCredits() {
				let result = 0; // 변수 선언(초기화)를 반복문 앞으로 이동
				for(let perf of invoices.perfomances){
					result = volumeCreditsFor(perf);
				}
				return result;
			}
			
			function usd(aNumber) { // 포맷 함수생성 
				return new Intl.NumberFormat("en-US",
						{style:"currency",currency:"USD"
						,minimumFrationDigits:2}).format(aNumber/100);
			}
			
			function volumeCreditsFor(perf) {
				let result = 0;
				result += Math.max(perf.audience - 30, 0);
				if("comedy" === playFor(perf).type) 
					result += Math.floor(perf.audience / 5);
				return result;
			}
			
			function amountFor(aPerformance){ // 값이 바뀌지 않는 변수는 매개변수로 전달 //perf를 -> aPerformance로 명확한이름변경
				let result = 0; // 변수를 초기화 하는 코드
				switch (playFor(aPerformance).type){ // <- play를 playFor(호출로 변경)	
				case "tragedy" :				
						result = 40000;    
						if( aPerformance.audience > 30){
							result += 1000 * (aPerformance.audience - 30);
						}
						break;
				case "comedy" :
						result = 30000;
						if( aPerformance.audience > 20 ){
							result += 10000 + 500 * (aPerformance.audience - 20);
						}
						result += 300 * aPerformance.audience;					   
						break;
				
				default:
					throw new Error('알수 없는 장르 :' + playFor(aPerformance));
				}
				return result; // <- 함수 안에서 값이 바뀌는 변수 반환.
			}
			
			function playFor(aPerformance){
				return plays[aPerformance.playID];
			}
		}
		
		
		
		
		
		
	
		
		
		
		
	
	
	
});
	

</script>
</head>
<body>

<button id="elem" value="확인">확인</button>
<div id="div1"></div>
<div id="div2"></div>
<div id="div3"></div>

<a href="customer/jsStudy1">js 공부</a><br>
<a href="customer/jsStudy110">js110P 공부</a>
<a href="customer/jsStudy116">js116P 공부</a>
<a href="customer/jsStudy120">js120P 공부</a>
<a href="customer/jsStudy103">js103P 공부 grep map</a>


<a href="gallery/gallery">갤러리</a><br>
<a href="community/list2">커뮤니티2</a><br>
<%-- <c:if test="${customer != null }">
	${customer.name }님(${customer.email }) 환영합니다.<br>
	<a href = "customer/detail">나의 정보 </a><br>
	<a href = "logout">로그 아웃</a><br>
</c:if>
	${sessionScope.customer.name }님<br>
<c:if test="${customer==null }">
	<a href = "login">로그인</a><br>
	<a href="customer/join?start=1">회원가입</a><br>
</c:if>
</body> --%>
</body>
</html>
