 <%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link type="text/css" rel="stylesheet" href="/HwangDangFleamarket/styles/notice.css">
<style type="text/css">
table, td {
	border-top: 2px solid lightgray;
	border-bottom: 2px solid lightgray;
	border-left: none;
	border-right: none;
	text-align: center;
}
table {
	width: 100%;
}
.thead{
	background-color: whitesmoke;
}
.tfoot{
	background-color: whitesmoke;
}
td {
	border: none;
}
a {
	text-decoration: none;
	color: gray;
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
	border: 2px solid lightgray;
	text-align: right;
}
.bottomBtn{
	float: right;
}
.cartListSection{
	width: 70%;
	margin-bottom: 70px;
	position: relative;
	left: 14%;
	color: gray;
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
            	sum = sum + parseInt($(this).text().split("+")[0]) + parseInt($(this).text().split("+")[1]);
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
    	var addPrice = $(this).parents().children("#price").text();
 		var price = addPrice.split("+");
    	if(this.checked){
    		totalPrice = totalPrice + parseInt(price[0]) + parseInt(price[1]);
    		$('#checkedEstimatedPrice').append(totalPrice);
    	}else{
    		totalPrice = totalPrice - parseInt(price[0]) - parseInt(price[1]);
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
    
    
    //구입하기 버튼 : 체그된 productId , productOptionId , sellerStoreNO 
    //stock  , 
    $("#buyBtn").on("click",function(){
    	console.log(getRemoveCartList());
    	var url = "/HwangDangFleamarket/buy/buyCarts.go?cartNoList="+getRemoveCartList();
		$("form").prop("action" , url);    	
		$("form").submit();
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
<h2 class="page-header store_look_around">황당 플리마켓 장바구니</h2>
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
			<form action="" method="POST" id="cart_form">
				<tbody>
					<c:forEach items="${requestScope.cartList}" var="list">
						<c:forEach items="${list.productList}" var="product">
							<tr class="cartList">
								<td class="first"><input type="checkbox" name="checkBasket"
									checked="checked" title="장바구니 상품 선택" value="${list.cartNo}">
								</td>
								<td>
									<%-- 스토어 이름, 상품명, 선택한 옵션 --%>
									<ul>
										<li id="listBlock">
											<div class="thmb">
												<div class="storeImg">
													<a
														href="/HwangDangFleamarket/product/detail.go?page=1&productId=${product.productId}&sellerStoreNo=${product.seller.sellerStoreNo}&sellerStoreImage=${product.seller.sellerStoreImage}"><img
														src="../image_storage/${product.productMainImage}"></a>
												</div>
											</div>
											<ul class="storeInfo">
												<li><a
													href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${product.seller.sellerStoreNo}&sellerStoreImage=${product.seller.sellerStoreImage}">${product.seller.sellerStoreName}</a>
												</li><br>
												<li>
													${product.productName}/${product.productOption.optionSubName}
												</li>
											</ul>
										</li>
									</ul>
								</td>
								<td>
									<%-- 수량 --%> ${list.cartProductAmount}
								</td>
								<td id="price">
									${product.productPrice*list.cartProductAmount} <c:choose>
										<c:when test="${product.productOption.optionAddPrice != 0}">
											<p>&nbsp;+&nbsp;${list.cartProductAmount*product.productOption.optionAddPrice}
										</c:when>
										<c:otherwise>
											<p style="display: none;">+0</p>
										</c:otherwise>
									</c:choose>
								</td>
								<td id="delivery"><c:choose>
										<c:when
											test="${((product.productPrice*list.cartProductAmount)+(list.cartProductAmount*product.productOption.optionAddPrice))>= 30000}">
												무료배송
											</c:when>
										<c:otherwise>
												2500원
											</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:forEach>
				</tbody>
			</form>
		</table>
			<p>
		<div class="estimatedPrice" style="border: 2px solid lightgray;">
			결제 예상 금액 - 배송비&nbsp;&nbsp;
			<hr style="border: 1px solid lightgray;">
			<span id="checkedEstimatedPrice">${requestScope.sum}원&nbsp;&nbsp;</span> 
		</div>
		<br>
		<span class="bottomBtn"> 
			<input class="noticeBtns" type="button" value="선택상품삭제" id="removeBtn">&nbsp;&nbsp; 
			<input class="noticeBtns" type="button" value="구매하기" id="buyBtn">
		</span>
		</div>
</div>

