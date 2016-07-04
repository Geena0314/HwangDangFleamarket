<%@page contentType="text/html;charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
	});

</script>


세션정보 : ${sessionScope.login_info.memberId }



<hr/>
<h4>주문정보</h4>
주문번호 : ${requestScope.orders.ordersNo } <br/>  
주문한 상품명 : ${requestScope.product.productName }  <br/>
옵션정보 : 

<h2> ${requestScope.orders.ordersAddress } ${requestScope.orders.ordersSubAddress } </h2> <font size="9px" color="lightgray">(으)로 보내실 주문이 완료 되었습니다.
저희 마켓을 이용해주셔서 감사합니다.</font>


<hr/>
<h4>결제정보</h4>
                 카드사 + 카드번호  *** 
	         계좌이체한 은행명  + 계좌번호     ***
                 무통장입금 : 입금할 은행명 및 계좌번호 
         
결제한 금액  또는 결제할 금액!!


<h4>배송정보</h4>
받는사람 : <%-- ${requestScope.orders.receiver } --%>
배송지 : ${requestScope.orders.ordersAddress } ${requestScope.orders.ordersSubAddress } / ${requestScope.orders.ordersPhone }

<hr/>