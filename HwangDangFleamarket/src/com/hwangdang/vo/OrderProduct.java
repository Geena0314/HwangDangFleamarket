package com.hwangdang.vo;

import java.io.Serializable;

public class OrderProduct implements Serializable
{
	private int orderAmount;
	private String ordersNo;
	private String productId;
	private int optionId;
	
	public OrderProduct()
	{
		// TODO Auto-generated constructor stub
	}

	public OrderProduct(int orderAmount, String ordersNo, String productId, int optionId)
	{
		super();
		this.orderAmount = orderAmount;
		this.ordersNo = ordersNo;
		this.productId = productId;
		this.optionId = optionId;
	}

	public int getOrderAmount()
	{
		return orderAmount;
	}

	public void setOrderAmount(int orderAmount)
	{
		this.orderAmount = orderAmount;
	}

	public String getOrdersNo()
	{
		return ordersNo;
	}

	public void setOrdersNo(String ordersNo)
	{
		this.ordersNo = ordersNo;
	}

	public String getProductId()
	{
		return productId;
	}

	public void setProductId(String productId)
	{
		this.productId = productId;
	}

	public int getOptionId()
	{
		return optionId;
	}

	public void setOptionId(int optionId)
	{
		this.optionId = optionId;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + optionId;
		result = prime * result + orderAmount;
		result = prime * result + ((ordersNo == null) ? 0 : ordersNo.hashCode());
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderProduct other = (OrderProduct) obj;
		if (optionId != other.optionId)
			return false;
		if (orderAmount != other.orderAmount)
			return false;
		if (ordersNo == null)
		{
			if (other.ordersNo != null)
				return false;
		} else if (!ordersNo.equals(other.ordersNo))
			return false;
		if (productId == null)
		{
			if (other.productId != null)
				return false;
		} else if (!productId.equals(other.productId))
			return false;
		return true;
	}

	@Override
	public String toString()
	{
		return "OrderProduct [orderAmount=" + orderAmount + ", ordersNo=" + ordersNo + ", productId=" + productId
				+ ", optionId=" + optionId + "]";
	}
}
