<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--%@ page session="false" %>-->
<html>
<head>
	<title>Home</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>
.democlass {
	color : red;
}
</style>
<script>
$(document).ready(function(){
		// 버튼을 클릭해서 css 변경
		let btnValue = document.getElementById('btn');
		btnValue.addEventListener('click', function() {
			let color = document.getElementById('demo').style.color;
			if(color === 'red') document.getElementById('demo').style.color = 'black';
			else document.getElementById('demo').style.color = 'red'
		});
		
		// 버튼을 클릭해서 요소 보이기, 숨김기능 
		let btnDisplay = document.getElementById('btnDisplay');
		btnDisplay.addEventListener('click', function () {
			
			let displayChk = document.getElementById('demo').style.display;
			if(displayChk ===  null || displayChk === '') document.getElementById('demo').style.display = 'none';
			else document.getElementById('demo').style.display = '';
				
		});
		
		// 버튼 클릭시 Text 변경
		let btnChangeValue = document.getElementById('btnChangeValue');
		btnChangeValue.addEventListener('click', function () {
			document.getElementById('demo').innerHTML = '텍스트 변경';
		});
		
		// div생성후 body에 append
		const parent = document.createElement('div');
		document.body.prepend(parent);
		parent.prepend('append 예시');
		
		let result = "날씨가 화창합니다.";
			result += "이런날씨 없죠";
		parent.prepend(result);
		
		// html 요소 찾기
		// document.getElementById : id값에 명시된 값을 찾기 
		// documetn.getElementsByTagName : name으로 명시된 요소 찾기
		// document.getElementsByclassName : class 이름에 의한 요소 찾기
		
		let pTagName = document.getElementsByTagName("p");
		document.getElementById("demo1").innerHTML = "2번째 p 태그 Text 변경 " + pTagName[2].innerHTML;
		
		// getElementsByclassName 으로 class가 pClass인 요소를 접근
		let classTest = document.getElementsByClassName("pClass");
		document.getElementById("classNameTest").innerHTML = "pclass 테스트" + classTest[1].innerHTML;
		
		// 자바 스크립트는 Object colloection을 form[], anchors[], layers[], images[]가 있다.
		// 이들은 문서내에 여러개가 존재하면 마치 배열처럼 각 객체에 접근한다.
		// id하나의 form collection에 접근해 내부 각 요소는 elements[index]에 의해 접근한다.
		
		let formBtn = document.getElementById("collectionBtn");
		formBtn.addEventListener('click',	function () {
			let x = document.getElementById("frm1");
			let text = '';
			for(let z = 0; z < x.length; z++){
				text += x.elements[z].value +"<br>";
			}
			document.getElementById("demo3").innerHTML = text;
		});
		
		// element.innerHTML = new html  : content HTML 요소의 내용을 변경한다.
		// element.attribute = new value : HTML 요소의 속성 값을 변경한다.
		// element.setAttribute = HTML 요소의 속성 값을 변경한다.
		// element.style.property = HTML 요소의 스타일을 변경한다.
		
		let attributeChange = document.getElementById("changeAttribute");
		attributeChange.addEventListener('click', function () {
			document.getElementsByTagName("h1")[0].setAttribute("class","democlass");
		});
		
		// document.createElement(element) : HTML 요소 생성
		// document.removeChild(element)   : HTML 요소 제거
		// document.appendChild(element)   : HTML 요소 추가
		// document.replaceChild(element)  : HTML 요소 대치
		// document.write                  : HTML 출력 스트림에 쓰기
		
		let newElementBtn = document.getElementById("newElement");
		newElementBtn.addEventListener('click', function () {
			let btn = document.createElement("button");
			let t = document.createTextNode("CLICK ME");
			btn.appendChild(t);
			document.body.appendChild(btn);
		});
		
		// removeChild 예제
		let removeBtn = document.getElementById("removeChild");
		removeBtn.addEventListener('click', function () {
			let item = document.getElementById("myLI");
			item.parentNode.removeChild(item);
		});
		
		// appendChild 예제
		// 요소를 지정된 요소의 마지막 하위 노드로 추가한다.	
		let appendChildBtn = document.getElementById("appendChildBtn");
		appendChildBtn.addEventListener("click", function () {
			let node = document.createElement("li");
			let textNode = document.createTextNode("Water");
			node.appendChild(textNode);
			document.getElementById("myList").appendChild(node);
		});
		
		// replaceChild 예제
		let replaceChildBtn = document.getElementById("replaceChildBtn");
		replaceChildBtn.addEventListener("click",function () {
			let textnode = document.createTextNode("Water");
			let item = document.getElementById("myList2").childNodes[0];
			item.replaceChild(textnode, item.childNodes[0]);
		});
		
		// HTML 객체 찾기 
		// HTML 문서가 웹브라우저에 로드되면 문서 객체가 된다. document객체는 HTML 문서의 루트 노드이며
		// 다른 모든 노드의 "소유자" 이다. document 객체는 Javascript 내에서 모든 노드 객체에 엑세스 하기 위한 속성 및 메소드를 제공한다.
		// document.anchors : name 속성을 가진 모든 <a> 요소를 반환한다.
		// document.applets : 모든 <applet> 요소를 반환한다.
		// document.baseURL : document의 문서의 절대 기본 URL을 반환한다.
		// document.body : <body> 요소를 반환한다.
		// document.cookie : document의 쿠키를 반환한다.
		// document.doctype : document의 doctype 을 반환한다.
		// document.documentElement : <html> 요소를 반환한다.
		// document.documentMode : 브라우저에 사용된 모든 모드를 반환한다.
		// document.documentURL : document의 URL을 반환한다.
		// document.domain : document 서버의 도메인 이름을 반환한다.
		// document.embeds : 모든 <embed> 요소를 반환한다.
		// document.forms : 모든 <form>요소를 반환
});

