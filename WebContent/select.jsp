<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html>
<style>
#test1{
   font-size: 5rem;
   text-align : center;
   font-weight : bolder;
   color : #46C6C6;
   
}
#test2{
	font-size : 3rem;
	text-align : center;
	color : #8c8c8c;
	
}
#test3{
	font-size : 4rem;
	font-style : italic;
	font-weight : bold;
	text-align : center;
}
#test4{
	position : absolute;
	left : 50px;
	top : 1150px;
	text-align : center;
	color : #46C6C6;
	font-size : 2rem;
	
}
#test5{
	position : absolute;
	left : 530px;
	top : 1150px;
	text-align : center;
	font-size : 2rem;
	color : gray;
}
#test6{
	position : absolute;
	left : 50px;
	top : 1250px;
}
#test7{
	position : absolute;
	left : 550px;
	top : 1250px;
}
#test8{
	position : absolute;
	left : 0px;
	top : 0px;
}
#test_btn1{
position: absolute;
top: 1000px;
left: 100px;
width: 300px;
height: 100px;
margin-right:-4px;
border: 5px solid gray; 
background-color: white; 
color: #46C6C6; 
padding: 5px; 
font-size: 2rem;
font-weight : bold;
border-radius: 12px;
}
#test_btn2{
position: absolute;
top: 1000px;
left:600px;
width: 300px;
height: 100px;
margin-left:-3px;
border: 5px solid gray; 
background-color: #46C6C6; 
color: white; 
padding: 5px; 
font-size: 2rem;
font-weight : bold;
border-radius: 12px;
}
#btn_group button{ 
border: 1px solid skyblue; 
background-color: rgba(0,0,0,0); 
color: skyblue; 
padding: 5px; 
}
</style>
<head>
<meta charset="EUC-KR">
<title>Select</title>
</head>
<body bgcolor="#C8FFF">
<div id = "test8"><img src="decoration2.png" alt="My Image" width = "1000" height = "300"></div>
<div id = "test1"> <br><br>Hi, there!<br><br><br> </div>
<div id = "test2"> Welcome to </div>
<div id = "test3"> Studywhere </div>
<div id = "test2"> where you can easily find and register study spots<br> within your area</div>
<div id = "btn_group"></div>
<button type="button" id = "test_btn1" onclick="location.href='register2.jsp' ">Register</button>
<div id = "test4">Click the button to add a new<br>study spot if it's not already in our<br> database!</div>
<div id = "test5">Click the button to find a study <br>spot in your preferred location!</div>
<button type="button" id = "test_btn2" onclick="location.href='main2.jsp' ">Find</button>
</div>
<div id = "test6"><img src="pngegg.png" alt="My Image" width = "400" height = "400"></div>
<div id = "test7"><img src="study.png" alt="My Image" width = "400" height = "400"></div>
</body>
</html>