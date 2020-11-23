<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String color = request.getParameter("color");
String font = request.getParameter("font");
if(color==null || color.length()==0) color="black";
if(font==null || font.length()==0) font="Verdana";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RequestUse.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style type="text/css">
	span{
	font-size:2em;
	color:<%=color%>;
	font-family:<%=font%>;

}
	
</style>





</head>
<body>
	<h2>요청헤더명으로 브라우저 종류 알아내기</h2>
<%
	String webBrowser = request.getHeader("user-agent");
	if(webBrowser.toUpperCase().contains("MSIE")){
		out.println("인터넷익스플로러");
	}
	else if(webBrowser.toUpperCase().contains("FIREFOX")){
		out.println("파이어폭스");
	}
	else if(webBrowser.toUpperCase().contains("CHROME")){
		out.println("크롬");
	}
	else{
		out.println("기타브라우져");
	}













%>
	<h2>Request객체와 Scripting Element 응용하기</h2>
	
	<h3>HTML안에서 스크립팅 요소 사용하기</h3>
	<% for(int i=1 ; i<=6 ; i++){ %>
		<h<%=i %>>제목<%=i  %>입니다.</h<%=i %>>
	<% } %>
	
	<h3>숫자를 입력후 버튼을 눌러주세요</h3>
	<form>
		<input type="text" name="counter" />
		<input type="submit" value="이미지카운터" />
	</form>
	
</body>
</html>