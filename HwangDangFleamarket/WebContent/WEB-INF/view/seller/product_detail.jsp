<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="lee"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style type="text/css">
			#main
			{
				width:800px;
				height:300px;
				backfround-color: blue;
				margin-left : 50px;
				margin-top : 50px;
			}
			#mainImage
			{
				width : 300px;
				height : 200px;
				margin : 50px;
				float : left;
			}
			#table
			{
				width : 300px;
				height : 200px;
				margin : 50px;
				float : left;
			}
			#info
			{
				width:600px;
				min-height:400px;
				backfround-color: blue;
				margin-left : 150px;
				float : left;
			}
		</style>
		
		<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
		<script type="text/javascript">
			$(document).ready(function()
			{
				$("#optionName").on("change", function()
				{
					var index = this.selectedIndex;
					$.ajax
					({
						"url" : "/HwangDangFleamarket/product/optionStock.go",
						"type" : "POST",
						"data" : "optionName=" + $("#optionName").val(),
						"dataType" : "JSON",
						"beforeSend" : function()
						{
							$("#error").empty();
							$("#optionAddPrice").empty().append("원.");
							$("#optionStock").empty().html("<option>수량선택</option>");
							$("#optionNameError").empty();
							$("#optionStockError").empty();
							if(index == 0)
								$("#optionNameError").append("선택할 수 없는 옵션입니다.");
						},
						"success" : function(json)
						{
							if(json.optionStock == 0)
							{
								$("#optionStockError").append("재고량이 부족합니다.")
								return false;
							}
							for(var i = json.optionStock; i > 0 ; i--)
							{
								$("#optionStock").append("<option>" + i + "</option>");
							}
							if(json.optionAddPrice == 0)
							{
								return false;
							}
							$("#optionAddPrice").prepend(json.optionAddPrice);
						},
						"error" : error
					});
				});
			});
			
			function error()
			{
				
			}
		</script>
		
	</head>

	<body>
		<div id="main" align="center">
			<h2>상품 상세 정보 보기.</h2>
			<div id="mainImage">
				<img src="../image_storage/${ requestScope.product.productMainImage }.jpg"  style="width:300px;height:200px;">
			</div>
			<div id="table">
				<form method="POST" action="#">
					<table>
						<tr>
							<td>상품명</td>
							<td>${ requestScope.product.productName }</td>
						</tr>
						<tr>
							<td>가격</td>
							<td>${ requestScope.product.productPrice }원.</td>
						</tr>
						<tr>
							<td>옵션</td>
							<td>
								<select id="optionName">
									<option>${ requestScope.optionList[0].optionName }</option>
									<lee:forEach items="${ requestScope.optionList }" var="option">
										<option value=${ option.optionSubName }>${ option.optionSubName }</option>
									</lee:forEach>
								</select>
							</td>
						</tr>
						<tr><td colspan="2" id="optionNameError"></td></tr>
						<tr>
							<td>수량</td>
							<td>
								<select id="optionStock">
									<option>수량선택.</option>
								</select>
							</td>
						</tr>
						<tr><td colspan="2" id="optionStockError"></td></tr>
						<tr>
							<td>추가가격</td>
							<td id="optionAddPrice">원.</td>
						</tr>
						<tr>
							<td><input type="submit" value="바로구매"></td>
							<td><input type="button" value="리스트로 돌아가기." onclick="window.location='/HwangDangFleamarket/product/list.go?page=${param.page}&sellerStoreNo=${param.sellerStoreNo}'"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<div id="info" align="center">
			<h2>상세정보 보기</h2>
			<lee:forEach items="${ requestScope.detailimage }" var="image">
				<img src="../image_storage/${ image }.jpg"  style="width:300px;height:200px;"><br>
			</lee:forEach>
		
			상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다
			상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다
			<br><br><br><br><br><br><br><br><br><br>(br 위아래로 10개.)<br><br><br><br><br><br><br><br><br><br>
		</div>
		<div>
			
		</div>
	</body>
</html>