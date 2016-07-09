<%@page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		
		//정말삭제할것인지 확인 
		$("#removeBtn").on("click",function(){
			var yesNo = confirm("정말 삭제하시겠습니까?");
			if(yesNo == false){
				return false;
			}
		});
		
		//수정폼변경할수있도록 이동
		$("#setFormMoveBtn").on("click",function(){ 
			var content = $("#content").text();
			$("#content").hide();
			$("#insertContent").text(content).show();
			$("#setFormMoveBtn").prop("hidden","true");
			$("#setContentBtn").show();
			$("#setFormMoveBtn").hide();
			
		}); 
		
		
		//요일변환을 위한 로직 
		String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
		String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
		Number.prototype.zf = function(len){return this.toString().zf(len);};
		Date.prototype.format = function(f) {
		    if (!this.valueOf()) return " ";
		 
		    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
		    var d = this;
		     
		    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		        switch ($1) {
		            case "yyyy": return d.getFullYear();
		            case "yy": return (d.getFullYear() % 1000).zf(2);
		            case "MM": return (d.getMonth() + 1).zf(2);
		            case "dd": return d.getDate().zf(2);
		            case "E": return weekName[d.getDay()];
		            case "HH": return d.getHours().zf(2);
		            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
		            case "mm": return d.getMinutes().zf(2);
		            case "ss": return d.getSeconds().zf(2);
		            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
		            default: return $1;
		        }
		    });
		};
		 
		
		
		//수정Ajax처리 
		$("#setContentBtn").on("click" , function(){ 
			
			var sendContent = $("#insertContent").val().trim();
			var contentNo = $("#contentNo").val();
			var contentPage = $("#contentPage").val();
			
			console.log("결과:" + sendContent + ", " + contentNo + ", " + contentPage);
			
			$.ajax({
				
				"beforeSend" : function(){
				
					if(sendContent.length == 0) {
						alert("글자를 반드시입력해주세요.");
						return false;
					}
				} ,
				   
				"url" : "/HwangDangFleamarket/admin/boardQnASet.go" ,
				"type" : "POST" , 
				//요청파라미터
				"data" : { "no":contentNo , "page" : contentPage , "content" :sendContent } ,
				"dataType" : "json" ,   
				"success": function(obj){
					
					$("#insertContent").hide();
					$("#content").text(obj.adminQuaContent);
					$("#content").show();
					$("#writeDate").text(new Date(obj.adminQnaDate).format("yyyy년MM월dd일"));
					$("#setContentBtn").hide();
					$("#setFormMoveBtn").show();
					
					
				} ,
				"error" :function(xhr ,status, httpErrorMsg){
					alert("요청실패 : " + httpErrorMsg );
				}
								
			}); //ajax
			
			
		});
		
		$("#submit").on("click",function(){
			var adminTx =$("#replyTa").val().trim();
			
			if(adminTx.length == 0){
				alert("댓글을 입력하세요.");
				return false;
			}
			
			
		});
		
		
		// 댓글 등록 
		$("#addReplyBtn").on("click",function(){  
			$("#myform").prop("action" , "/HwangDangFleamarket/admin/addBoardQnAReply.go?contentNo=${param.no}&contentPage=${param.page}");
			$("#myform").submit();
		});
		
		//댓글 수정 
		$("#setReplyBtn").on("click",function(){
			$("#myform").prop("action" , "/HwangDangFleamarket/admin/setBoardQnAReply.go?contentNo=${param.no}&contentPage=${param.page}");
			$("#myform").submit();
			
		});
		
		//댓글삭제
		$("#removeReplyBtn").on("click",function(){
			$("#myform").prop("action" , "/HwangDangFleamarket/admin/removeBoardQnAReply.go?contentNo=${param.no}&contentPage=${param.page}");
			$("#myform").submit();
			
		});
		
		
	}); //document
	
