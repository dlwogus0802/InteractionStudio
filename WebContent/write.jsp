<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page
import = "java.sql.Connection"
import = "java.sql.DriverManager"
import = "java.sql.SQLException"
import = "java.sql.Statement"
%>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0">
	<title> Autocomplete Place Write </title>
    
<style>

</style>
</head>

<body>
<div id="wrapper">

클래스 등록이 완료되었습니다!

<!-- 클래스 내용 DB Write -->

<%
		request.setCharacterEncoding("UTF-8");

	    	String lat1 = request.getParameter("latclick");  
		String lng1 = request.getParameter("lngclick");
	    	String paddress1 = request.getParameter("paddress");
	    	String pname1 = request.getParameter("pname");
	    	String bev1 = request.getParameter("beverage");
	    	if(bev1 == null) bev1 = "false";


		Connection con = null;
		Statement stmt = null;
		
		 //콘솔 출력 테스트 차례대로 위도, 경도, 주소, 장소명
		System.out.println(lat1);
		System.out.println(lng1);
        	System.out.println(paddress1);
		System.out.println(pname1);
		
		try {
		
		System.out.println("드라이버 로드 성공 !");
		
		String url = "jdbc:mysql://192.168.219.102:3306/db?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
		String id = "test";
		String pass = "supermagic1";
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, id, pass);
		System.out.println(con.toString());
		System.out.println("JDBC Connector 연결 성공 !");
		
		// input data
		
				String sql = "insert into test (lat, lng, pad, pn) values (lat1, lng1, paddress1, pname1)";
				String sql2 = "insert into test (lat, lng, pad, pn, bev) value (";
				sql2 = sql2 + "\"" + lat1 + "\"" + ", ";
				sql2 = sql2 + "\"" + lng1 + "\"" + ", ";
				sql2 = sql2 + "\"" + paddress1 + "\"" + ", ";
				sql2 = sql2 + "\"" + pname1 + "\"" + ", ";
				sql2 = sql2 + bev1 + ")";
				stmt = con.createStatement();
				System.out.println("SQLServerStatement 개체 생성 !");
									
				stmt.executeUpdate(sql2);
				
				} catch(SQLException e) {
					System.out.println("SQLException : " + e.getMessage());

				} finally {
					if(stmt != null) {
						try {
							stmt.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					if(con != null) {
						try {
							con.close();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
		%>
</div>
</body>
</html>