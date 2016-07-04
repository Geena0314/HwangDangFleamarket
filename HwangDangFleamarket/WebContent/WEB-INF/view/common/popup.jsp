<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>주소 찾기(zip code finder)</h4>
	도로명 주소 <input type="radio" name="method" id="method1" />
	지번 주소 <input type="radio" name="method" id="method2" />
	<div>
		검색방법 : 시/도 및 시/군/구 선택 후 도로명과 건물번호 입력
		예) 테헤란로(도로명) + 152 (건물번호)
		* 도로명 주소가 검색되지 않는 경우는 행정안전부 새주소안내시스템
		(http://www.juso.go.kr) 에서 확인하시기 바랍니다.
	</div>
	
	시도<select name="sido" id="sido">
		
		</select>
	시군구<select name="sigungu" id="si" />
				<option>성남시 분당구</option>
			</select>
	도로명<input type="text" name="doroName" id="doroName" />
	건물번호 <input type="text" name="buildingNumber" id="buildingNumber" />
	
	
</body>
</html>