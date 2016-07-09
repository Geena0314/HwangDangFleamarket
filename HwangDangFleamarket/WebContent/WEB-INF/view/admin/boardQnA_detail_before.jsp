<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("#submintBtn").on("click" ,function(){
			
			/*
			 게시판글 비밀번호 체킹 ajax않하는걸로함 
			$.ajax({
				"type" : "POST" ,
				"url" : "" ,
				"data" : "no="
			}); */
			
			
			var inputPass = $("#password").val();
			var originPass = $("#originalPassword").val();
			console.log("인풋패스워드 : " +inputPass +",originPass : " + originPass );
			
			if(inputPass != originPass){
				//게시판 설정한 비밀번호 틀림 
				alert("비밀번호가 틀립니다. 다시 입력해주세요");
				return false;
			}else{
				//비밀번호맞음 세부페이지로 이동 
				$("form").prop("action" , 
				"/HwangDangFleamarket/admin/boardQnADetail.go?no=${param.no}&page=${param.page}");
				$("form").submit();
			}
			
		});
	});
	
</script>


패스워드 : ${requestScope.password}


<input type="hidden" value="${requestScope.password}" id="originalPassword" />

<h2 class="page-header store_look_around">황당플리마켓 Q&A</h2>
<form method="POST" action="">
	게시판 비밀번호 입력(4자리)  : <input type="password" name="password" id="password" />
	<c:if test="${requestScope.errorMsg != null }">
		에러메시지 : ${requestScope.errorMsg }
	</c:if>
	<input type="button" value="확인" id="submintBtn" />
</form>

