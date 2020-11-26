<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UseBeanActionForward.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>포워드 된 페이지입니다.</h2>
	
	<h2>자바코드를 통해 영역의 객체얻기</h2>
	<%
	MemberDTO memberJ = (MemberDTO)request.getAttribute("member");
	%>
	<h3>자바코드로 출력하기</h3>
	<ul>
		<li>아이디 : <%=memberJ.getId() %>
		<li>페스워드 : <%=memberJ.getPass() %>
		<li>이름 : <%=memberJ.getName() %>
	</ul>
	<!-- 
	자바코드를 통해 영역에서 객체를 가져온 경우에는 액션태그에서
	사용할수 없다. 반드시 액션태그를 통해 읽어온 객체를
	액션태그에서 사용해야 한다.
	 -->
	<h2>액션태그로 영역의 객체 얻기</h2>
	<jsp:useBean id="member" class="model.MemberDTO" scope="request"></jsp:useBean>
	
	<h3>액션태그로 출력하기</h3>
	<ul>
		<li>
			아이디 : <jsp:getProperty property="id" name="member"/>
		</li>
		<li>
			패스워드 : <jsp:getProperty property="pass" name="member"/>
		</li>
		<li>
			이름 : <jsp:getProperty property="name" name="member"/>
		</li>
		
	</ul>
</body>
</html>