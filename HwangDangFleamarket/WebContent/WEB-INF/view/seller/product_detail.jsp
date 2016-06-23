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
			}
			#like
			{
				height:50px;
				width:800px;
				text-align: left;
				float: left;
			}
			#reviewTable
			{
				width : 582.73px;
				min-height : 235.46px;
			}
			#QnATable
			{
				width : 582.73px;
				min-height : 235.46px;
			}
		</style>
		
		<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
		<script type="text/javascript">
			var currentPage;
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
				
				$("#paging").on("click", "a.previousPage",function()
				{
					//에이잭스 페이징 처리. 이전페이지 눌렀을 때.
					window.currentPage = parseInt($("#paging").children().first().next().text())-1;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewPaging.go",
						"type" : "POST",
						"data" : {"page" : window.currentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#reviewContent").empty();
							$("#reviewWriter").empty();
							$("#paging").empty();
							for(var i=0; i<json.review.length; i++)
							{
								$("#reviewContent").append(json.review[i].reviewNo + ". " + json.review[i].reviewContent + "<br>");
								$("#reviewWriter").append(json.review[i].reviewWriter + "<br>");
							}
							var endPage = json.bean.endPage
							for(var i=json.bean.beginPage; i<json.bean.endPage+1; i++)
							{
								if(!json.bean.page == i)
								{
									$("#paging").prepend("<a id='currentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#paging").prepend("<a class='movePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.bean.previousPageGroup)
							{
								$("#paging").prepend("◁");
							}
							else
							{
								$("#paging").prepend("<a class='previousPage'>◁</a>");
							}
							if(!json.bean.nextPageGroup)
							{
								$("#paging").append("▷");
							}
							else
							{
								$("#paging").append("<a class='nextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#paging").on("click", "a.nextPage",function()
				{
					//에이잭스 페이징 처리. 다음페이지 눌렀을 때.
					window.currentPage = parseInt($("#paging").children().last().prev().text())+1;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewPaging.go",
						"type" : "POST",
						"data" : {"page" : window.currentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#reviewContent").empty();
							$("#reviewWriter").empty();
							$("#paging").empty();
							for(var i=0; i<json.review.length; i++)
							{
								$("#reviewContent").append(json.review[i].reviewNo + ". " + json.review[i].reviewContent + "<br>");
								$("#reviewWriter").append(json.review[i].reviewWriter + "<br>");
							}
							var endPage = json.bean.endPage;
							for(var i=json.bean.beginPage; i<json.bean.endPage+1; i++)
							{
								if(!json.bean.page == i)
								{
									$("#paging").prepend("<a id='currentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#paging").prepend("<a class='movePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.bean.previousPageGroup)
							{
								$("#paging").prepend("◁");
							}
							else
							{
								$("#paging").prepend("<a class='previousPage'>◁</a>");
							}
							if(!json.bean.nextPageGroup)
							{
								$("#paging").append("▷");
							}
							else
							{
								$("#paging").append("<a class='nextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#paging").on("click", "a.movePage",function()
				{
					//에이잭스 페이징 처리. 다른페이지 눌렀을 때.
					window.currentPage = this.text;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewPaging.go",
						"type" : "POST",
						"data" : {"page" : window.currentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#reviewContent").empty();
							$("#reviewWriter").empty();
							$("#paging").empty();
							for(var i=0; i<json.review.length; i++)
							{
								$("#reviewContent").append(json.review[i].reviewNo + ". " + json.review[i].reviewContent + "<br>");
								$("#reviewWriter").append(json.review[i].reviewWriter + "<br>");
							}
							var endPage = json.bean.endPage;
							for(var i=json.bean.beginPage; i<json.bean.endPage+1; i++)
							{
								if(!json.bean.page == i)
								{
									$("#paging").prepend("<a id='currentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#paging").prepend("<a class='movePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.bean.previousPageGroup)
							{
								$("#paging").prepend("◁");
							}
							else
							{
								$("#paging").prepend("<a class='previousPage'>◁</a>");
							}
							if(!json.bean.nextPageGroup)
							{
								$("#paging").append("▷");
							}
							else
							{
								$("#paging").append("<a class='nextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#reviewWrite").on("focus", function()
				{
					//구매한 상품인지 확인. (+)memberId 세션에서 가져오기
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewWriteCheck.go",
						"type" : "POST",
						"data" : "memberId=" + "isj4216",
						"success" : function(text)
						{
							if(!text)
							{
								$("#reviewError").append("해당상품 구매자만 입력 가능합니다.");
								$("#reviewWrite").blur();
							}
						},
						"error" : error,
						"beforeSend" : function()
						{
							$("#reviewError").empty();
						}
					});
				});
				
				$("#reviewRegister").on("click", function()
				{
					//리뷰 등록하기.((+)세션에서 멤버아이디 넘겨주기.) ,,, 추천하기 기능 적용.
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewRegister.go",
						"type" : "POST",
						"data" : { "memberId" : "isj4216", "reviewContent" : $("#reviewWrite").val(), 
									 "productId" : $("#productId").text(), "productLike" : $("input:checked").val()},
						"dataType" : "JSON",
						"beforeSend" : function()
						{
							$("#reviewError").empty();
						 	if($("#reviewWrite").val() == null || $("#reviewWrite").val().trim().length < 3 ||$("#reviewWrite").val().length > 20)
							{
								$("#reviewError").append("3글자 이상, 20자 이하로 입력해주세요.");
								$("#reviewWrite").val("");
								return false;
							}
						},
						"success" : function(json)
						{
							//이미 리뷰가 등록된 경우.
							if(json.productLike == 0)
							{
								$("#reviewError").empty();
								$("#reviewError").append("이미 리뷰를 등록하셨습니다.");
								$("#reviewWrite").val("").blur();
								return false;
							}
							//리뷰 등록 후 리뷰 페이징처리...
							alert("리뷰 등록이 완료되었습니다.");
							$("#like").empty().append("추천 수 : " + json.productLike);
							$("#reviewWrite").val("");
							$("#reviewContent").empty();
							$("#reviewWriter").empty();
							$("#paging").empty();
							for(var i=0; i<json.review.length; i++)
							{
								$("#reviewContent").append(json.review[i].reviewNo + ". " + json.review[i].reviewContent + "<br>");
								$("#reviewWriter").append(json.review[i].reviewWriter + "<br>");
							}
							var endPage = json.bean.endPage;
							for(var i=json.bean.beginPage; i<json.bean.endPage+1; i++)
							{
								if(!json.bean.page == i)
								{
									$("#paging").prepend("<a id='currentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#paging").prepend("<a class='movePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.bean.previousPageGroup)
							{
								$("#paging").prepend("◁");
							}
							else
							{
								$("#paging").prepend("<a class='previousPage'>◁</a>");
							}
							if(!json.bean.nextPageGroup)
							{
								$("#paging").append("▷");
							}
							else
							{
								$("#paging").append("<a class='nextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#reviewDelete").on("click", function()
				{
					//리뷰삭제처리 에이잭스 
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewDelete.go",
						"type" : "POST",
						"data" : "memberId=isj4216&productId=" + $("#productId").text(),
						"dataType" : "JSON",
						"beforeSend" : function()
						{
							$("#reviewError").empty();
						},
						"success" : function(json)
						{
							//리뷰 삭제가 안된 경우.
							if(json.reviewDelete == 0)
							{
								$("#reviewError").append("등록된 리뷰가 없습니다.");
								return false;
							}
							//리뷰 삭제 후 리뷰 페이징처리...
							alert("리뷰 삭제가 완료되었습니다.");
							$("#reviewWrite").val("");
							$("#reviewContent").empty();
							$("#reviewWriter").empty();
							$("#paging").empty();
							for(var i=0; i<json.review.length; i++)
							{
								$("#reviewContent").append(json.review[i].reviewNo + ". " + json.review[i].reviewContent + "<br>");
								$("#reviewWriter").append(json.review[i].reviewWriter + "<br>");
							}
							var endPage = json.bean.endPage;
							for(var i=json.bean.beginPage; i<json.bean.endPage+1; i++)
							{
								if(!json.bean.page == i)
								{
									$("#paging").prepend("<a id='currentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#paging").prepend("<a class='movePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.bean.previousPageGroup)
							{
								$("#paging").prepend("◁");
							}
							else
							{
								$("#paging").prepend("<a class='previousPage'>◁</a>");
							}
							if(!json.bean.nextPageGroup)
							{
								$("#paging").append("▷");
							}
							else
							{
								$("#paging").append("<a class='nextPage'>▷</a>");
							}
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
						<tr><td>상품ID</td><td id="productId">${ requestScope.product.productId }</td></tr>
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
			<div id="like">추천 수 : ${ requestScope.product.productLike }</div>
		</div>
		<div id="info" align="center">
			<h2>상세정보 보기</h2>
			<lee:forEach items="${ requestScope.detailimage }" var="image">
				<img src="../image_storage/${ image }.jpg"  style="width:300px;height:200px;"><br>
			</lee:forEach>
		
			상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다
			상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다상세정보입니다
			<br><br><br><br><br><br><br><br><br><br>(br 위아래로 10개.)<br><br><br><br><br><br><br><br><br><br>
			
			<table id="reviewTable">
				<tr>
					<td width="400">Review</td>
					<td align="right">
						추천<input type="radio" name="productLike" value="1" checked="checked">
						비추천<input type="radio" name="productLike" value="-1">
					</td>
				</tr>
				<tr>
					<td>리뷰 내용</td>
					<td>작성자</td>
				</tr>
				<tr>
					<td id="reviewContent">
						<lee:forEach items="${ requestScope.reviewList }" var="review">
							${ review.reviewNo }. ${ review.reviewContent }<br>
						</lee:forEach>
					</td>
					<td id="reviewWriter">
						<lee:forEach items="${ requestScope.reviewList }" var="review">
							${ review.reviewWriter }<br>
						</lee:forEach>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" id="paging">
						<!-- 
							이전 페이지 그룹 처리.
							만약, 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
						-->
						<lee:choose>
							<lee:when test="${ requestScope.bean.previousPageGroup }">
								<a class="previousPage">◁</a>
							</lee:when>
							<lee:otherwise>
								<font color="#47C83E">◁</font>
							</lee:otherwise>
						</lee:choose>
						
						<!-- 
							현재 페이지가 속한 페이지 그룹내의 페이지들 링크.
							현재 페이지그룹의 시작페이지~ 끝페이지
						 -->
						 <!-- 만약 page가 현재페이지라면 링크 처리를 하지않고, 현재 페이지가 아니라면 링크처리. -->
						<lee:forEach begin="${ requestScope.bean.beginPage }" end="${ requestScope.bean.endPage }" var="page" varStatus="no">
							<lee:choose>
								<lee:when test="${ page != requestScope.bean.page }">
									<a class="movePage">${ page }</a>
								</lee:when>
								<lee:otherwise>
									<a id="currentPage" ><font color="#47C83E">${ page }</font></a>
								</lee:otherwise>
							</lee:choose>
						</lee:forEach>
						
						<!-- 
							다음 페이지 그룹 처리.
							만약, 다음페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
						-->
						<lee:choose>
							<lee:when test="${ requestScope.bean.nextPageGroup }">
								<a class="nextPage">▷</a>
							</lee:when>
							<lee:otherwise>
								<font color="#47C83E">▷</font>
							</lee:otherwise>
						</lee:choose>
					</td>
				</tr>
				<tr><td colspan="2" id="reviewError"></td></tr>
				<tr>
					<td>
						<input id="reviewWrite" type="text" placeholder="본 상품을 구매한 구매자만 입력 가능합니다.(20글자 제한)" size="65">
					</td>
					<td>
						<input type="button" id="reviewRegister" value="등록" ><input type="button" id="reviewDelete" value="내리뷰삭제" ><!-- style="width:120px;" -->
					</td>
				</tr>
			</table>
			<hr><hr>
			<table border=1 id="QnATable">
				<tr><td colspan="2" align="left">QnA</td></tr>
				<tr>
					<td>Q.문의제목.</td>
					<td>작성자</td>
				</tr>
				<tr><td width="400">제목이랑</td><td>작성자</td></tr>
				<tr><td colspan="2">페이징</td></tr>
				<tr>
					<td colspan = "2" align=""><input type="button" id="QnARegister" value="문의 하기." ></td>
				</tr>
			</table>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
	</body>
</html>