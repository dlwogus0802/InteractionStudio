<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.IOException"

import = "java.sql.Connection"
import = "java.sql.DriverManager"
import = "java.sql.SQLException"
import = "java.sql.Statement"
import = "java.sql.ResultSet"

import = "org.jdom2.*"
import = "org.jdom2.output.*"

%>

<!DOCTYPE html>
<html lang="ko">

<%		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
				
		String ds = "";
		double clat = Double.parseDouble(request.getParameter("center_lat"));
		double clng = Double.parseDouble(request.getParameter("center_lng"));
		String bev1 = request.getParameter("beverage");
    	String outlet1 = request.getParameter("outlet");
    	String network1 = request.getParameter("network");
    	String silent1 = request.getParameter("silent");
    	String partition1 = request.getParameter("partition");
    	String spacious1 = request.getParameter("spacious");
    	String lighting1 = request.getParameter("lighting");
    	String scenery1 = request.getParameter("scenery");
		
		 //콘솔 출력 테스트
		System.out.println(clat);
		System.out.println(clng);
		
		
		try {
			
		System.out.println("드라이버 로드 성공 !");
		
		String url = "jdbc:mysql://192.168.219.102:3306/db?serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&characterEncoding=UTF-8";
		String account = "test";
		String pass = "supermagic1";
		String qu = "select * from test";
		boolean start = false;
		if(!bev1.equals("-1")||!outlet1.equals("-1")||!network1.equals("-1")||!silent1.equals("-1")||!partition1.equals("-1")||!spacious1.equals("-1")||!lighting1.equals("-1")||!scenery1.equals("-1")){
			qu += " where ";
			if(!bev1.equals("-1")) {
				start = true;
				qu += "bev = " + bev1;
			}
			if(!outlet1.equals("-1")){
				if(start == false){
					start = true;
					qu += " outlet = " + outlet1;
				} else{
					qu += " and outlet = " + outlet1;
				}
			}
			if(!network1.equals("-1")){
				if(start == false){
					start = true;
					qu += " network = " + network1;
				} else{
					qu += " and network = " + network1;
				}
			}
			if(!silent1.equals("-1")){
				if(start == false){
					start = true;
					qu += " silent = " + silent1;
				} else{
					qu += " and silent = " + silent1;
				}
			}
			if(!partition1.equals("-1")){
				if(start == false){
					start = true;
					qu += " part = " + partition1;
				} else{
					qu += " and part = " + partition1;
				}
			}
			if(!spacious1.equals("-1")){
				if(start == false){
					start = true;
					qu += " spacious = " + spacious1;
				} else{
					qu += " and spacious = " + spacious1;
				}
			}
			if(!lighting1.equals("-1")){
				if(start == false){
					start = true;
					qu += " lighting = " + lighting1;
				} else{
					qu += " and lighting = " + lighting1;
				}
			}
			if(!scenery1.equals("-1")){
				if(start == false){
					start = true;
					qu += " scenery = " + scenery1;
				} else{
					qu += " and scenery = " + scenery1;
				}
			}
		}
		System.out.print("test : ");
		System.out.println(qu);
				
			
		// 이 때 *은 모든 필드(컬럼)을 의미하며 콤마로 별도의 필드(컬럼)을 지정해 줄 수 있다.
		
		con = DriverManager.getConnection(url, account, pass);
		System.out.println(con.toString());
		System.out.println("JDBC Connector 연결 성공 !");		
		
		stmt = con.createStatement();
		rs = stmt.executeQuery(qu);
		
		System.out.println("SQLServerStatement 개체 생성 !");
		
		 //org.jdom2.* 사용
        Element root=new Element("markers");      
        Document doc=new Document(root);
%>		

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0">
	<title> Seminar Load</title>
    
<style>
body{
	font-family:"맑은 고딕", "고딕", "굴림";
}

html, body {
margin: 0px; 
padding: 0px;
}

#wrapper{
	width:100%;
	margin: 0 auto;
	size : 1rem;	
}

	  /* Always set the map height explicitly to define the size of the div
       *element that contains the map. */
    
       
#map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      
#classlist {
		width:100%;
		margin-top: 90vh;
		margin-left: 0vh;
		height: 85vh;
		float: left;
		font-size : 1rem;
		}

     
#maplist {
		position: absolute;
		margin-top: 0vh;
		margin-left: 0%;
		width:100%;
		height: 85vh;
		float: center;		
		}
	

