<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="fmt"   uri="http://java.sun.com/jsp/jstl/fmt"  %> 
<style>

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- <script>

	$(document).ready(function(){
		$("input[name=keyword]").click(function(){
			alert("t");
		});
	});
</script>
 -->
<form action="/HwangDangFleamarket/buy/findProductByKeyword.go" method="POST" >
	<input type="text"  size="60" name="keyword" placeholder="상품/판매자 검색" >
	<input type="submit" value="검색"/>
<br/>
</form>
