<%@page contentType="text/html;charset=UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		//비공개시 패스워드 객체생성 
		$("#private").click(function(){
			var pass = document.getElementById("password");
			if(pass == null){
				$("#title_layer").append("<input type='password' name='password' id='password' /> ");		
			}
		});
		
		
		// 글등록 
		$("#submitBtn").click(function(){
			var title = $("#title").val().trim();
			var content = $("textarea").val().trim();         
			var radio = $("input:radio:checked").val();
			//alert(radio);
			//검증
			if(title.length == 0){
				alert("제목은 필수입력사항 입니다.");
				return false;
			}if(content.length == 0){
				alert("문의사항은 필수입력사항 입니다.");
				return false;
			}
			
			$("#f1").prop("action","/HwangDangFleamarket/admin/register.go");
			$("#f1").submit();
		});
	});
</script>

세션아이디 : ${sessionScope.login_info.memberId }
<h2>문의사항 등록</h2>
<form method="POST" action="" id="f1">
	<input type="hidden"  name="loginId" value="${sessionScope.login_info.memberId }" />
	<div id="title_layer">
		제목 : <input type="text" name="title" id="title" size="60" /><br/><br/>
		공개여부 : 공개<input type="radio"  checked="checked" name="published"  value="t" />
		               비공개<input type="radio"  name="published" value="f" id="private" />
	</div>
	  
	<textarea rows="30" cols="50" name="content" id="content"></textarea><br/>
	<input type="button" value="문의하기" id="submitBtn">
</form>