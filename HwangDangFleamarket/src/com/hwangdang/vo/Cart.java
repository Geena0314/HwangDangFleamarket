package com.hwangdang.vo;

import java.io.Serializable;

public class Cart implements Serializable
{
	private int cartNo;
	private int cartProductAmount;
	private String cartProductOption;
	private String productId;
	private String memberId;
	
	public Cart()
	{
		// TODO Auto-generated constructor stub
	}

	public Cart(int cartNo, int cartProductAmount, String cartProductOption, String productId, String memberId) {
		super();
		this.cartNo = cartNo;
		this.cartProductAmount = cartProductAmount;
		this.cartProductOption = cartProductOption;
		this.productId = productId;
		this.memberId = memberId;
	}

	public int getCartNo() {
		return cartNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public int getCartProductAmount() {
		return cartProductAmount;
	}

	public void setCartProductAmount(int cartProductAmount) {
		this.cartProductAmount = cartProductAmount;
	}

	public String getCartProductOption() {
		return cartProductOption;
	}

	public void setCartProductOption(String cartProductOption) {
		this.cartProductOption = cartProductOption;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cartNo;
		result = prime * result + cartProductAmount;
		result = prime * result + ((cartProductOption == null) ? 0 : cartProductOption.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cart other = (Cart) obj;
		if (cartNo != other.cartNo)
			return false;
		if (cartProductAmount != other.cartProductAmount)
			return false;
		if (cartProductOption == null) {
			if (other.cartProductOption != null)
				return false;
		} else if (!cartProductOption.equals(other.cartProductOption))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (productId == null) {
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", cartProductAmount=" + cartProductAmount + ", cartProductOption="
				+ cartProductOption + ", productId=" + productId + ", memberId=" + memberId + "]";
	}
}
