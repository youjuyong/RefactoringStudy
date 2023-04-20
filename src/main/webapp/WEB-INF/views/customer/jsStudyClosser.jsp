<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%@ page session="false" %>-->
<html>
<head>
	<title>Home</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style type="text/css">
	body {
      font-family: Helvetica, Arial, sans-serif;
      font-size: 12px;
    }

    h1 {
      font-size: 1.5em;
    }

    h2 {
      font-size: 1.2em;
    }
</style>
<script>
$(document).ready(function(){
		
	/* // 클로저는 어떤 데이터(어휘적 환경)과 그 데이터를 조작하는 함수를 연관시켜 주기때문에
	이것은 객체가 어떤 데이터와 하나 혹은 그이상의 메소드들을 연관 시킨다는 점에서 객체
	지향 프로그래밍과 분명 같은 맥락에 있다.
	
	결론적으로 오직 하나의 메소드를 가지고 있는 객체를 일반적으로 사용하는 모든곳에 클로저를
	사용할 수있다. */
	
	
	function makeSizer(size) {
		return function() {
			document.body.style.fontSize = size + "px";
		};
	}
	
	let size12 = makeSizer(12);
	let size14 = makeSizer(14);
	let size16 = makeSizer(16);
	
	
	document.getElementById('size-12').onclick = size12;
	document.getElementById('size-14').onclick = size14;
	document.getElementById('size-16').onclick = size16;
	
	
	/* 자바와 같은 몇몇 언어들은 메소드를 프라이빗으로 선언할 수 있는 기능을 제공한다.
	이는 같은 클래스 내부의 다른 메소드에서만 그 메소드를 호출 할 수 있다는 의미이다.
	
	프라이빗 메소드는 코드에 제한적인 접근만을 허용한다는 점 뿐만 아니라 전역 네임 스페이스를
	관리하는 강력한 방법을 제공하여 불필요한 메소드가 공용 인터페이스를 혼란스럽게 만들지 않도록 한다.
	
	아래코드는 프라이빗 함수와 변수에 접근하는 퍼블릭 함수를 정의 하기 위해 클로저를 사용하는 방법을 보여준다.
	이렇게 클로저를 사용하는것을 모듈 패턴이라고 한다. */
	
	let counter = (function() {
		let privateCounter = 0;
		function changeBy(val){
			privateCounter += val;
		}
		
		return {
			increment: function() {
				changeBy(1);
			},
			decrement: function() {
				changeBy(-1);
			},
			value: function() {
				return privateCounter;
			}
		}
	})();
	
	console.log(counter.value());
	counter.increment();
	counter.increment();
	counter.decrement();
	console.log(counter.value());
	
	/* 공유되는 어휘적 환경은 실행되는 익명 함수 안에서 만들어진다. 이 익명 함수는 정의되는 즉시 실행된다. 
	이 어휘적 환경은 두 개의 프라이빗 아이템을 포함한다. 하나는 privateCounter라는 변수이고 나머지 하나는 changeBy라는 함수이다. 
	둘 다 익명 함수 외부에서 접근될 수 없다. 대신에 익명 래퍼에서 반환된 세 개의 퍼블릭 함수를 통해서만 접근되어야만 한다.

	위의 세 가지 퍼블릭 함수는 같은 환경을 공유하는 클로저다. 자바스크립트의 어휘적 유효 범위 덕분에 세 함수 
	각각 privateCounter 변수와 changeBy 함수에 접근할 수 있다. */
});

</script>
</head>
<body>
	<p> Some Paragraph text</p>
	<h1>some heading 1 text</h1>
	<h2>some heading 2 text</h2>
	
	<a href="#" id="size-12">12</a>
	<a href="#" id="size-14">14</a>
	<a href="#" id="size-16">16</a>
</body> 
</html>
