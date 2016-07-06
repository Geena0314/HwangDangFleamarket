<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="/HwangDangFleamarket/styles/template.css">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous"> -->
<meta charset="UTF-8">
<title>황당마켓</title>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
 $(document).ready(function(){
	 $(window).resize(function(){
		//console.log('resize event !!', this.innerWidth);
		var size = (this.innerWidth)*0.85 - 250;
 		$('section').css('width',size);
	 });
 });
</script>
</head>
<body>

	<header>
		<tiles:insertAttribute name="header"/> <!-- name 속성에 put-attribute 태그의 name 속성값을 호출 -->
		<tiles:insertAttribute name="searchBar"/>
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


