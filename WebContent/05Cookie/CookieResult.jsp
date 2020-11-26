<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>쿠키(Cookie)</h2>
	
	<h3>쿠키 설정</h3>
	<%
	Cookie cookie =  new Cookie("UserID", "KOSMO");
	
	System.out.println("request.getContextPath()"
							+ request.getContextPath());
	cookie.setPath(request.getContextPath());
	
	cookie.setMaxAge(3600);
	
	response.addCookie(cookie);
	%>
	
	<h2>쿠키글 설정하는 현재페이지에서 쿠키값 확인하기</h2>
	<%
	Cookie[] cookies = request.getCookies();

	if(cookies!=null){
		
		for(Cookie c : cookies){
			String cookiName = c.getName();
			String cookieValue = c.getValue();
			
			out.println(String.format("%s : %s<br/>",
					cookiName, cookieValue));
			
		}
	}
	%>
	<h2>페이지 이동후 쿠키값 확인하기</h2>
	<a href="CookieResult.jsp">
		쿠키값 다음페이지에서 확인하기
	</a>
</body>
</html>