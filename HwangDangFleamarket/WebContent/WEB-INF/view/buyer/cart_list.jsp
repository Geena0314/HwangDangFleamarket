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
            var sum = 0;
            $('tbody td:nth-child(4)').each(function(){
            	sum = sum + parseInt($(this).text());
            });
            $('#checkedEstimatedPrice').html(sum);
        }else{
            $("input[name=checkBasket]").prop("checked",false);
            $('#checkedEstimatedPrice').html(0);
        }
    });
    $("input[name=checkBasket]").on("click", function(){
    	var totalPrice = parseInt($('#checkedEstimatedPrice').text());
    	$('#checkedEstimatedPrice').empty();
    	if(this.checked){
    		totalPrice = totalPrice + parseInt($(this).parents().children("#price").text());
    		$('#checkedEstimatedPrice').append(totalPrice);
    	}else{
    		totalPrice = totalPrice - parseInt($(this).parents().children("#price").text());
    		$('#checkedEstimatedPrice').append(totalPrice);
    	}
    });
    $('#removeBtn').on("click", function(){
    	$.ajax({
    		"url":"/HwangDangFleamarket/cart/removeCart.go",
    		"type":"POST",
    		"data":{"memberId=":"${sessionScope.login_info.memberId}","checkBasket":getRemoveCartList},
    		"dataType":"json",
    		"beforeSend":function(){
    			if($("input:checkbox[name=checkBasket]:checked").length == 0){//선택한 상품이 없으면
    				alert("삭제할 상품을 선택해주세요.");
    				return false;
    			}else{
    				var answer = confirm("정말 삭제하시겠습니까?");
    				if(answer == false){
    					return false;
    				}
    			}
			},
			"success":function(){
				location.href="/HwangDangFleamarket/cart/cartList.go?memberId=${sessionScope.login_info.memberId}";
			},
			"error":error
    	}); 
    });
});
function getRemoveCartList(){
	var queryString = "";
	$("input:checkbox[name=checkBasket]:checked").each(function(idx){
		if(idx==$("input:checkbox[name=checkBasket]:checked").length-1){
			queryString = queryString+this.value;
			
		}else{
			queryString = queryString+this.value+",";
		}
	});
	return queryString;
}
function error(xhr, status, err)
{
	alert(status+", "+xhr.readyState+" "+err);
}
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
									<input type="checkbox" id="basketAll" checked="checked" title="장바구니 상품 전체선택">
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
				<tbody>
					<c:forEach items="${requestScope.cartList}" var="list">
						<c:forEach items="${list.productList}" var="product">
							<tr class="cartList">
								<td class="first">
									<input type="checkbox" name="checkBasket" checked="checked" title="장바구니 상품 선택" value="${list.cartNo}">
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
								<td id="price">
									${product.productPrice*list.cartProductAmount}
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
		결제 예상 금액&nbsp;&nbsp;
		<hr>
		<span id="checkedEstimatedPrice">${requestScope.sum}</span>
		<span>원&nbsp;&nbsp;</span>
	</div>
	<p>
	<span class="bottomBtn">
	<input type="button" value="선택상품삭제" id="removeBtn">&nbsp;&nbsp;
	<input type="button" value="결제정보입력">
	</span>
</div>