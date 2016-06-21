package com.hwangdang.vo;

import java.io.Serializable;

public class Orders implements Serializable
{
	private String ordersNo;
	private String ordersReceiver;
	private String ordersPhone;
	private String ordersZipcode;
	private String ordersAddress;
	private String ordersSubAddress;
	private int ordersTotalPrice;
	private String ordersPayment;
	private String ordersRequest;
	private int paymentStatus;
	private String ordersStatus;
	private String memberId;
	
	public Orders()
	{
		// TODO Auto-generated constructor stub
	}

	public Orders(String ordersNo, String ordersReceiver, String ordersPhone, String ordersZipcode,
			String ordersAddress, String ordersSubAddress, int ordersTotalPrice, String ordersPayment,
			String ordersRequest, int paymentStatus, String ordersStatus, String memberId)
	{
		super();
		this.ordersNo = ordersNo;
		this.ordersReceiver = ordersReceiver;
		this.ordersPhone = ordersPhone;
		this.ordersZipcode = ordersZipcode;
		this.ordersAddress = ordersAddress;
		this.ordersSubAddress = ordersSubAddress;
		this.ordersTotalPrice = ordersTotalPrice;
		this.ordersPayment = ordersPayment;
		this.ordersRequest = ordersRequest;
		this.paymentStatus = paymentStatus;
		this.ordersStatus = ordersStatus;
		this.memberId = memberId;
	}

	public String getOrdersNo()
	{
		return ordersNo;
	}

	public void setOrdersNo(String ordersNo)
	{
		this.ordersNo = ordersNo;
	}

	public String getOrdersReceiver()
	{
		return ordersReceiver;
	}

	public void setOrdersReceiver(String ordersReceiver)
	{
		this.ordersReceiver = ordersReceiver;
	}

	public String getOrdersPhone()
	{
		return ordersPhone;
	}

	public void setOrdersPhone(String ordersPhone)
	{
		this.ordersPhone = ordersPhone;
	}

	public String getOrdersZipcode()
	{
		return ordersZipcode;
	}

	public void setOrdersZipcode(String ordersZipcode)
	{
		this.ordersZipcode = ordersZipcode;
	}

	public String getOrdersAddress()
	{
		return ordersAddress;
	}

	public void setOrdersAddress(String ordersAddress)
	{
		this.ordersAddress = ordersAddress;
	}

	public String getOrdersSubAddress()
	{
		return ordersSubAddress;
	}

	public void setOrdersSubAddress(String ordersSubAddress)
	{
		this.ordersSubAddress = ordersSubAddress;
	}

	public int getOrdersTotalPrice()
	{
		return ordersTotalPrice;
	}

	public void setOrdersTotalPrice(int ordersTotalPrice)
	{
		this.ordersTotalPrice = ordersTotalPrice;
	}

	public String getOrdersPayment()
	{
		return ordersPayment;
	}

	public void setOrdersPayment(String ordersPayment)
	{
		this.ordersPayment = ordersPayment;
	}

	public String getOrdersRequest()
	{
		return ordersRequest;
	}

	public void setOrdersRequest(String ordersRequest)
	{
		this.ordersRequest = ordersRequest;
	}

	public int getPaymentStatus()
	{
		return paymentStatus;
	}

	public void setPaymentStatus(int paymentStatus)
	{
		this.paymentStatus = paymentStatus;
	}

	public String getOrdersStatus()
	{
		return ordersStatus;
	}

	public void setOrdersStatus(String ordersStatus)
	{
		this.ordersStatus = ordersStatus;
	}

	public String getMemberId()
	{
		return memberId;
	}

	public void setMemberId(String memberId)
	{
		this.memberId = memberId;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((ordersAddress == null) ? 0 : ordersAddress.hashCode());
		result = prime * result + ((ordersNo == null) ? 0 : ordersNo.hashCode());
		result = prime * result + ((ordersPayment == null) ? 0 : ordersPayment.hashCode());
		result = prime * result + ((ordersPhone == null) ? 0 : ordersPhone.hashCode());
		result = prime * result + ((ordersReceiver == null) ? 0 : ordersReceiver.hashCode());
		result = prime * result + ((ordersRequest == null) ? 0 : ordersRequest.hashCode());
		result = prime * result + ((ordersStatus == null) ? 0 : ordersStatus.hashCode());
		result = prime * result + ((ordersSubAddress == null) ? 0 : ordersSubAddress.hashCode());
		result = prime * result + ordersTotalPrice;
		result = prime * result + ((ordersZipcode == null) ? 0 : ordersZipcode.hashCode());
		result = prime * result + paymentStatus;
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
		Orders other = (Orders) obj;
		if (memberId == null)
		{
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (ordersAddress == null)
		{
			if (other.ordersAddress != null)
				return false;
		} else if (!ordersAddress.equals(other.ordersAddress))
			return false;
		if (ordersNo == null)
		{
			if (other.ordersNo != null)
				return false;
		} else if (!ordersNo.equals(other.ordersNo))
			return false;
		if (ordersPayment == null)
		{
			if (other.ordersPayment != null)
				return false;
		} else if (!ordersPayment.equals(other.ordersPayment))
			return false;
		if (ordersPhone == null)
		{
			if (other.ordersPhone != null)
				return false;
		} else if (!ordersPhone.equals(other.ordersPhone))
			return false;
		if (ordersReceiver == null)
		{
			if (other.ordersReceiver != null)
				return false;
		} else if (!ordersReceiver.equals(other.ordersReceiver))
			return false;
		if (ordersRequest == null)
		{
			if (other.ordersRequest != null)
				return false;
		} else if (!ordersRequest.equals(other.ordersRequest))
			return false;
		if (ordersStatus == null)
		{
			if (other.ordersStatus != null)
				return false;
		} else if (!ordersStatus.equals(other.ordersStatus))
			return false;
		if (ordersSubAddress == null)
		{
			if (other.ordersSubAddress != null)
				return false;
		} else if (!ordersSubAddress.equals(other.ordersSubAddress))
			return false;
		if (ordersTotalPrice != other.ordersTotalPrice)
			return false;
		if (ordersZipcode == null)
		{
			if (other.ordersZipcode != null)
				return false;
		} else if (!ordersZipcode.equals(other.ordersZipcode))
			return false;
		if (paymentStatus != other.paymentStatus)
			return false;
		return true;
	}

	@Override
	public String toString()
	{
		return "Orders [ordersNo=" + ordersNo + ", ordersReceiver=" + ordersReceiver + ", ordersPhone=" + ordersPhone
				+ ", ordersZipcode=" + ordersZipcode + ", ordersAddress=" + ordersAddress + ", ordersSubAddress="
				+ ordersSubAddress + ", ordersTotalPrice=" + ordersTotalPrice + ", ordersPayment=" + ordersPayment
				+ ", ordersRequest=" + ordersRequest + ", paymentStatus=" + paymentStatus + ", ordersStatus="
				+ ordersStatus + ", memberId=" + memberId + "]";
	}
}
