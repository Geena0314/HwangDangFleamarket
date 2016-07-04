<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
table, td {
	border-top: 3px solid gray;
	border-bottom: 3px solid gray;
	border-left: none;
	border-right: none;
	text-align: center;
}
table {
	width: 650px;
}
.thead{
	width: 650px;
	background-color: lightgray;
}
.tfoot{
	background-color: lightgray;
}
td {
	border: none;
}
a {
	text-decoration: none;
}

a:HOVER {
	text-decoration: underline;
}

b {
	font-size: 15pt;
}
img{
	width: 100px;
	height: 100px; 
	float: left;
}
ul li{
	list-style: none;
}
.estimatedPrice{
	display: block;
	border: 3px solid gray;
	text-align: right;
}
.bottomBtn{
	float: right;
}
</style>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
$( document ).ready( function() {
    $('#basketAll').on("click", function() {
    	if($("#basketAll").prop("checked")){
            $("input[name=checkBasket]").prop("checked",true);
        }else{
            $("input[name=checkBasket]").prop("checked",false);
        }
    });
    $('#deleteBtn').on("click", function(){
    	
    	
    });
    
    $("#buyBtn").on("click",function(){
    	
		 alert("buyBtn TEST");  	
    	
    });
    
    
});
</script>
<p align="right">
	<b>장바구니</b>
</p>
<div class="cartListSection">
	<div class="cartTable">
		<table>
			<colgroup>
				<col style="width: 5%">
				<col style="width: 50%">
				<col style="width: 10%">
				<col style="width: 15%">
			</colgroup>
			<thead class="thead">
				<tr>
					<th scope="col">
						<label for="basketAll">
							<div class="checker" id="markBasketAll">
								<span class="checked"> 
									<input type="checkbox" id="basketAll" title="장바구니 상품 전체선택">
								</span>
							</div>
						</label>
					</th>
					<th scope="col"><span>상품</span></th>
					<th scope="col"><span>수량</span></th>
					<th scope="col" class="col2"><span>가격</span></th>
					<th scope="col"><span>배송정보</span></th>
				</tr>
			</thead>
				<form action="" method="POST" id="cart_form">
				
				<tbody>
					<c:forEach items="${requestScope.cartList}" var="list">
						<c:forEach items="${list.productList}" var="product">
							<tr class="cartList">
								<td class="first">
									<div class="checker" id="markBasketAll">
										<span class="checked"> 
											<input type="checkbox" name="checkBasket" title="장바구니 상품 선택">
										</span>
									</div>
								</td>
								<td>
								<%-- 스토어 이름, 상품명, 선택한 옵션 --%>
									<ul>
										<li id="listBlock">
											<div class="thmb">
												<div class="storeImg">
													<a href="/HwangDangFleamarket/product/detail.go?page=1&productId=${product.productId}&sellerStoreNo=${product.seller.sellerStoreNo}&sellerStoreImage=${product.seller.sellerStoreImage}"><img src="../image_storage/${product.productMainImage}"></a>
												</div>
											</div>
											<ul class="storeInfo">
												<li>
													<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${product.seller.sellerStoreNo}&sellerStoreImage=${product.seller.sellerStoreImage}">${product.seller.sellerStoreName}</a>
												</li><br>
												<li>
													${product.productName}/${product.productOption.optionSubName}
												</li>
											</ul>
										</li>
									</ul>
								</td>
								<td>
								<%-- 수량 --%>
									${list.cartProductAmount}
								</td>
								<td>
								<%-- 가격 --%>
								<%-- 수량이랑 곱한값 넣어주기 --%>	
									${product.productPrice * list.cartProductAmount}
								</td>
								<td>
									무료 배송
								</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
		</table>
	</div>
	<p>
	<div class="estimatedPrice">
		결제 예상 금액
		<hr>
		5,555,000원
	</div>
	<p>
	<span class="bottomBtn">
	<input type="button" value="선택상품삭제" id="deleteBtn">&nbsp;&nbsp;
	<input type="button" value="구매하기" id="buyBtn">
	</span>
	</form>
</div>

