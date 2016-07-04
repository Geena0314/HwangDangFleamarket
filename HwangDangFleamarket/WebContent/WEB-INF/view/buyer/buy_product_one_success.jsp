<%@page contentType="text/html;charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
	});

</script>


세션정보 : ${sessionScope.login_info.memberId }


${param.address } ${param.ordersReceiver }(으)로 보내실 주문이 완료 되었습니다.
저희 마켓을 이용해주셔서 감사합니다.

<input type="button" value="주문확인"  id="ordersConfirmBtn"/>

<hr/>
<h4>결제정보</h4>
입금계좌 : 신한은행 562-06559-213969 ${param.ordersReceiver } 인터넷뱅킹 바로가기

입금자명 : 박지훈
입금기한 : 2016년 07월 10일까지 입금해 주셔야 합니다.
17,800원


<h4>배송정보</h4>
받는사람 : ${param.ordersReceiver } 
배송지 : ${param.address } / ${param.phone }

<hr/>