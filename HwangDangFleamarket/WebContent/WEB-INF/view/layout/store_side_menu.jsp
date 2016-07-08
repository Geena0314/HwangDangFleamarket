<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-sm-3 col-md-2 sidebar" id="sideMenu2">
	<ul class="nav nav-sidebar">
		<li class="active">
			<div class="store_imgs">
			<a href="/HwangDangFleamarket/seller/sellerStore.go?sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}"><img id="storeMainImage" src="../image_storage/${param.sellerStoreImage}"></a>
			</div>
		</li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="스토어 소개"></li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="상품 목록" onclick="window.location='/HwangDangFleamarket/product/list.go?page=1&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'"></li>
        <li><input class="btn btn-lg btn-default btn-block" type="button" value="스토어 소식" onclick="window.location='/HwangDangFleamarket/sellerNotice/sellerNotice.go?page=1&sellerStoreNo=${param.sellerStoreNo}&sellerStoreImage=${param.sellerStoreImage}'"></li>
    </ul>
</div>
