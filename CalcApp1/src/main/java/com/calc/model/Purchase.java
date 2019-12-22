package com.calc.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Purchase")
public class Purchase {
	
	@Id
	@Column(name = "PCODE", nullable = false)
	private String productCode;
	
	@Column(name = "TRANS_DATE", nullable = false)
	private Date transDate;
	
	@Column(name = "PURCHASE_AMOUNT", nullable = false)
	private double purchaseAmount;

	public Purchase()
	{
		
	}
	
	

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public Date getTransDate() {
		return transDate;
	}

	public void setTransDate(Date transDate) {
		this.transDate = transDate;
	}

	public double getPurchaseAmount() {
		return purchaseAmount;
	}

	public void setPurchaseAmount(double purchaseAmount) {
		this.purchaseAmount = purchaseAmount;
	}



	public Purchase(String productCode, Date transDate, double purchaseAmount) {
		super();
		this.productCode = productCode;
		this.transDate = transDate;
		this.purchaseAmount = purchaseAmount;
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((productCode == null) ? 0 : productCode.hashCode());
		long temp;
		temp = Double.doubleToLongBits(purchaseAmount);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((transDate == null) ? 0 : transDate.hashCode());
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
		Purchase other = (Purchase) obj;
		if (productCode == null) {
			if (other.productCode != null)
				return false;
		} else if (!productCode.equals(other.productCode))
			return false;
		if (Double.doubleToLongBits(purchaseAmount) != Double.doubleToLongBits(other.purchaseAmount))
			return false;
		if (transDate == null) {
			if (other.transDate != null)
				return false;
		} else if (!transDate.equals(other.transDate))
			return false;
		return true;
	}



	@Override
	public String toString() {
		return "Purchase [productCode=" + productCode + ", transDate=" + transDate + ", purchaseAmount="
				+ purchaseAmount + "]";
	}

	

	
	
}
