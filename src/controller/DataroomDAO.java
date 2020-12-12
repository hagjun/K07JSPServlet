package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class DataroomDAO {

   Connection con;
   PreparedStatement psmt;
   ResultSet rs;

   //기본생성자 DBCP(커넥션 풀)
   public DataroomDAO() {
      try {
         Context initCtx = new InitialContext();
         Context ctx = (Context) initCtx.lookup("java:comp/env");
         DataSource source = (DataSource) ctx.lookup("jdbc/myoracle");
         con = source.getConnection();
      } 
      catch (Exception e) {
         System.out.println("DBCP연결실패");
         e.printStackTrace();
      }
   }
   
   public DataroomDAO(ServletContext ctx) {
      try {
         Class.forName(ctx.getInitParameter("JDBCDriver"));
         String id = "kosmo";
         String pw = "1234";
         con = DriverManager.getConnection(
               ctx.getInitParameter("ConnectionURL"), id, pw);
         System.out.println("DB 연결성공^^*");

      } catch (Exception e) {
         System.out.println("DB연결 실패");
         e.printStackTrace();
      }
   }
   
   public void close() {
      try {
         //연결을 해제하는 것이 아니고 풀에 다시 반납한다.
         if (rs != null)
            rs.close();
         if (psmt != null)
            psmt.close();
         if (con != null)
            con.close();
      } 
      catch (Exception e) {
         System.out.println("자원반납시 예외발생");
      }
   }

   public int getTotalRecordCount(Map map) {

      int totalCount = 0;
      try {
         String sql = "SELECT COUNT(*) FROM dataroom";
         if (map.get("Word") != null) {
            sql += " WHERE " + map.get("Column") + " " 
               + " LIKE '%" + map.get("Word") + "%'";
         }

         psmt = con.prepareStatement(sql);
         rs = psmt.executeQuery();
         rs.next();
         totalCount = rs.getInt(1);
      } 
      catch (Exception e) {
      }
      return totalCount;
   }

   // 게시물의 가져와서 ResultSet형태로 변환
   public List<DataroomDTO> selectList(Map map) {
      // 리스트 컬렉션생성
      List<DataroomDTO> bbs = new Vector<DataroomDTO>();

      // 기본쿼리문
      String sql = " SELECT * FROM dataroom";

      // 검색어가 있을경우 조건절로 추가
      if (map.get("Word") != null) {
         sql += " WHERE " + map.get("Column") + " " + " LIKE '%" + map.get("Word") + "%'";
      }

      // 최근게시물을 항상 위로 노출하므로 작서된 순서의 역순으로 정렬
      sql += " ORDER BY idx DESC";
      try {
         psmt = con.prepareStatement(sql);
         rs = psmt.executeQuery();
         // 오라클이 반화해준 ResultSet의 갯수캄큼 반복
         while (rs.next()) {
            // 하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
            DataroomDTO dto = new DataroomDTO();

            // setter()을 통해 각각의 컬럼에 데이터자장
            dto.setIdx(rs.getString(1));
            dto.setName(rs.getString(2));
            dto.setTitle(rs.getString(3));
            dto.setContent(rs.getString(4));
            dto.setPostdate(rs.getDate(5));
            dto.setAttachedfile(rs.getString(6));
            dto.setDowncount(rs.getInt(7));
            dto.setPass(rs.getString(8));
            dto.setVisitcount(rs.getInt(9));

            bbs.add(dto);
         }

      } catch (Exception e) {
         System.out.println("select시 예외발생");
         e.printStackTrace();
      }
      return bbs;
   }
   
   public int insert (DataroomDTO dto) {
      
      int affected = 0;
      try {
         String sql = " INSERT INTO dataroom ( "
               + " idx, title, name, content, "
               + " attachedfile, pass, downcount) "
               + " VALUES ( "
               + " seq_dataroom_num.NEXTVAL, ?, ?, ?, ?, ?, 0) ";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getAttachedfile());
            psmt.setString(5, dto.getPass());
            
            affected = psmt.executeUpdate();
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return affected;
   }
   
   public void updateVisitCount(String idx) {
      
      String sql = " UPDATE dataroom SET "
               + " visitcount=visitcount+1 "
               + "   WHERE idx=? ";
      
      try {
         psmt = con.prepareStatement(sql);
         psmt.setString(1, idx);
         psmt.executeUpdate();
      }
      catch (Exception e) {}
   }
   
   //자료실 게시물 상세보기
   public DataroomDTO selectView(String idx) {
      
      DataroomDTO dto = null;
      String sql = " SELECT * FROM dataroom "
               + " WHERE idx=? ";
      
      try {
         psmt = con.prepareStatement(sql);
         psmt.setString(1, idx);
         rs = psmt.executeQuery();
         if(rs.next()) {
            dto = new DataroomDTO();
            
            dto.setIdx(rs.getString(1));
            dto.setName(rs.getString(2));
            dto.setTitle(rs.getString(3));
            dto.setContent(rs.getString(4));
            dto.setPostdate(rs.getDate(5));
            dto.setAttachedfile(rs.getString(6));
            dto.setDowncount(rs.getInt(7));
            dto.setPass(rs.getString(8));
            dto.setVisitcount(rs.getInt(9)); //조회수 추가
         }
      }
      catch (Exception e) {
         e.printStackTrace();
      }
      return dto;
   }
   
   //게시물의 일련번호, 패스워드를 통한 검증
   public boolean isCorrectPassword(String pass, String idx) {
      boolean isCorr = true;
      try {
         String sql = "    SELECT COUNT(*) FROM dataroom "
                  + " WHERE pass=? AND idx=? ";
         psmt = con.prepareStatement(sql);
         psmt.setString(1, pass);
         psmt.setString(2, idx);
         rs = psmt.executeQuery();
         rs.next();
         if(rs.getInt(1)==0) {
            //패스워드 검증 실패 (해당하는 게시물이 없음)
            isCorr = false;
         }
                  
      }
      catch (Exception e) {
         isCorr = false;
         e.printStackTrace();
      }
      return isCorr;
   }
   
   public int delete(String idx) {
      int affected = 0;
      try {
         String query = " DELETE FROM dataroom "
                  + " WHERE idx=? ";
         psmt = con.prepareStatement(query);
         psmt.setString(1, idx);
         
         affected = psmt.executeUpdate();
      }
      catch (Exception e) {
         System.out.println("delete 중 예외 발생");
         e.printStackTrace();
      }
      return affected;
   }
   
   public int update(DataroomDTO dto) {
      int affected = 0;
      try {
         String query = " UPDATE dataroom SET "
                  + " title=?, name=?, content=? "
                  + " , attachedfile=?, pass=? "
                  + " WHERE idx=? ";
         psmt = con.prepareStatement(query);
         psmt.setString(1, dto.getTitle());
         psmt.setString(2, dto.getName());
         psmt.setString(3, dto.getContent());
         psmt.setString(4, dto.getAttachedfile());
         psmt.setString(5, dto.getPass());
         
         //게시물 수정을 위한 추가부분
         psmt.setString(6, dto.getIdx());
         
         affected = psmt.executeUpdate();
      }
      catch (Exception e) {
         System.out.println("update 중 예외 발생");
         e.printStackTrace();
      }
      return affected;
   }
   
   //파일 다운로드 횟수 증가
   public void downCountPlus(String idx) {
      String sql = " UPDATA dataroom SET "
               + " downcount = downcount+1 "
               + " WHERE idx=? ";
      try {
         psmt = con.prepareStatement(sql);
         psmt.setString(1, idx);
         psmt.executeUpdate();
      }
      catch (Exception e) {}
   }
   public List<DataroomDTO> selectListPage(Map map){
	   List<DataroomDTO> bbs = new Vector<DataroomDTO>();
	   
	   String sql = " "
				+"SELECT * FROM ("
	    	    +"   SELECT Tb.*, rownum rNum FROM ("
	    	    +"    SELECT * FROM dataroom ";
	    	if(map.get("Word")!=null)
	    	{
	    		sql +=" WHERE "+ map.get("Column") +" "
	    			+" LIKE '%"+ map.get("Word") +"%' ";
	    	}
	    	sql +=" ORDER BY idx DESC"
	    		+"   ) Tb "
	    		+")"
	    		+" WHERE rNum BETWEEN ? and ?";
	    	System.out.println("쿼리문:"+ sql);   
	    	
	    	try {
	    		psmt = con.prepareStatement(sql);
	    		psmt.setInt(1,
	    				Integer.parseInt(map.get("start").toString()));
	    		psmt.setInt(2,
	    				Integer.parseInt(map.get("end").toString()));
	    		rs = psmt.executeQuery();
	    		while(rs.next()) {
	    			DataroomDTO dto = new DataroomDTO();
	    			
	    			dto.setIdx(rs.getString(1));
	    			dto.setName(rs.getString(2));
	    			dto.setTitle(rs.getString(3));
	    			dto.setContent(rs.getString(4));
	    			dto.setPostdate(rs.getDate(5));
	    			dto.setAttachedfile(rs.getString(6));
	    			dto.setDowncount(rs.getInt(7));
	    			dto.setPass(rs.getString(8));
	    			dto.setVisitcount(rs.getInt(9));
	    			
	    			bbs.add(dto);
	    			
	    		}
	    	}
	    	catch(Exception e) {
	    		e.printStackTrace();
	    	}
	    	return bbs;
   }
}













