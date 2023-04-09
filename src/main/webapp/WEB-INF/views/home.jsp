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
		// 계산기 클래스
		class PerformanceCalculator {
			constructor(aPerformance, aPlay) {
				this.performance = aPerformance;
				this.play = aPlay;
			}
			
			get amount() { // amountFor() 함수의 코드를 계산기 클래스로 복사
				throw new Error('서브클래스에서 처리하도록 설계 되었습니다');
			}
			
			get volumeCredits() {
				return Math.max(this.performance.audience - 30,0);
			}
		}
		
		function createPerformanceCalculator (aPerformance, aPlay){
			console.log(aPlay);
			switch(aPlay.type) {
				case "tragedy" : return new TragedyCalculator(aPerformance, aPlay); 
				case "comedy"  : return new ComedyCalculator(aPerformance, aPlay); 
				default :
					throw new Error("알수 없는 장르 : " + aPlay.type);
			}
		}
		
		class TragedyCalculator extends PerformanceCalculator{
			get amount() {
				let result = 0;
				result += Math.max(this.performance.audience - 30, 0);
				if("comedy" === this.play.type) 
					result += Math.floor(this.performance.audience / 5);
				return result;
			}
		}
		
		class ComedyCalculator extends PerformanceCalculator{
			get amount() { // amountFor() 함수의 코드를 계산기 클래스로 복사
				let result = 30000;
				console.log("여기 안지나가나");
				if( this.performance.audience > 20 ){
					result += 10000 + 500 * (this.performance.audience - 20);
				}
				result += 300 * this.performance.audience;					   
				return result;
			}
			
			get volumeCredits() {
				return super.volumeCredits + Math.max(this.performance.audience - 30,0);
			}
		}
		
		
		
		statement(invoices, plays);
		
		function statement(invoices, plays) {
			let result =  renderPlainText(createStatementData(invoices, plays));
			console.log(result);
		}
		
	
		// 중간 데이터 생성 기능
		function createStatementData(invoices, plays) { // 중간데이터 생성을 전담
			const statmentDate         = {};
			statmentDate.customer    = invoices.customer;
			statmentDate.perfomances = invoices.perfomances.map(enrichPerformance);
			statmentDate.totalAmount = totalAmount(statmentDate);
			statmentDate.totalVolumeCredits = totalVolumeCredits(statmentDate);
			return statmentDate;
			
			function enrichPerformance(aPerformance) {
				const calculator = new createPerformanceCalculator(aPerformance, playFor(aPerformance)); // 생성자 대신 팩터리 함수 이용
				const result = Object.assign({}, aPerformance);
			
				result.play = calculator.play; // 중간 데이터에 연극 정보를 저장
				result.amount = calculator.amount; // 중간 데이터에 amountFor 저장
				result.volumeCredits = calculator.volumeCredits;
				console.log(result);
				return result;
			}
			
			function playFor(aPerformance){ // renderPlainText() 의 중첩함수 였던 playFor()를 statment로 옮김
				return plays[aPerformance.playID];
			}
			
			// 장르에 따라 적립포인트 값을 계산하는 기능
			function amountFor(aPerformance){ // 값이 바뀌지 않는 변수는 매개변수로 전달 //perf를 -> aPerformance로 명확한이름변경
				return new PerformanceCalculator(aPerformance, playFor(aPerformance)).amount;
			}
			
			// 토탈 값 함수
			function totalVolumeCredits(data) {
				return data.perfomances
							.reduce((total, p ) => total + p.volumeCredits, 0);
			}
			
			function volumeCreditsFor(aPerformance) {
				return new PerformanceCalculator(aPerformance, playFor(aPerformance)).volumeCredits;
			}
			
			function totalAmount(data) {
				return data.perfomances
				.reduce((total, p) => total + p.amount,0);
			}
		}
		
		function renderPlainText(data, plays) {
			let result = "청구 내역(고객명 : "+data.customer+")";
			for(let perf of data.perfomances){
				
				// 청구 내역을 출력한다.
				result += " "+perf.play.name + " : " + usd(perf.amount) + "(" + perf.audience + "석)\n";
			}
			
			result += "총액 : " + usd(data.totalAmount);
			result += "적립 포인트 : " + data.totalVolumeCredits + "점\n";
			return result;
		}
		
		function htmlStatment(invoices, plays){
			return renderHtml(createStatmentData(invoices))
		}
		
		function renderHtml(data) {
			let result = "<h1>청구 내역 ( 고객명 : " + data.customer + "</h1>)\n";
			result += "<table>\n";
			result += "<tr><th>연극</th><th>좌석 수</th><th>금액</th></tr>";
			for(let perf of data.performances){
				result += "<tr><td>" + perf.play.name + "</td><td>" + perf.audience + "</td>";
				result += "<td>" + usd(perf.amount) + "</td></tr>\n";
			}
			result += "</table>\n";
			result += "<p>총액 : <em>" + usd(data.totalAmount) + "</em></p>\n"
			return result;
		}
		
		function usd(aNumber) { // 포맷 함수생성 
			return new Intl.NumberFormat("en-US",
					{style:"currency",currency:"USD"
					,minimumFrationDigits:2}).format(aNumber/100);
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