</script>
<style type="text/css">
section{
	width:700px;
	border:1px solid gray;
}
#title{
font-weight: bold;
border-bottom: 1px solid gray;
padding: 10px;
}
#info{
	font-size: 13px;
	border-bottom: 1px dotted gray;
	padding-top: 15px;
	padding-right: 5px;
	padding-bottom: 10px;
	text-align: right;
}
#content{
	min-height:300px; /*최소 높이 300px*/
	height:auto;/*자동으로 늘어나기*/
	padding: 10px;
}
</style>
<div class="table-responsive adminNotice">
<h3>세부조회</h3>
	<form method="POST" action="#" id="myform">
		<%-- <input type="hidden" id="contentPage" name="contentPage" value="${requestScope.page }" />
		<input type="hidden" id= "contentNo" name ="contentNo" value="${param.no }" /> --%>
	<section>
		<header>
			<div id="title">${requestScope.findQnA.adminQnaTitle }</div>
			<div id="info"><span id="writeDate">작성일 : <fmt:formatDate value="${requestScope.findQnA.adminQnaDate }"
			 pattern="yyyy년MM월dd일"/></span> | 조회수 : ${requestScope.findQnA.adminQnaHit } | 작성자 : ${requestScope.findQnA.adminQnaWriter } | 공개여부 : ${requestScope.findQnA.adminQnaPublished }</div>
		</header>
		
		
		<textarea id="insertContent" rows="30" cols="75" hidden="true" ></textarea>
		<article id="content">${requestScope.findQnA.adminQuaContent }</article>
		<br/>
	
		<!-- 작성자만 수정 삭제가능  -->
		<c:if test="${sessionScope.login_info.memberId == requestScope.findQnA.adminQnaWriter   }">
			<a id="setContentBtn" href="#" hidden="true">수정하기 / </a>
			<a id="setFormMoveBtn" href="#">수정폼이동 / </a>&nbsp;&nbsp;&nbsp;
			<a id="removeBtn" href="/HwangDangFleamarket/admin/boardQnARemove.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">삭제하기 / </a>
			<!--  
			<a href="/HwangDangFleamarket/admin/boardQnASet.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">수정하기</a>&nbsp;&nbsp;&nbsp;
			<a href="/HwangDangFleamarket/admin/boardQnARemove.go?no=${requestScope.findQnA.adminQnaNo}&page=${param.page}">삭제하기</a><br/>
			-->
		</c:if>
				<a href="/HwangDangFleamarket/admin/boardQnAList.go?page=${param.page }"> 목록보기</a><br/>
			<div>
				댓글번호 :${requestScope.findQnA.reply.adminReplyNo }
				<input type="hidden" name="replyNo" value="${requestScope.findQnA.reply.adminReplyNo }">
				댓글작성일 : <fmt:formatDate value="${requestScope.findQnA.reply.adminReplyDate }" pattern="yyyy년MM월dd일"/> 
				작성자 : 관리자  <br/>
				<c:if test="${sessionScope.login_info.memberId != 'admin@admin.com'  }">답변 : <p id="response">${requestScope.findQnA.reply.adminReplyContent }</p>
				</c:if>
			</div>
			  
		<!-- 관리자일경우만 댓글달기 가능  -->
		<c:if test="${sessionScope.login_info.memberId == 'admin@admin.com' }">
 				<textarea rows="15" cols="55" name="replyTa" id="replyTa">${requestScope.findQnA.reply.adminReplyContent }</textarea><br/>
			<c:choose>
				<c:when test="${requestScope.findQnA.reply.adminReplyNo  !=  null}">
				<input type="button" class="btn btn-default" value="댓글수정" id="setReplyBtn"  />
				<input type="button" class="btn btn-default" value="댓글삭제" id="removeReplyBtn"  />
				</c:when>
				<c:otherwise>
					<input type="button" class="btn btn-default" value="댓글등록" id="addReplyBtn" />
				</c:otherwise>
			</c:choose>			
		</c:if>  
			
	</section>
	</form>  
</div>
	<p>  
  

	