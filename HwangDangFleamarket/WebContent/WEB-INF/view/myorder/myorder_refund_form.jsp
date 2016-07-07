<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
		<script type="text/javascript">
			$(document).ready(function()
			{
				$("#submit").on("click", function()
				{
					$("#refundTitleError").empty();
					$("#refundContentError").empty();
					if($("#refundTitle").val().trim().length < 5 || $("#refundTitle").val().trim().length > 20)
					{
						$("#refundTitleError").append("제목은 5자 ~ 20자 사이로 입력해주세요.");
						$("#refundTitle").focus();
						return false;
					}
					else if($("#refundContent").val().trim().length < 10)
					{
						$("#refundContentError").append("내용은 10글자 이상으로 입력해주세요.");
						$("#refundContent").focus();
						return false;
					}
					else
						return true;
				});
			});
		</script>	
	</head>

	<body>
		<form method="POST" action="/HwangDangFleamarket/myorder/refundSuccess.go?orderSeqNo=${ param.orderSeqNo }">
			<div align="center">
				<h2>환 불 신 청</h2>
				<table>
					<tr>
						<th>신청 제목</th>
						<td colspan="2"><input type="text" name="refundTitle" size="28" id="refundTitle"></td>
					</tr>
					<tr>
						<td colspan="2" align="center" id="refundTitleError">
						</td>
					</tr>
					<tr>
						<th>신청 내용</th>
						<td colspan="2">
							<textarea name="refundContent" cols="30" rows="15" id="refundContent"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" id="refundContentError">
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input type="submit" value="등록하기" id="submit">
							<input type="button" value="취소하기" onclick="window.close();">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>