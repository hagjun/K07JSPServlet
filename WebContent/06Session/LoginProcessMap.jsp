<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
//폼값받기
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
 
//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("JDBCDriver");
String url = application.getInitParameter("ConnectionURL");

//DAO객체생성 및 DB연결

MemberDAO dao = new MemberDAO(drv, url);


//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리 함수 호출
// MemberDTO memberDTO = dao.getMemberDTO(id, pw);
// if(memberDTO.getId()!=null){
// 	session.setAttribute("USER_ID", id);
// 	session.setAttribute("USER_PW", pw);
// 	session.setAttribute("USER_NAME", id);
// }

//방법3 : Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap =  dao.getMemberMap(id, pw);	
if(memberMap.get("id")!=null){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.
	session.setAttribute("USER_ID", memberMap.get("id"));
	session.setAttribute("USER_PW", memberMap.get("pass"));
	session.setAttribute("USER_NAME",memberMap.get("name"));
	
	response.sendRedirect("Login.jsp");
}
else{
	//로그인 실패시 리퀘스트 영역에 속성을 저장후 로그인 페이지로 포워드한다.
	request.setAttribute("ERROR_MSG", "넌 회원이 아니시군-_-;");
	request.getRequestDispatcher("Login.jsp").forward(request,response);
}
%>