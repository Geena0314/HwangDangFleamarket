<%@ page contentType="text/html;charset=utf-8"%>
<script type="text/javascript" src="/HwangDangFleamarket/scripts/jquery.js"></script>
<script type="text/javascript">
var j = 1;
$(document).ready(function(){
	var idx = 1;
	$('table').on("click", '#addOptionBtn',function(){
		if(!$('.optionName')[0].value||!$('.optionSubName')[0].value||!$('.optionStock')[0].value){
			alert("필수입력사항을 입력해주세요.");
			return false;
		}else{
			if(!$("#optionName1").val()){
				$("#optionName").attr("readonly", "readonly");
				$("#optionSubName").attr("readonly", "readonly");
				$("#optionStock").attr("readonly", "readonly");
			}
			
			
			var optionSubName = $('.optionSubName');
			var optionStock = $('.optionStock');
			if(optionSubName.length != 1){
				for(var i=0; i<optionSubName.length-1; i++){
					for(var j=i+1; j<optionSubName.length; j++){
						if(!optionSubName[j].value || !optionStock[j].value){
							alert("필수 사항 입력해라")							
							return false;
						}
						else{
							if(optionSubName[i].value == optionSubName[j].value){
								alert(window.j + "처음")
								alert("세부 옵션명이 중복됩니다.");
								window.j--;
								$("#optionSubName"+window.j).removeProp("readonly");
								$("#optionStock"+window.j).removeProp("readonly");
								window.j++;
								alert(window.j);
								return false;
							}
						}
					}
					$(".optionSubName").attr("readonly", "readonly");
					$(".optionStock").attr("readonly", "readonly");
				}
			}
			$("#endOption").after('<tr><th>상품 옵션</th><td colspan="2"><input type="text" name="optionList['+idx+'].optionName" readonly="readonly" value='+$(".optionName")[0].value+' placeholder="필수 입력 사항" class="optionName"></td></tr>'
								 +'<tr><th>상품 세부 옵션</th><td colspan="2"><input type="text" name="optionList['+idx+'].optionSubName" placeholder="필수 입력 사항" class="optionSubName" id="optionSubName' + window.j + '"></td></tr>'
								 +'<tr><th>옵션별 재고</th><td colspan="2"><input type="number" name="optionList['+idx+'].optionStock" placeholder="필수 입력 사항" class="optionStock" id="optionStock' + window.j + '"></td></tr>'
								 +'<tr><th>옵션별 추가 가격</th><td colspan="2"><input type="number" name="optionList['+idx+'].optionAddPrice">&nbsp;'
								 +'<input type="button" value="옵션삭제" class="deleteOptionBtn"></td></tr>'
								 +'<tr id="endOption"><th colspan="3"><hr></th></tr>');
			idx++;
			window.j++;
			}
	});
	$("table").on("click",".deleteOptionBtn", function(){
		$(this).parent().parent().prev().remove();
		$(this).parent().parent().prev().remove();
		$(this).parent().parent().prev().remove();
		$(this).parent().parent().prev().remove();
		$(this).parent().parent().remove();
		if($('.optionSubName').length == 1){
			$("#optionName").removeProp("readonly");
			$("#optionSubName").removeProp("readonly");
			$("#optionStock").removeProp("readonly");
		}
	});
	$("#addImageBtn").on("click", function(){
		if(!$('#imgFile').val()){
			alert("사진을 등록해주세요.");
			return false;
		}
		$("#mainImg").after('<tr><th>상품 상세 사진</th><td colspan="2"><input type="file" name="images" class="imgFile">&nbsp;&nbsp;'
							+'<input type="button" value="사진삭제" class="deleteImgBtn"></td></tr>');
	});
	$("table").on("click",".deleteImgBtn",function(){
		$(this).parent().parent().remove();
	});
	$("#submit").on("click", function(){
		if(!$('#productId').val() || $('#productId').val().trim().length == 0 || $('#productId').val().trim().length > 30){
			alert("상품 ID를 30글자 이하로 입력해주세요.");
			$('#productId').focus();
			return false;
		}
		if(!$('#productName').val() || $('#productName').val().trim().length == 0 || $('#productName').val().trim().length > 10){
			alert("상품명을 10글자 이하로 입력해주세요.");
			$('#productName').focus();
			return false;
		}
		if(!$('#productPrice').val() || $('#productPrice').val().trim().length > 7){
			alert("상품가격을 입력해주세요.");
			$('#productPrice').focus();
			return false;
		}
		if(!$('.optionName')[0].value){
			alert("옵션명을 입력해주세요.");
			$('.optionName')[0].focus();
			return false;
		}
		for(var idx=0; idx<$('.optionSubName').length; idx++){
			if(!$('.optionSubName')[idx].value || !$('.optionStock')[idx].value){
				alert("옵션 세부 사항을 입력해주세요.");
				$('.optionName')[idx].focus();
				return false;
			}
		}
		if(!$('#productMainImage').val()){
			alert("상품 대표 사진을 업로드해주세요.");
			return false;
		}
		if(!$('.imgFile')[0].value){
			alert("상품 상세 사진을 업로드해주세요.");
			return false;
		}
		for(var idx=0; idx<$('.imgFile').length; idx++){
			if(!$('.imgFile')[idx].value){
				alert("상품 상세 사진을 업로드해주세요.");
				return false;
			}
		}
		if(!$('#productInfo').val()){
			alert("상품 정보를 입력해주세요.");
			$('#productInfo').focus();
			return false;
		}
	});
});
</script>
<div>
	<h2 class="page-header store_look_around">스토어 상품 등록</h2>
	<form method="POST" enctype="multipart/form-data" action="/HwangDangFleamarket/product/registerProduct.go">
		<input type="hidden" name="sellerStoreNo" value="${param.sellerStoreNo}">
		<input type="hidden" name="page" value="${param.page}">
		<input type="hidden" name="sellerStoreImage" value="${param.sellerStoreImage}">
			<table id="table">
				<tr>
					<th>상품 ID</th>
					<td colspan="2"><input type="text" name="productId" id="productId" placeholder="ID는 영어+숫자 조합 "></td>
				</tr>
				<tr>
					<th>상품명</th>
					<td colspan="2"><input type="text" name="productName" id="productName"></td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td colspan="2"><input type="number" name="productPrice" id="productPrice"></td>
				</tr>
				<tr>
					<th colspan="3"><hr></th>
				</tr>
				<tr>
					<th>상품 옵션</th>
					<td colspan="2"><input type="text" name="optionList[0].optionName" class="optionName" placeholder="필수 입력 사항" id="optionName"></td>
				</tr>
				<tr>
					<th>상품 세부 옵션</th>
					<td colspan="2"><input type="text" name="optionList[0].optionSubName" class="optionSubName" placeholder="필수 입력 사항" id="optionSubName"></td>
				</tr>
				<tr>
					<th>옵션별 재고</th>
					<td colspan="2"><input type="number" name="optionList[0].optionStock" class="optionStock" placeholder="필수 입력 사항" id="optionStock"></td>
				</tr>
				<tr>
					<th>옵션별 추가 가격</th>
					<td colspan="2">
						<input type="number" name="optionList[0].optionAddPrice">&nbsp;
						<input type="button" value="옵션추가" id="addOptionBtn">
					</td>
				</tr>
				<tr id="endOption">
					<th colspan="3"><hr></th>
				</tr>
				<tr>
					<th>상품 대표 사진</th>
					<td colspan="2"><input type="file" name="images" id="productMainImage"></td>
				</tr>
		  		<tr id="mainImg">
					<th>상품 상세 사진</th>
					<td colspan="2">
						<input type="file" name="images" class="imgFile" id="imgFile">&nbsp;
						<input type="button" value="사진추가" id="addImageBtn">
					</td>
				</tr>
				<tr>
					<th>상품 소개</th>
					<td colspan="2"><textarea id="productInfo" name="productInfo" cols="45" rows="10"></textarea></td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="등록하기" id="submit">&nbsp;&nbsp;
						<input type="reset" value="다시입력">&nbsp;&nbsp;
						<input type="button" value="등록취소" onclick="window.location='/HwangDangFleamarket/product/list.go?page=${param.page}&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'">
					</td>
				</tr>
			</table>
	</form>
</div>