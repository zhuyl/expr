package org.expr.model.insurance;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;

import com.ekingstar.eams.basecode.nation.Gender;
/**
 * 保单
 * @author Administrator
 *
 */
public class Policy extends LongIdObject {
	String name;
	Integer age;
	Gender gender;
	InsuranceTime time;
	InsurancePayTime paytime;
	InsurancePayType paytype;
	InsuranceProduct product;
	Career career; 
	Double value;
    public Double getValue() {
		return value;
	}
	public void setValue(Double value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Career getCareer() {
		return career;
	}
	public void setCareer(Career career) {
		this.career = career;
	}

    
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
	public InsuranceTime getTime() {
		return time;
	}
	public void setTime(InsuranceTime time) {
		this.time = time;
	}
	public InsurancePayTime getPaytime() {
		return paytime;
	}
	public void setPaytime(InsurancePayTime paytime) {
		this.paytime = paytime;
	}
	public InsurancePayType getPaytype() {
		return paytype;
	}
	public void setPaytype(InsurancePayType paytype) {
		this.paytype = paytype;
	}
	public InsuranceProduct getProduct() {
		return product;
	}
	public void setProduct(InsuranceProduct product) {
		this.product = product;
	}
    
}
