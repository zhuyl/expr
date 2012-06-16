package org.expr.model.plan.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.insurance.InsuranceProduct;

/**
 * 保单表
 * 
 * @author Administrator
 * 
 */
public class InsurancePlanPolicyAnswer extends LongIdObject {
    
    /** 保险资产 */
    private InsurancePlanAnswer answer;
    
    /**保险产品*/
    private InsuranceProduct product; 
    
    
    /** 被保险人物 */
    private String insurant;
    
    /** 投保人(申请人) */
    private String proposer;
    
    /**受益人**/
    private String benefit;
    
	/** 投保日期 */
    private Integer applyOn;   
    
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
	
	/**主险保单*/
	private InsurancePlanPolicyAnswer master;

	public InsurancePlanAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(InsurancePlanAnswer answer) {
		this.answer = answer;
	}

	public InsuranceProduct getProduct() {
		return product;
	}

	public void setProduct(InsuranceProduct product) {
		this.product = product;
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

	public String getBenefit() {
		return benefit;
	}

	public void setBenefit(String benefit) {
		this.benefit = benefit;
	}

	public Integer getApplyOn() {
		return applyOn;
	}

	public void setApplyOn(Integer applyOn) {
		this.applyOn = applyOn;
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

	public InsurancePlanPolicyAnswer getMaster() {
		return master;
	}

	public void setMaster(InsurancePlanPolicyAnswer master) {
		this.master = master;
	}
	


}