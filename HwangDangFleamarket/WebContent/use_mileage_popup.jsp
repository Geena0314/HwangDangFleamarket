<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>

	$(document).ready(function(){
		
		
 		$("#btn").click(function(){
 			var useMileage = $("#mileage").val();
 			var cutline = $(opener.document).find("#memberMileage").text().trim();
 			//alert(useMileage.length);
 			if(useMileage > cutline){
 				alert("가용포인트 :"+cutline+"점 입니다.");
 			}else if(useMileage.length == 0){  
 				alert("사용할 마일리지를 입력하세요.");
 				return false;
 			}else if(useMileage < 1){
 				alert("1점보다 큰 마일리지를 입력하세요.");
 				return false;
 			}else if(useMileage <= cutline ){
 				
 				$(opener.document).find("#useMileage").text(useMileage); //방식 3
 				$(opener.location).attr("href", "javascript:addMileage(useMileage);");
 				window.close(); 
 			
 			}
 			
 			
 			
 		});
	});
</script>
</head>

<body>
	<h4>마일리지 선택 </h4>
	 사용할 마일리지 선택 : <input type="number" name="mileage" id="mileage" /><br/>
	 <input type="button" id="btn" value="선택"/>
	
</body>
</html>