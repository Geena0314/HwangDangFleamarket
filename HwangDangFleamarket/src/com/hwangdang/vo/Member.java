package com.hwangdang.vo;

import java.io.Serializable;

public class Member implements Serializable
{
	private String memberId;
	private String memberPassword;
	private String memberName;
	private String memberPhone;
	private String memberZipcode;
	private String memberAddress;
	private String memberSubAddress;
	private int memberAssign;
	
	
	public Member()
	{
		// TODO Auto-generated constructor stub
	}

	public Member(String memberId, String memberPassword, String memberName, String memberPhone, String memberZipcode,
			String memberAddress, String memberSubAddress, int memberAssign)
	{
		super();
		this.memberId = memberId;
		this.memberPassword = memberPassword;
		this.memberName = memberName;
		this.memberPhone = memberPhone;
		this.memberZipcode = memberZipcode;
		this.memberAddress = memberAddress;
		this.memberSubAddress = memberSubAddress;
		this.memberAssign = memberAssign;
	}

	public String getMemberId()
	{
		return memberId;
	}

	public void setMemberId(String memberId)
	{
		this.memberId = memberId;
	}

	public String getMemberPassword()
	{
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword)
	{
		this.memberPassword = memberPassword;
	}

	public String getMemberName()
	{
		return memberName;
	}

	public void setMemberName(String memberName)
	{
		this.memberName = memberName;
	}

	public String getMemberPhone()
	{
		return memberPhone;
	}

	public void setMemberPhone(String memberPhone)
	{
		this.memberPhone = memberPhone;
	}

	public String getMemberZipcode()
	{
		return memberZipcode;
	}

	public void setMemberZipcode(String memberZipcode)
	{
		this.memberZipcode = memberZipcode;
	}

	public String getMemberAddress()
	{
		return memberAddress;
	}

	public void setMemberAddress(String memberAddress)
	{
		this.memberAddress = memberAddress;
	}

	public String getmemberSubAddress()
	{
		return memberSubAddress;
	}

	public void setmemberSubAddress(String memberSubAddress)
	{
		this.memberSubAddress = memberSubAddress;
	}

	public int getMemberAssign()
	{
		return memberAssign;
	}

	public void setMemberAssign(int memberAssign)
	{
		this.memberAssign = memberAssign;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memberAddress == null) ? 0 : memberAddress.hashCode());
		result = prime * result + memberAssign;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((memberName == null) ? 0 : memberName.hashCode());
		result = prime * result + ((memberPassword == null) ? 0 : memberPassword.hashCode());
		result = prime * result + ((memberPhone == null) ? 0 : memberPhone.hashCode());
		result = prime * result + ((memberSubAddress == null) ? 0 : memberSubAddress.hashCode());
		result = prime * result + ((memberZipcode == null) ? 0 : memberZipcode.hashCode());
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
		Member other = (Member) obj;
		if (memberAddress == null)
		{
			if (other.memberAddress != null)
				return false;
		} else if (!memberAddress.equals(other.memberAddress))
			return false;
		if (memberAssign != other.memberAssign)
			return false;
		if (memberId == null)
		{
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (memberName == null)
		{
			if (other.memberName != null)
				return false;
		} else if (!memberName.equals(other.memberName))
			return false;
		if (memberPassword == null)
		{
			if (other.memberPassword != null)
				return false;
		} else if (!memberPassword.equals(other.memberPassword))
			return false;
		if (memberPhone == null)
		{
			if (other.memberPhone != null)
				return false;
		} else if (!memberPhone.equals(other.memberPhone))
			return false;
		if (memberSubAddress == null)
		{
			if (other.memberSubAddress != null)
				return false;
		} else if (!memberSubAddress.equals(other.memberSubAddress))
			return false;
		if (memberZipcode == null)
		{
			if (other.memberZipcode != null)
				return false;
		} else if (!memberZipcode.equals(other.memberZipcode))
			return false;
		return true;
	}

	@Override
	public String toString()
	{
		return "Member [memberId=" + memberId + ", memberPassword=" + memberPassword + ", memberName=" + memberName
				+ ", memberPhone=" + memberPhone + ", memberZipcode=" + memberZipcode + ", memberAddress="
				+ memberAddress + ", memberSubAddress=" + memberSubAddress + ", memberAssign=" + memberAssign + "]";
	}
}