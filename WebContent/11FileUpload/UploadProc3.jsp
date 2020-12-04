<%@page import="model.MyFileDAO"%>
<%@page import="model.MyfileDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");//한글깨짐처리

//파일업로드를 위한 MultiPartRequest객체의 파라미터준비
/*
   1.파일이 업로드될 서버의 물리적경로 가져오기
   : 운영체재별로 서버의 물리적 경로는 다르기 때문에 파일이 업로드되는
   정확한 위치를 가져오기 위해서 반드시 필요한 정보이다.
*/
String saveDirectory = application.getRealPath("/Upload");
/*
   2. 업로드할 파일의 최대용량 설정(바이트단위)
   : 만약 파일이 여러개 업로드된다면 각각의 용량을 합친 용량이 
   최대용량이 된다.
   Ex) 500Kb * 2 = 1000Kb
*/
int maxPostSize = 1024*5000;

//3. 인코딩 방식 설정
String encoding = "UTF-8";

/*
   4.파일명 중복처리
   : 파일명이 중복되는 경우 자동인덱스를 부여하여 파일명을 수정해준다.
   Ex) apple.png, apple1.png, 와같이 인덱스를 부여한다.
*/
FileRenamePolicy policy = new DefaultFileRenamePolicy();

//멀티파트 객체 생성 및 전송된 폼값을 저장하기 위한 변수선언
MultipartRequest mr = null;
String name = null;
String title = null;
StringBuffer inter = new StringBuffer();

File oldFile = null;
File newFile = null;
String realFileName = null;
try{
   /*
   1~4번까지 준비한 인자를 이용하여 아래 객체를 생성한다.
   객체가 정상적으로 생성되면 파일업로드는 완료된다.
   만약 예외가 발생한다면 주로 최대용량초과 혹은 디렉토리 경로가   잘못된 경우이다.
   */
   mr = new MultipartRequest(request, saveDirectory, maxPostSize,
         encoding, policy);
   
   //////////추가부분 Start/////////////////////
   
   
   String fileName = mr.getFilesystemName("chumFile1");
   
   String nowTime = new SimpleDateFormat("yyyy_MM_dd_H_m_s_S").format(new Date());
   
   int idx = -1;
   
   idx = fileName.lastIndexOf(".");
   realFileName = nowTime + fileName.substring(idx, fileName.length());
   
   oldFile = new File(saveDirectory+oldFile.separator+fileName);
   newFile = new File(saveDirectory+oldFile.separator+realFileName);

   oldFile.renameTo(newFile);
   /////////추가부분 end///////////////////////
   
   /*
   파일외에 폼값을 받아온다. 이때 폼값은 request객체가 아닌
   MultipartRequest객체를 통해 받게된다.
   */
   name = mr.getParameter("name");
   title = mr.getParameter("title");
   String[] interArr = mr.getParameterValues("inter");
   for(String s : interArr){
      inter.append(s+",&nbsp;");
   }
   //////////////////////////////////////
   //DTO객체 생성후 폼값 저장
   MyfileDTO dto = new MyfileDTO();
   dto.setName(name);
   dto.setTitle(title);
   dto.setInter(inter.toString());
   dto.setOflie(mr.getOriginalFileName("chumFile1"));//원본파일명
   dto.setSfile(realFileName);//서버에 저장된 파일명
   
   //DAO객체에 생성후 DB연결 및 insert처리
   MyFileDAO dao = new MyFileDAO(application);
   dao.myFileInsert(dto);
   
   //DB처리후 페이지 이동
   response.sendRedirect("FileList.jsp");
   ///////////////////////////////////
}

catch(Exception e){
   request.setAttribute("errorMessage", "파일업로드오류");
   request.getRequestDispatcher("FileUploadMain.jsp")
      .forward(request, response);
}
%>
