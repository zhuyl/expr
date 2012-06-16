package org.expr.model.analysis;

import java.util.Date;

import org.beanfuse.model.Component;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;

/**
 * 保单表
 * 
 * @author Administrator
 * 
 */
public class InsurancePolicy implements Component {
    
    /** 保险资产分析表 */
    private InsuranceAnalysis insuranceAnalysis;
    
    /**是否附加险*/
    private  Boolean additional;
    
	/** 保单编号 */
    private String seqNo;
    
    /**保险名称*/
    private String name;
    
    /** 保险公司 */
    private String company;
    
    /** 被保险人物 */
    private String insurant;
    
    /** 投保人(申请人) */
    private String proposer;
    
    /**受益人**/
    private String benefit;
    
	/** 投保日期 */
    private Date applyOn;
    
    /** 险种 */
    private InsuranceType type;
    
    /** 保额 */
    private Float coverage;
    
    /** 保费 */
    private Float expense;
    
    /** 缴费年限 */
    private InsurancePayTime payTime;
    
    /** 缴费方式 */
    private InsurancePayType payType;
    
    /**保险期限*/
    private InsuranceTime time;
    
    /** 保险现金价值 */
    private Float value;
    
    /** 保单质押贷款 */
    private Float impawn;
    
    public Boolean getAdditional() {
		return additional;
	}
	public void setAdditional(Boolean additional) {
		this.additional = additional;
	}
	public String getBenefit() {
		return benefit;
	}
	public void setBenefit(String benefit) {
		this.benefit = benefit;
	}

	public InsuranceAnalysis getInsuranceAnalysis() {
		return insuranceAnalysis;
	}
	public void setInsuranceAnalysis(InsuranceAnalysis insuranceAnalysis) {
		this.insuranceAnalysis = insuranceAnalysis;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getInsurant() {
		return insurant;
	}
	public void setInsurant(String insurant) {
		this.insurant = insurant;
	}
	public String getProposer() {
		return proposer;
	}
	public void setProposer(String proposer) {
		this.proposer = proposer;
	}


	public Date getApplyOn() {
		return applyOn;
	}
	public void setApplyOn(Date applyOn) {
		this.applyOn = applyOn;
	}
	public InsuranceType getType() {
		return type;
	}
	public void setType(InsuranceType type) {
		this.type = type;
	}
	public Float getCoverage() {
		return coverage;
	}
	public void setCoverage(Float coverage) {
		this.coverage = coverage;
	}
	public Float getExpense() {
		return expense;
	}
	public void setExpense(Float expense) {
		this.expense = expense;
	}
	public InsurancePayTime getPayTime() {
		return payTime;
	}
	public void setPayTime(InsurancePayTime payTime) {
		this.payTime = payTime;
	}
	public InsurancePayType getPayType() {
		return payType;
	}
	public void setPayType(InsurancePayType payType) {
		this.payType = payType;
	}
	public InsuranceTime getTime() {
		return time;
	}
	public void setTime(InsuranceTime time) {
		this.time = time;
	}
	public Float getValue() {
		return value;
	}
	public void setValue(Float value) {
		this.value = value;
	}
	public Float getImpawn() {
		return impawn;
	}
	public void setImpawn(Float impawn) {
		this.impawn = impawn;
	}
}