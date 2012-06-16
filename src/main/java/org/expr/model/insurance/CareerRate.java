package org.expr.model.insurance;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class CareerRate extends LongIdObject{
	InsuranceProduct product;
	
	Map<Long,Float> rates=new HashMap();
	public InsuranceProduct getProduct() {
		return product;
	}
	public void setProduct(InsuranceProduct product) {
		this.product = product;
	}
	public Map<Long, Float> getRates() {
		return rates;
	}
	public void setRates(Map<Long, Float> rates) {
		this.rates = rates;
	}
	
}