</style>
	
		
<!-- xml 파일로부터 데이터 불러오기 -->

 <script> 	
 
 
 // Change this depending on the name of your PHP or XML file
 // 아래 내용은 xml 파일로부터 태그네임 marker에서 각 엘레먼트들을 getAttribute로 가져온 것.

	        function initMap() {
	        var map = new google.maps.Map(document.getElementById('map'), {
	          center: new google.maps.LatLng(<%=clat%>, <%=clng%>),
	          zoom: 14
	        });
	        
	        var infoWindow = new google.maps.InfoWindow;

	          // Change this depending on the name of your PHP or XML file
	          downloadUrl('./xml.jsp?dclat=<%=clat%>&dclng=<%=clng%>&dbev=<%=bev1%>&doutlet1=<%=outlet1%>&dsilent1=<%=silent1%>&dnetwork1=<%=network1%>&dpartition1=<%=partition1%>&dspacious1=<%=spacious1%>&dlighting1=<%=lighting1%>&dscenery1=<%=scenery1%>', function(data) {
	            var xml = data.responseXML;
	            var markers = xml.documentElement.getElementsByTagName('marker');
	            Array.prototype.forEach.call(markers, function(markerElem) {
	              var place_name = markerElem.getAttribute('pn');
	              var address = markerElem.getAttribute('pad');
	              var point = new google.maps.LatLng(
	                  parseFloat(markerElem.getAttribute('lat')),
	                  parseFloat(markerElem.getAttribute('lng')));
	              
	              // 아래내용은 infowindow에 관한 설정 document.createElement

	              var infowincontent = document.createElement('div');
	              
	              // 아마 Strong은 html 구현으로서 굵은 글씨를 의미. 마찬가지로 세줄아래의 br도 줄 띄우기.
	              var strong = document.createElement('strong');
	              strong.textContent = place_name
	              infowincontent.appendChild(strong);
	              infowincontent.appendChild(document.createElement('br'));

	              var text = document.createElement('text');
	              text.textContent = address
	              infowincontent.appendChild(text);
	              
	           // 마커 특성 설정
	              var marker = new google.maps.Marker({
	                map: map,
	                position: point,
	              });
	           
	           // 클릭하면 인포윈도우 오픈 이벤트가 발생
	              marker.addListener('click', function() {
	                infoWindow.setContent(infowincontent);
	                infoWindow.open(map, marker);
	              });
	            });
	          });
	          
	          
	          
	        }

	      function downloadUrl(url, callback) {
	        var request = window.ActiveXObject ?
	            new ActiveXObject('Microsoft.XMLHTTP') :
	            new XMLHttpRequest;

	        request.onreadystatechange = function() {
	          if (request.readyState == 4) {
	            request.onreadystatechange = doNothing;
	            callback(request, request.status);
	          }
	        };

	        request.open('GET', url, true);
	        request.send(null);
	      }

	      function doNothing() {}
	    </script>

 <!-- async defer를 사용하면 html 내부에서 위치에 상관없이 실행시킬 수 있다. -->
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC3nIysEb9waGit37Yc9lHQFOKvZF-5lE4&callback=initMap">
    </script>
        
</head>
<body bgcolor="#FFFAF0">
<div>
<div id="wrapper">
     	
	<div id="classlist" style = "font-size : 20px"> <br><br> Study places you want! <br><br>

    <% 
    //등록된 세미나 불러오기
		while(rs.next()) {
                	   
                	//하버사인 공식 (검색지점으로부터의 거리 계산)
           			
           			double distance;
           			double radius = 6371; // 지구 반지름(km)
           			double toRadian = Math.PI / 180;
           			
           			double locationlat = Double.parseDouble(rs.getString("lat"));
           			double locationlng = Double.parseDouble(rs.getString("lng"));
           			
           			double deltaLatitude = Math.abs(clat - locationlat) * toRadian;
           			double deltaLongitude = Math.abs(clng - locationlng) * toRadian;

           			double sinDeltaLat = Math.sin(deltaLatitude / 2);
           			double sinDeltaLng = Math.sin(deltaLongitude / 2);
           			double squareRoot = Math.sqrt(
           			sinDeltaLat * sinDeltaLat +
           			Math.cos(clat * toRadian) * Math.cos(locationlat * toRadian) * sinDeltaLng * sinDeltaLng);

           			distance = 2 * radius * Math.asin(squareRoot);
           			
           			System.out.println(distance);
           			
           			
           			// 검색기준지점으로부터 하버사인 거리가 10km 미만인 클래스만 구글맵에 출력 (향후 해당값은 검색조건필터로 활용가능)
           			
           		   if (distance < 10) {         	   
  
                   out.println("<table>");
                          		   
           	   out.println("<tr>");	
         	   out.println("<td>" + rs.getString("pad") + "</td>");
         	   out.println("</tr>");
           		   
           	   out.println("<tr>");	
        	   out.println("<td>" + rs.getString("pn") +"</td>");
        	   out.println("</tr>");
  
           	   out.println("<tr>");	
         	   out.println("<td>" + rs.getString("startTime") + "-" + rs.getString("endTime")+"</td>");
         	   //out.println("</tr>");
               
           	   //out.println("-");	
         	   //out.println("<td>" + rs.getString("endTime") + "</td>");
         	   out.println("</tr>");

        	   out.println("</table>");  
               
                   continue;
                   
           		   }
                   
		}
    %>                  
             
    </div>
	<div id = "maplist">
	<div id = "map">
	</div>
	</div>
</div>

<%
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
</body>