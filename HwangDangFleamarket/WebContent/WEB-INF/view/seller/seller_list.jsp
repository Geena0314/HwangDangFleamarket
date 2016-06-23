<%@ page contentType="text/html;charset=utf-8"%>
<style type="text/css">
seller_listing{
	display: block;
	margin-top:7px;
	padding:5px 15px 20px;
	border-top:1px solid #ccc;
	background:#f1f1f2;
}
ul, il{
	list-style: none;
}
seller_listing > ul > il{
	position: relative;
	height: 140px;
	margin-top: 10px;
	padding: 20px 0 20px 20px;
	border-bottom: 1px solid #cdcdce;
	background: #fff;
}
</style>
<div class="listing_wrap">
	<div class="seller_listing">
		<ul>
			<li class="" id="thisClick">
				<strong id="box_title"></strong>
				<div title="파일명 받아와"></div>
				<div class="photo_wrap" id="storeImg">
					<a href="#"></a>
				</div>
				<div class="store_info">
					<div class="store_name">
						<a href="#">스토어 이름 받아오기</a>
					</div>
					<div class="store_intro">
						<span>스토어 소개글 받아오기</span>
					</div>
					<div class="reccomend">
						<span>★ 추천수 받아오기</span>
					</div>
				</div>
				<div class="sell_product_info">
					<div>
						<span>판매물품 받아오기</span>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>