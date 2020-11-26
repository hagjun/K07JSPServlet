<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
pageContext.setAttribute("pageVar", "페이지영역이다");
request.setAttribute("requestVar", "리퀘스트영역이다");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForwardAction.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>액션태그를 이용한 포워딩</h2>
	<%
	/*
	1.sendRedirect()로 페이지 이동
	-새로운 페이지에 대한 요청이므로 page, request영역 모두
	공유되지 않는다.
	-웹브라우저의 Url표시줄에는 마지막으로 요청된 페이지명이
	보여진다.
	-절대 경로로 지정할 경우 컨택스트 루트명을 포함한 경로로 지정해야한다.
	*/
	response.sendRedirect(request.getContextPath()+
			"/07ActionTag/ForwardActionResult.jsp");
	/*request.getRequestDispatcher("/07ActionTag/ForwardActionResult.jsp")
		.forward(request,response);*/
	%>
	<!-- <jsp:forward
		page="/07ActionTag/ForwardActionResult.jsp" /> -->
</body>
</html>