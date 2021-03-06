<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//한글 깨짐 방지
request.setCharacterEncoding("UTF-8");
//post방식으로 전송되는 폼값을 받아 변수에 저장
String color = request.getParameter("color");
String font = request.getParameter("font");
//최조 접속했을 때, 디폴트 값으로 사용할 값 설정
if (color == null || color.length()==0) color = "black";
if (font == null || font.length()==0) font = "Verdana";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestUse.jsp</title>
<style type = "text/css">
	/* StyleSheet내에 표현식이나 스트립트릿을 사용할 수 있다. */
	span {
		font-size:2em;
		color:<%=color%>;
		font-family:<%=font%>;
	}
</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<h2>Request 객체와 Scripting Element 응용하기</h2>
	<!-- for문을 통해 hn태그를  -->
	<h3>HTML안에서 스크립팅 요소 사용하기</h3>
	<% for (int i = 1 ; i <= 6 ; i ++) {%>
		<h<%=i %>>제목<%=i %>입니다.</h<%=i %>>
	<% } %>
	
	<h3>숫자를 입력 후 버튼을 눌러주세요.</h3>
	<!-- 
		action : 현재 페이지로 설정됨 (입력값이 없는 경우)
		method : get방식으로 설정됨. (입력값이 없는 경우)
			따라서 입력된 폼값은 주소표시줄에서 쿼리스트링으로 확인 가능함.
	 -->
	<form>
		<input type="text" name="counter" />
		<input type="submit" value="이미지카운터" />
	</form>
	
	<%
	String counter = request.getParameter ("counter");
	if (counter != null) {
		/*
		toCharArray() : String을 Char형 배열로 반환해주는 메소드
		*/
		char[] ch = counter.toCharArray();
		for (int i = 0 ; i < ch.length ; i ++) {
	%>
			<img src="../images/num_<%=ch[i] %>.gif"
				alt="<%=ch[i] %> 번 이미지" />
	<%
		}
	}
	%>
	
	<h2>CSS안에서 스크립팅 요소 사용하기</h2>
	<span>CSS를 적용한 텍스트</span>
	<form method="post">
		[글자색]
		<select name="color">
			<option value="red">빨간색</option>
			<option value="blue">파란색</option>
			<option value="green">녹색</option>
		</select>
		[글꼴]
		<select name="font">
			<option value="굴림체">굴림체</option>
			<option value="바탕체">바탕체</option>
			<option value="휴먼옛체">휴먼옛체</option>
		</select>
		<input type="submit" value="폰트&색상변경" />
	</form>
</body>
</html>





















