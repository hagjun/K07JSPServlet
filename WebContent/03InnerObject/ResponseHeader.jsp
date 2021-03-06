<%@page import="java.util.Collection" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
응답헤더 설정하기
	:  새로운 내용을 DB에 추가했는데도 변경도니 내용이 웹 브라우져에
	출력되지 않는다면 이는 캐시에 저장된 내용을 출력하고 있기 때문이다.
	아래설정은 캐시를 사용하지 않고 매번 새로고침 (F5) 한 것 처럼
	새로운 정보로 갱신하겠다는 응답헤더 설정이다.
*/

//HTTP/1.0에서 적용할 때 사용 (현재는 사용하지 않지만 호환성을 위해 남겨둠.)
response.setHeader("Pragma", "no-cache");
//HTTP/1.1에서 적용할 때 사용.
response.setHeader("cache-control", "no-cache");

/*
파일 다운로드 구현 시 사용
	: 웹 브라우져가 인식하지 못하는 MIME 타입으로 설정하면
	웹 브라우저는 파일다운로드창을 통해 파일을 다운로드 시켜버린다.
	jpg와 같은 이미지 파일은 웹 브라우져가 인식하는 MIME타입이므로
	다운로드를 위해서는 아래와 같은 설정이 필요하다.
*/
//response.setContentType("binary/octect-stream");
//	==> 실행 시 주석으로 처리하지 않으면 해당 파일이 다운로드 된다.

/*
응답헤더 추가 / 설정하기
	add 계열 : 기존의 헤더명이 존재 할 경우, 기존의 값을 유지하면서
		계속 추가한다. 없을 때는 새롭게 생성한다.
	set 계열 : 기존 헤더명이 존재 할 경우 기존값이 변경된다.
		없을 때는 새롭게 생성한다.
*/
long time = new Date().getTime();
System.out.println(time);
response.setDateHeader("currentDate", time); //새롭게 추가

SimpleDateFormat simple = new SimpleDateFormat("yyyy-mm-dd HH:mm");
time = simple.parse("2017-12-31 10:30").getTime();
System.out.println(time);
response.addDateHeader("currentDate2", time); //새롭게 추가

response.addIntHeader("numberOfCrew", 100); //새로운 헤더 추가
response.setIntHeader("numberOfCrew", 99); //기존 헤더 덮어쓰기 (수정) -> 99만 출력
%>
<!DOCTYPE html>
<html>
<title>ResponseHeader.jsp</title>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>응답헤더 정보 출력하기</h2>
	<%
	/*
	getHeaderNames() : 응답헤더의 이름을 얻어온다. 반환타입은
			Collection 형이다.
	*/
	Collection<String> headerNames = response.getHeaderNames();
	
	//foreach문을 통해 얻어온 응답헤더를 전체 출력한다.
	for (String headerName : headerNames) {
		String headerValue = response.getHeader(headerName);
	%>
		<li><%=headerName %> : <%=headerValue %></li>
	<%
	}	
	%>
	
	<h2>응답헤더명 존재여부 확인하기</h2>
	<h3>currentDate 응답헤더명</h3>
	<%=response.containsHeader("currentDate") ?
			"존재함" : "존재하지 않음" %>
	<h3>Content-type 응답헤더명</h3>
	<%=response.containsHeader("Content-type") ?
			"존재함" : "존재하지 않음"%>
</body>
</html>


















