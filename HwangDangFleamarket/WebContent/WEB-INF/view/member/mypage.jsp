<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="lee" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
	/* #all
	{
		margin: 50px;
		
	}
	#sellerRegister
	{
		margin: 50px;
		float : left;
	}
	#memberEdit
	{
		margin: 50px;
		float : left;
	}
	#memberWithdrawal
	{
		margin: 50px;
		float : left;
	} */
</style>

<div class="row placeholders"  id="all">
	<lee:choose>
		<lee:when test="${ sessionScope.login_info.memberId == 'kinghwang@gmail.com' }">
			<div class="col-md-6" id="sellerRegister" >
				<a href="/HwangDangFleamarket/admin/sellerRegisterStatus.go?page=1">
					<!-- 판매자 신청 현황.(관리자) -->
					<img src="../image_storage/sellerRegisterStatus.jpg">
				</a>
			</div>
		</lee:when>
		<lee:otherwise>
			<lee:choose>
				<lee:when test="${ sessionScope.login_info.memberAssign == 0 }">
					<lee:choose>
						<lee:when test="${ sessionScope.sellerRegister == 1}">
							<div class="col-sm-4" id="sellerRegister">
								<!-- 등록신청을 했는데 결과가 없는경우. -->
								<img src="../image_storage/sellerRegisterResult.jpg">
							</div>
						</lee:when>
						<lee:otherwise>
							<div class="col-sm-4" id="sellerRegister">
								<a href="/HwangDangFleamarket/member/sellerRegister.go">
									<img src="../image_storage/sellerRegister.jpg"><!-- 등록폼으로이동. 판매자등록신청.-->
								</a>
							</div>
						</lee:otherwise>
					</lee:choose>
				</lee:when>
				<lee:otherwise>
					<div class="col-sm-4" id="sellerRegister">
						<a href="/HwangDangFleamarket/seller/salesStatus.go?page=1&sellerStoreNo=${ sessionScope.seller.sellerStoreNo }">
							<img src="../image_storage/salesStatus.jpg"><!-- 판매현황조회. -->
						</a>
					</div>
				</lee:otherwise>
			</lee:choose>
		</lee:otherwise>
	</lee:choose>
	
	<lee:choose>
		<lee:when test="${ sessionScope.login_info.memberId == 'kinghwang@gmail.com' }">
			<div class="col-md-6" id="memberEdit">
				<img src="../image_storage/memberList.jpg"><!-- 회원 목록 조회(관리자). -->
			</div>
		</lee:when>
		<lee:otherwise>
			<div class="col-sm-4" id="memberEdit">
				<img src="../image_storage/memberEdit.jpg"><!-- 회원,판매자 정보 수정. -->
			</div>
		</lee:otherwise>
	</lee:choose>
		
	<div id="memberWithdrawal">
		<lee:if test="${ sessionScope.login_info.memberId != 'kinghwang@gmail.com' }">
			<div class="col-sm-4" id="memberWithdrawal">
				<img src="../image_storage/withdrawal.jpg">
			</div>
		</lee:if>
	</div>
</div>