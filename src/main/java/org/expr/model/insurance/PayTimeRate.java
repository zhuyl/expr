package org.expr.model.insurance;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;

import com.ekingstar.eams.basecode.nation.Gender;

public class PayTimeRate extends LongIdObject{
	InsuranceProduct product;
	InsurancePayTime paytime;
	InsuranceTime time;
	Gender gender;
	InsurancePayType paytype;
	Map<Integer,Float> agerates=new HashMap();
	public InsurancePayTime getPaytime() {
		return paytime;
	}
	public void setPaytime(InsurancePayTime paytime) {
		this.paytime = paytime;
	}
	public InsuranceTime getTime() {
		return time;
	}
	public void setTime(InsuranceTime time) {
		this.time = time;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	public InsurancePayType getPaytype() {
		return paytype;
	}
	public void setPaytype(InsurancePayType paytype) {
		this.paytype = paytype;
	}
	public Map<Integer, Float> getAgerates() {
		return agerates;
	}
	public void setAgerates(Map<Integer, Float> agerates) {
		this.agerates = agerates;
	}
	public InsuranceProduct getProduct() {
		return product;
	}
	public void setProduct(InsuranceProduct product) {
		this.product = product;
	}
}