</script>
</head>
<body>
	<p id="demo" class="pClass">Javascript can shange the HTML style</p>
	<p id="demo1" class="pClass"></p>
`	<p>Hello World!</p>
	<p id="classNameTest"></p>
	<button id="btn" >클릭</button>
	<button id="btnDisplay" > 보이기 기능 클릭</button>
	<button id="btnChangeValue"> Text 변경</button>
	
	<form id ="frm1">
		First name : <input type="text" name="fname" value="Donald"><br>
		Last name : <input type="text" name="lname" value="Duck"><br><br>
		<input type="submit" value="Submit">
	</form>
	<button id="collectionBtn">From 버튼</button>
	<p id="demo3"></p>	
	<br><br><br>
	<h1>속성값 변경 예 제 입니다</h1>
	<h1>Hello world</h1>
	<p id="myH1"> Good javascript...!</p>
	<button id="changeAttribute">Try it</button>
	<br><br>
	<h1>HTML 요소 추가/ 삭제하기</h1>
	<p>Create New Button element with text.</p>
	
	<button id="newElement">element Try it..</button>
	<h1>Remove Child</h1>
	<ul><li>Coffee</li><li id="myLI">Tea</li><li>Milk</li></ul>
	<p>remove the li element with id="myLI" from the list</p>
	<button id="removeChild">remove Try it</button>
	
	<h1>append Child</h1>
	<ul id="myList"><li>Coffee</li><li>Tea</li><li>Milk</li></ul>
	<p>Append an item to the end of the list.</p>
	<button id="appendChildBtn">append Try it</button>
	<br>
	<h1>replace Child</h1>
	<ul id="myList2"><li>Coffee</li><li>Tea</li><li>Milk</li></ul>
	<p>Append an item to the end of the list.</p>
	<button id="replaceChildBtn">replace child Try it</button>
	
	
</body>
</html>
