<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UseBeanAction.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>useBean 액션태그</h2>
	
	<h3>useBean 액션태그로 좁은의미의 자바빈 객체 생성하기</h3>
	
	<%
	MemberDTO memberDTO = (MemberDTO)request.getAttribute("member");
	if(memberDTO==null){
		memberDTO = new MemberDTO();
		request.setAttribute("member", memberDTO);
	}
	%>
	
	<jsp:useBean id="member" class="model.MemberDTO" scope="request" />
	<h3>setProperty 액션태그로 자바빈 객체 속성지정하기</h3>
	<jsp:setProperty property="id" name="member"
		value="KIM" />
	<jsp:setProperty property="pass" name="mamber"
		value="1234" />
	<jsp:setProperty property="name" name="mamber"
		value="김희선"/>
		
	<h3>getProperty 액션태그로 자바빈 객체 속성읽기</h3>
	<ul>
		<li>아이디 :
			<jsp:getProperty property="id" name="member"/>
		</li>
		<li>패스워드 :
			<jsp:getProperty property="pass" name="member"/>
		</li>
		<li>이름 :
			<jsp:getProperty property="name" name="member"/>
		</li>
		
		<jsp:forward page="UseBeanActionForward.jsp"></jsp:forward>
	</ul>
</body>
</html>