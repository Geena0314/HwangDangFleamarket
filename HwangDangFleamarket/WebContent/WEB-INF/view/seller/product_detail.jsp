<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="lee"  uri="http://java.sun.com/jsp/jstl/core"%>
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
			#qnaTable
			{
				width : 582.73px;
				min-height : 235.46px;
			}
		</style>
		
		<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
		<script type="text/javascript">
			var currentPage;
			var qnaCurrentPage;
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
							$("#optionAddPrice").empty().append("원");
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
					if(!'${sessionScope.login_info.memberId}')
					{
						$("#reviewError").empty();
						$("#reviewError").append("로그인 한 회원만 입력 가능합니다.");
						$("#reviewWrite").blur();	
						return false;
					}
					//구매한 상품인지 확인. (+)memberId 세션에서 가져오기
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/reviewWriteCheck.go",
						"type" : "POST",
						"data" : "memberId=" + "xx",
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
						"data" : { "memberId" : "xx", "reviewContent" : $("#reviewWrite").val(), 
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
						"data" : "memberId=xx&productId=" + $("#productId").text(),
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
						"error" : function()
						{
							$("#reviewError").append("로그인한 회원만 가능합니다.");
						}
					});
				});
				//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
				$("#qnaPaging").on("click", "a.qnaPreviousPage",function()
				{
					//에이잭스 페이징 처리. 이전페이지 눌렀을 때.
					window.qnaCurrentPage = parseInt($("#qnaPaging").children().first().next().text())-1;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/qnaPaging.go",
						"type" : "POST",
						"data" : {"page" : window.qnaCurrentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#qnaContent").remove();
							$(".qnaTrs").remove();
							$("#qnaPaging").empty();
							for(var i=0; i<json.qna.length; i++)
							{
								$("#qnaTr").before("<tr align='center' class='qnaTrs' id=" + json.qna[i].storeQnANo 
										+"><td width='30'>"+ json.qna[i].storeQnANo 
										+ "</td><td align='center'>" + json.qna[i].storeQnATitle + "</td><td align='center'>" 
										+ json.qna[i].storeQnAWriter + "</td>");
							}
							var endPage = json.qnaBean.endPage
							for(var i=json.qnaBean.beginPage; i<json.qnaBean.endPage+1; i++)
							{
								if(!json.qnaBean.page == i)
								{
									$("#qnaPaging").prepend("<a id='qnaCurrentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#qnaPaging").prepend("<a class='qnaMovePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.qnaBean.previousPageGroup)
							{
								$("#qnaPaging").prepend("◁");
							}
							else
							{
								$("#qnaPaging").prepend("<a class='qnaPreviousPage'>◁</a>");
							}
							if(!json.qnaBean.nextPageGroup)
							{
								$("#qnaPaging").append("▷");
							}
							else
							{
								$("#qnaPaging").append("<a class='qnaNextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#qnaPaging").on("click", "a.qnaNextPage",function()
				{
					//에이잭스 페이징 처리. 다음페이지 눌렀을 때.
					window.qnaCurrentPage = parseInt($("#qnaPaging").children().last().prev().text())+1;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/qnaPaging.go",
						"type" : "POST",
						"data" : {"page" : window.qnaCurrentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#qnaContent").remove();
							$(".qnaTrs").remove();
							$("#qnaPaging").empty();
							for(var i=0; i<json.qna.length; i++)
							{
								$("#qnaTr").before("<tr align='center' class='qnaTrs' id=" + json.qna[i].storeQnANo 
										+"><td width='30'>"+ json.qna[i].storeQnANo 
										+ "</td><td align='center'>" + json.qna[i].storeQnATitle + "</td><td align='center'>" 
										+ json.qna[i].storeQnAWriter + "</td>");
							}
							var endPage = json.qnaBean.endPage;
							for(var i=json.qnaBean.beginPage; i<json.qnaBean.endPage+1; i++)
							{
								if(!json.qnaBean.page == i)
								{
									$("#qnaPaging").prepend("<a id='qnaCurrentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#qnaPaging").prepend("<a class='qnaMovePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.qnaBean.previousPageGroup)
							{
								$("#qnaPaging").prepend("◁");
							}
							else
							{
								$("#qnaPaging").prepend("<a class='qnaPreviousPage'>◁</a>");
							}
							if(!json.qnaBean.nextPageGroup)
							{
								$("#qnaPaging").append("▷");
							}
							else
							{
								$("#qnaPaging").append("<a class='qnaNextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				$("#qnaPaging").on("click", "a.qnaMovePage",function()
				{
					//에이잭스 페이징 처리. 다른페이지 눌렀을 때.
					window.qnaCurrentPage = this.text;
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/qnaPaging.go",
						"type" : "POST",
						"data" : {"page" : window.qnaCurrentPage, "productId" : $("#productId").text()},
						"dataType" : "JSON",
						"success" : function(json)
						{
							$("#qnaContent").remove();
							$(".qnaTrs").remove();
							$("#qnaPaging").empty();
							for(var i=0; i<json.qna.length; i++)
							{
								$("#qnaTr").before("<tr align='center' class='qnaTrs' id=" + json.qna[i].storeQnANo 
										+"><td width='30'>"+ json.qna[i].storeQnANo 
										+ "</td><td align='center'>" + json.qna[i].storeQnATitle + "</td><td align='center'>" 
										+ json.qna[i].storeQnAWriter + "</td>");
							}
							var endPage = json.qnaBean.endPage;
							for(var i=json.qnaBean.beginPage; i<json.qnaBean.endPage+1; i++)
							{
								if(!json.qnaBean.page == i)
								{
									$("#qnaPaging").prepend("<a id='qnaCurrentPage'>" + endPage + "</a>");
									endPage--;
								}
								else
								{
									$("#qnaPaging").prepend("<a class='qnaMovePage'>" + endPage + "</a>");
									endPage--;
								}
							}
							if(!json.qnaBean.previousPageGroup)
							{
								$("#qnaPaging").prepend("◁");
							}
							else
							{
								$("#qnaPaging").prepend("<a class='qnaPreviousPage'>◁</a>");
							}
							if(!json.qnaBean.nextPageGroup)
							{
								$("#qnaPaging").append("▷");
							}
							else
							{
								$("#qnaPaging").append("<a class='qnaNextPage'>▷</a>");
							}
						},
						"error" : error
					});
				});
				
				//문의 클릭했을 경우.
				$("#qnaTable").on("click", "tr.qnaTrs", function()
				{
					$("#qnaTable tr").css("background-color", "white");
					$(this).css("background-color", "#FFFED7");
					var no = $(this).children().first().text();
					$.ajax(
					{
						"url" : "/HwangDangFleamarket/product/qnaShow.go",
						"type" : "POST",
						"data" : {"storeQnANo" : no, "sellerStoreNo" : '${param.sellerStoreNo}'},
						"dataType" : "JSON",
						"beforeSend" : function()
						{
							$("#qnaContent").remove();
						},
						"success" : function(json)
						{
							if(json.storeQnAPublished == 3)
							{
								//비공개인 경우.
								$("#"+no).after("<tr id='qnaContent'><td></td><td colspan='2'>비공개 문의 입니다.</td></tr>");
								return false;
							}
							else
							{
								//공개인 경우.
								if(!json.storeQnAReply)
								{
									//댓글이 달려있지 않은 경우.
									var content = json.storeQnAContent;
									for(var i = 0; i < content.length; i++)
									{
										content = content.replace(">", "&gt;");
										content = content.replace("<", "&lt;");
									}
									for(var i = 0; i < content.length; i++)
									{
										content = content.replace("\n", "<br>");
										content = content.replace(" ", "&nbsp;");
									}
									$("#"+no).after("<tr id='qnaContent'><td></td><td colspan='2'>문의 내용 : " + content 
											+  "<br><br><input type='text' id='qnaReply' size='65'><input type='button' id='qnaReplyRegister' value='답변하기.'></td></tr>");
									//답변하기 버튼클릭.
									$("#qnaReplyRegister").on("click", function()
									{
										$.ajax(
										{
											"url" : "/HwangDangFleamarket/product/qnaReplyRegister.go",
											"type" : "POST",
											"data" : {"sellerStoreNo" : '${param.sellerStoreNo}', "storeReplyContent" : $("#qnaReply").val(), "storeQnANo" : no},
											"dataType" : "JSON",
											"beforeSend" : function()
											{
												if($("#qnaReply").val() == null || $("#qnaReply").val().trim().length < 3)
												{
													$("#qnaReply").val("3글자 이상 입력해 주세요.").focus();
													return false;
												}
											},
											"success" : function(jsons)
											{
												var content = jsons.storeQnAContent;
												for(var i = 0; i < content.length; i++)
												{
													content = content.replace(">", "&gt;");
													content = content.replace("<", "&lt;");
												}
												for(var i = 0; i < content.length; i++)
												{
													content = content.replace("\n", "<br>");
													content = content.replace(" ", "&nbsp;");
												}
												var replyContent = jsons.storeQnAReply.storeReplyContent;
												for(var i = 0; i < replyContent.length; i++)
												{
													replyContent = replyContent.replace(">", "&gt;");
													replyContent = replyContent.replace("<", "&lt;");
												}
												for(var i = 0; i < replyContent.length; i++)
												{
													replyContent = replyContent.replace("\n", "<br>");
													replyContent = replyContent.replace(" ", "&nbsp;");
												}
												alert("문의답변이 완료되었습니다.");
												$("#qnaContent").empty();
												$("#qnaContent").append("<td></td><td>문의 내용 : " + content 
														+  "<br><hr>문의 답변 : " + replyContent + "</td>"
														+ "<td align='center'><input type='button' id='qnaReplyRemove' value='삭제하기'></td>");
												return false;
											},
											"error" : function()
											{
												$("#qnaReply").val("해당상품 판매자만 입력 가능합니다.").blur();
											}
										});
									});
								}
								else
								{
									//댓글 달려있는 경우.
									var content = json.storeQnAContent;
									var replyContent = json.storeQnAReply.storeReplyContent;
									for(var i = 0; i < content.length; i++)
									{
										replyContent = replyContent.replace(">", "&gt;");
										replyContent = replyContent.replace("<", "&lt;");
									}
									for(var i = 0; i < content.length; i++)
									{
										content = content.replace("\n", "<br>");
										content = content.replace(" ", "&nbsp;");
									}
									for(var i = 0; i < replyContent.length; i++)
									{
										replyContent = replyContent.replace(">", "&gt;");
										replyContent = replyContent.replace("<", "&lt;");
									}
									for(var i = 0; i < replyContent.length; i++)
									{
										replyContent = replyContent.replace("\n", "<br>");
										replyContent = replyContent.replace(" ", "&nbsp;");
									}
									$("#"+no).after("<tr id='qnaContent'><td></td><td>문의 내용 : " + content 
											+  "<br><hr>문의 답변 : " + replyContent + "</td><td align='center'><input type='button' id='qnaRemove' value='삭제하기'></td></tr>");
									$("#qnaRemove").on("click", function()
									{
										$.ajax(
										{
											//삭제하기 버튼 클릭시...
											"url" : "/HwangDangFleamarket/storeQnA/storeQnARemove.go",
											"type" : "POST",
											"data" : {"sellerStoreNo" : '${param.sellerStoreNo}', "storeQnANo" : no, "memberId" : "xx", "productId" : $("#productId").text()},
											"dataType" : "JSON",
											"beforeSend" : function()
											{
												$("#qnaError").empty();
											},
											"success" : function(json)
											{
												if(json.result != null)
													alert("삭제가 완료되었습니다.");
												else
												{
													$("#qnaError").append("작성자와 판매자만 삭제 가능합니다.");
													return false;
												}
												$("#qnaContent").remove();
												$(".qnaTrs").remove();
												$("#qnaPaging").empty();
												for(var i=0; i<json.qna.length; i++)
												{
													$("#qnaTr").before("<tr align='center' class='qnaTrs' id=" + json.qna[i].storeQnANo 
															+"><td width='30'>"+ json.qna[i].storeQnANo 
															+ "</td><td align='center'>" + json.qna[i].storeQnATitle + "</td><td align='center'>" 
															+ json.qna[i].storeQnAWriter + "</td>");
												}
												var endPage = json.qnaBean.endPage;
												for(var i=json.qnaBean.beginPage; i<json.qnaBean.endPage+1; i++)
												{
													if(!json.qnaBean.page == i)
													{
														$("#qnaPaging").prepend("<a id='qnaCurrentPage'>" + endPage + "</a>");
														endPage--;
													}
													else
													{
														$("#qnaPaging").prepend("<a class='qnaMovePage'>" + endPage + "</a>");
														endPage--;
													}
												}
												if(!json.qnaBean.previousPageGroup)
												{
													$("#qnaPaging").prepend("◁");
												}
												else
												{
													$("#qnaPaging").prepend("<a class='qnaPreviousPage'>◁</a>");
												}
												if(!json.qnaBean.nextPageGroup)
												{
													$("#qnaPaging").append("▷");
												}
												else
												{
													$("#qnaPaging").append("<a class='qnaNextPage'>▷</a>");
												}
											},
											"error" : function()
											{
												$("#qnaError").append("로그인이 필요한 서비스입니다.");
											}
										});
									});
								}
							}
						},
						"error" : function()
						{
							$("#"+no).after("<tr id='qnaContent'><td></td><td colspan='2'>로그인이 필요합니다.</td></tr>");
						}
					});
				});
				$("#cartBtn").on("click", function(){
					if(!'${sessionScope.login_info.memberId}')
					{
						var result = confirm("로그인이 필요한 서비스입니다.\n로그인하시겠습니까?");
						if(result){
							return window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');
						}else{
							return false;
						}
					}
					$.ajax({
						"url":"/HwangDangFleamarket/cart/addCart.go",
						"type":"POST",
						"data":{"page": 1,"productName": $("#productName").val(),"productPrice": $("#productPrice").val(),
								"cartProductOption": $("#optionName").selected,"cartProductAmount": $("#optionStock").selected,
								"memberId":"${sessionScope.login_info.memberId}"},
						"dataType":"json",
						"success":function(){
							
						},
						"error":function(){
							
						},
						"beforeSend":function(){
							if(!$("#optionName").selected){
								alert("옵션을 선택해주세요.");
								return false;
							}
							if(!$("#optionStock").selected){
								alert("수량을 선택해주세요.");
								return false;
							}
						}
					});
				});
			});
			
			function error(xhr, status, err)
			{
				alert(status+", "+xhr.readyState+" "+err);
			}
		</script>
		
		<div id="main" align="center">
			<h2>상품 상세 정보 보기</h2>
			<div id="mainImage">
				<img src="../image_storage/${ requestScope.product.productMainImage }"  style="width:300px;height:200px;">
			</div>
			<div id="table">
				<form method="POST" action="#">
					<table>
						<tr><td>상품ID</td><td id="productId">${ requestScope.product.productId }</td></tr>
						<tr>
							<td>상품명</td>
							<td id="prductName">${ requestScope.product.productName }</td>
						</tr>
						<tr>
							<td>가격</td>
							<td id="productPrice">${ requestScope.product.productPrice }원</td>
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
									<option>수량선택</option>
								</select>
							</td>
						</tr>
						<tr><td colspan="2" id="optionStockError"></td></tr>
						<tr>
							<td>추가가격</td>
							<td id="optionAddPrice">
								원
							</td>
						</tr>
						<tr>
							<td><input type="submit" value="바로구매"></td>
							<td><input type="button" value="장바구니담기" id="cartBtn"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="button" value="리스트로 돌아가기" onclick="window.location='/HwangDangFleamarket/product/list.go?page=${param.page}&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${ param.sellerStoreImage }'"></td>
						</tr>
					</table>
				</form>
			</div>
			<div id="like">추천 수 : ${ requestScope.product.productLike }</div>
		</div>
		<div id="info" align="center">
			<h2>상세정보 보기</h2>
			<lee:forEach items="${ requestScope.detailimage }" var="image">
				<img src="../image_storage/${ image }"  style="width:300px;height:200px;"><br>
			</lee:forEach>
			
			${ requestScope.product.productInfo }<br>
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
			<table id="qnaTable">
				<tr><td colspan="3" align="center">QnA</td></tr>
				<tr>
					<td width="30"></td><td width="410" align="center">Q.문의제목.</td>
					<td align="center">작성자</td>
				</tr>
				
				<lee:forEach items="${ requestScope.qnaMap.qna }" var="qna">
					<tr align="center" class="qnaTrs" id="${ qna.storeQnANo }"><td width="30">${ qna.storeQnANo }</td><td align="center"> ${ qna.storeQnATitle }</td><td align="center">${qna.storeQnAWriter}</td>
				</lee:forEach>
				
				<tr id="qnaTr">
					<td></td><td align="center" id="qnaPaging">
						<!-- 
							이전 페이지 그룹 처리.
							만약, 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
						-->
						<lee:choose>
							<lee:when test="${ requestScope.qnaMap.qnaBean.previousPageGroup }">
								<a class="qnaPreviousPage">◁</a>
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
						<lee:forEach begin="${ requestScope.qnaMap.qnaBean.beginPage }" end="${ requestScope.qnaMap.qnaBean.endPage }" var="page" varStatus="no">
							<lee:choose>
								<lee:when test="${ page != requestScope.qnaMap.qnaBean.page }">
									<a class="qnaMovePage">${ page }</a>
								</lee:when>
								<lee:otherwise>
									<a id="qnaCurrentPage" ><font color="#47C83E">${ page }</font></a>
								</lee:otherwise>
							</lee:choose>
						</lee:forEach>
						
						<!-- 
							다음 페이지 그룹 처리.
							만약, 다음페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리. 
						-->
						<lee:choose>
							<lee:when test="${ requestScope.qnaMap.qnaBean.nextPageGroup }">
								<a class="qnaNextPage">▷</a>
							</lee:when>
							<lee:otherwise>
								<font color="#47C83E">▷</font>
							</lee:otherwise>
						</lee:choose>
					</td><td></td>
				</tr>
				<tr><td colspan="2" id="qnaError"></td></tr>
				<tr>
					<td colspan = "3" align="right"><input type="button" id="qnaRegister" value="문의 하기." onClick="if(${empty sessionScope.login_info.memberId }){if(confirm('로그인이 필요한 서비스입니다. \n로그인 하시겠습니까?')){window.open('/HwangDangFleamarket/member/login.go', '로그인창', 'resizable=no scrollbars=yes width=500 height=400 left=500 top=200');}}else{window.open('/HwangDangFleamarket/storeQnA/storeQnARegisterForm.go?productId=${param.productId}&memberId=${ sessionScope.login_info.memberId }','문의하기','resizable=no width=600 height=600');};"></td>
				</tr>
			</table>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		</div>
