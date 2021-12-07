<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page 

import = "java.io.IOException"
import = "java.io.FileWriter"

import = "java.sql.Connection"
import = "java.sql.DriverManager"
import = "java.sql.SQLException"
import = "java.sql.Statement"
import = "java.sql.ResultSet"

import = "org.jdom2.*"
import = "org.jdom2.output.*"

%>

<%

String dsxml = request.getParameter("dsxml");
double ddclat = Double.parseDouble(request.getParameter("dclat"));
double ddclng = Double.parseDouble(request.getParameter("dclng"));
String ddbev = request.getParameter("dbev");
String ddoutlet1 = request.getParameter("doutlet1");
String ddsilent1 = request.getParameter("dsilent1");
String ddnetwork1 = request.getParameter("dnetwork1");
String ddpartition1 = request.getParameter("dpartition1");
String ddspacious1 = request.getParameter("dspacious1");
String ddlighting1 = request.getParameter("dlighting1");
String ddscenery1 = request.getParameter("dscenery1");

Connection con = null;
Statement stmt = null;
ResultSet rs = null;

try {
	
System.out.println("드라이버 로드 성공 !");

String url = "jdbc:mysql://192.168.219.102:3306/db?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
String account = "test";
String pass = "supermagic1";
String qu = "select * from test";
boolean start = false;
//String qu = "select * from test where bev = ";
if(!ddbev.equals("-1")||!ddoutlet1.equals("-1")||!ddnetwork1.equals("-1")||!ddsilent1.equals("-1")||!ddpartition1.equals("-1")||!ddspacious1.equals("-1")||!ddlighting1.equals("-1")||!ddscenery1.equals("-1")){
	qu += " where ";
	if(!ddbev.equals("-1")) {
		start = true;
		qu += "bev = " + ddbev;
	}
	if(!ddoutlet1.equals("-1")){
		if(start == false){
			start = true;
			qu += " outlet = " + ddoutlet1;
		} else{
			qu += " and outlet = " + ddoutlet1;
		}
	}
	if(!ddnetwork1.equals("-1")){
		if(start == false){
			start = true;
			qu += " network = " + ddnetwork1;
		} else{
			qu += " and network = " + ddnetwork1;
		}
	}
	if(!ddsilent1.equals("-1")){
		if(start == false){
			start = true;
			qu += " silent = " + ddsilent1;
		} else{
			qu += " and silent = " + ddsilent1;
		}
	}
	if(!ddpartition1.equals("-1")){
		if(start == false){
			start = true;
			qu += " part = " + ddpartition1;
		} else{
			qu += " and part = " + ddpartition1;
		}
	}
	if(!ddspacious1.equals("-1")){
		if(start == false){
			start = true;
			qu += " spacious = " + ddspacious1;
		} else{
			qu += " and spacious = " + ddspacious1;
		}
	}
	if(!ddlighting1.equals("-1")){
		if(start == false){
			start = true;
			qu += " lighting = " + ddlighting1;
		} else{
			qu += " and lighting = " + ddlighting1;
		}
	}
	if(!ddscenery1.equals("-1")){
		if(start == false){
			start = true;
			qu += " scenery = " + ddscenery1;
		} else{
			qu += " and scenery = " + ddscenery1;
		}
	}
}
/*
String qu2 = "select * from test where";
qu2 += " bev = " + ddbev;
qu2 += " and outlet = " + ddoutlet1;
qu2 += " and network = " + ddnetwork1;
qu2 += " and silent = " + ddsilent1;
qu2 += " and part = " + ddpartition1;
qu2 += " and spacious = " + ddspacious1;
qu2 += " and lighting = " + ddlighting1;
qu2 += " and scenery = " + ddscenery1;
*/
System.out.print("test1 : ");
System.out.println(qu);

	
// 이 때 *은 모든 필드(컬럼)을 의미하며 콤마로 별도의 필드(컬럼)을 지정해 줄 수 있다.

con = DriverManager.getConnection(url, account, pass);
System.out.println(con.toString());
System.out.println("XML JDBC Connector 연결 성공 !");		

stmt = con.createStatement();
rs = stmt.executeQuery(qu);

System.out.println("XML SQLServerStatement 개체 생성 !");




 //org.jdom2.* 라이브러리 사용
Element mapmarker2=new Element("markers");
Document doc=new Document(mapmarker2);

		while(rs.next()) {
			
			//하버사인 공식 (검색지점으로부터의 거리 계산)
			
			double distance;
			double radius = 6371; // 지구 반지름(km)
			double toRadian = Math.PI / 180;
			
			double locationlat = Double.parseDouble(rs.getString("lat"));
			double locationlng = Double.parseDouble(rs.getString("lng"));
			
			double deltaLatitude = Math.abs(ddclat - locationlat) * toRadian;
			double deltaLongitude = Math.abs(ddclng - locationlng) * toRadian;

			double sinDeltaLat = Math.sin(deltaLatitude / 2);
			double sinDeltaLng = Math.sin(deltaLongitude / 2);
			double squareRoot = Math.sqrt(
			sinDeltaLat * sinDeltaLat +
			Math.cos(ddclat * toRadian) * Math.cos(locationlat * toRadian) * sinDeltaLng * sinDeltaLng);

			distance = 2 * radius * Math.asin(squareRoot);
			
			
			// 검색기준지점으로부터 하버사인 거리가 10km 미만인 클래스만 카카오맵에 출력 (향후 해당값은 검색조건필터로 활용가능)
			
			if (distance < 5){
				
	        	Element data=new Element("marker");
	            

	        	data.setAttribute("pn", rs.getString("pn"));
	        	data.setAttribute("pad", rs.getString("pad"));
	        	data.setAttribute("lat", rs.getString("lat"));
	       	 	data.setAttribute("lng", rs.getString("lng"));      	    

	        	mapmarker2.addContent(data);
		
	        	XMLOutputter xout=new XMLOutputter();
				Format f=xout.getFormat();
				f.setEncoding("utf-8");
				f.setIndent("\t");
				f.setLineSeparator("\r\n");
				f.setTextMode(Format.TextMode.TRIM);
				xout.setFormat(f);

				String result=xout.outputString(doc);
				out.clear();
				out.print(result);
				
				continue;
				}
			
			}
}
catch(SQLException e) {
System.out.println("SQLException : " + e.getMessage());

} finally {
	if(stmt != null) {
		try {
			stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}			
	if(rs != null) {
		try {
			rs.close();
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