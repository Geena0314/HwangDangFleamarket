package com.hwangdang.vo;

import java.io.Serializable;

public class RefundRequest implements Serializable
{
	private String refundTitle;
	private String refundContent;
	private String ordersNo;

	public RefundRequest()
	{
		// TODO Auto-generated constructor stub
	}

	public RefundRequest(String refundTitle, String refundContent, String ordersNo)
	{
		super();
		this.refundTitle = refundTitle;
		this.refundContent = refundContent;
		this.ordersNo = ordersNo;
	}

	public String getRefundTitle()
	{
		return refundTitle;
	}

	public void setRefundTitle(String refundTitle)
	{
		this.refundTitle = refundTitle;
	}

	public String getRefundContent()
	{
		return refundContent;
	}

	public void setRefundContent(String refundContent)
	{
		this.refundContent = refundContent;
	}

	public String getOrdersNo()
	{
		return ordersNo;
	}

	public void setOrdersNo(String ordersNo)
	{
		this.ordersNo = ordersNo;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((ordersNo == null) ? 0 : ordersNo.hashCode());
		result = prime * result + ((refundContent == null) ? 0 : refundContent.hashCode());
		result = prime * result + ((refundTitle == null) ? 0 : refundTitle.hashCode());
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
		RefundRequest other = (RefundRequest) obj;
		if (ordersNo == null)
		{
			if (other.ordersNo != null)
				return false;
		} else if (!ordersNo.equals(other.ordersNo))
			return false;
		if (refundContent == null)
		{
			if (other.refundContent != null)
				return false;
		} else if (!refundContent.equals(other.refundContent))
			return false;
		if (refundTitle == null)
		{
			if (other.refundTitle != null)
				return false;
		} else if (!refundTitle.equals(other.refundTitle))
			return false;
		return true;
	}

	@Override
	public String toString()
	{
		return "RefundRequest [refundTitle=" + refundTitle + ", refundContent=" + refundContent + ", ordersNo="
				+ ordersNo + "]";
	}
}