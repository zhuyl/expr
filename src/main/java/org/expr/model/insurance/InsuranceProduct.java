package org.expr.model.insurance;

import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;

public class InsuranceProduct extends LongIdObject{
	String seqNo;
	String name;
	String corporation;
	InsuranceType type;
	Set<InsurancePayType> paytypes=new HashSet();
	Set<InsurancePayTime> paytimes=new HashSet();
	Set<InsuranceTime> times=new HashSet();
	String detail;
	//String scope;
	RateRegistry registry;//费率注册
	CareerProfile careerprofile;
	//本产品是否附加险
	Boolean additional;
	//附加险对应的主险
	InsuranceProduct masterProduct;
	//包含的附加险
	Set<InsuranceProduct> additionalProducts=new HashSet();
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getCorporation() {
		return corporation;
	}
	public void setCorporation(String corporation) {
		this.corporation = corporation;
	}
	public InsuranceType getType() {
		return type;
	}
	public void setType(InsuranceType type) {
		this.type = type;
	}
	public Set<InsurancePayType> getPaytypes() {
		return paytypes;
	}
	public void setPaytypes(Set<InsurancePayType> paytypes) {
		this.paytypes = paytypes;
	}
	public Set<InsurancePayTime> getPaytimes() {
		return paytimes;
	}
	public void setPaytimes(Set<InsurancePayTime> paytimes) {
		this.paytimes = paytimes;
	}
	public Set<InsuranceTime> getTimes() {
		return times;
	}
	public void setTimes(Set<InsuranceTime> times) {
		this.times = times;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}

	public RateRegistry getRegistry() {
		return registry;
	}
	public void setRegistry(RateRegistry registry) {
		this.registry = registry;
	}
	public CareerProfile getCareerprofile() {
		return careerprofile;
	}
	public void setCareerprofile(CareerProfile careerprofile) {
		this.careerprofile = careerprofile;
	}
	
	public Boolean getAdditional() {
		return additional;
	}
	public void setAdditional(Boolean additional) {
		this.additional = additional;
	}
	
	public InsuranceProduct getMasterProduct() {
		return masterProduct;
	}
	public void setMasterProduct(InsuranceProduct masterProduct) {
		this.masterProduct = masterProduct;
	}
	public Set<InsuranceProduct> getAdditionalProducts() {
		return additionalProducts;
	}
	public void setAdditionalProducts(Set<InsuranceProduct> additionalProducts) {
		this.additionalProducts = additionalProducts;
	}
}
