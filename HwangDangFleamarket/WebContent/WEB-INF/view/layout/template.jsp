<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>황당마켓</title>
<style type="text/css">
header{
	background-color:pink;
	text-align:center;
	padding: 5px;
}
nav{
	line-height: 50px;
	padding: 15px;
	padding-top: 50px;
	min-height:600px;
	width:200px;
	float:left;
} 
section{
	padding: 15px;
	min-height:500px;
	float:left;
}
footer{
	margin-bottom:10px;
	text-align:center;
	height:20px;
	clear:both;
}
</style>
</head>
<body>

	<header>
		<tiles:insertAttribute name="header"/> <!-- name 속성에 put-attribute 태그의 name 속성값을 호출 -->
	</header>
	
	<nav>
		<tiles:insertAttribute name="nav"/>
	</nav>
	
	<section>
		<tiles:insertAttribute name="body"/>
	</section>
	
	<footer>
		<tiles:insertAttribute name="footer"/>
	</footer>
</body>
</html>


