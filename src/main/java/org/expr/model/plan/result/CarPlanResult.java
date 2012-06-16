package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.expr.model.analysis.AbstractResult;

/**
 * 购车规划
 * 
 * <pre>
 * 等额本息方法：
 * 月还本付息金额=[本金*月利率*(1+月利率)还款月数]/[(1+月利率)还款月数-1]
 * 算说明：
 * 每月利息 = 剩余本金 * 贷款月利率
 * 每月本金 = 每月月供额 – 每月利息
 *</pre>
 * 
 * @author Administrator
 * 
 */
public class CarPlanResult extends AbstractResult {

	private Map<Integer, BusinessLoans> loans = new HashMap();
	
	//	购车价值
	private Double carCapital;
	
	//	贷款总额
	private Double businessCapital;

	private Map<Integer,Double> expenses=new HashMap();

	public Map<Integer, Double> getExpenses() {
		return expenses;
	}

	public void setExpenses(Map<Integer, Double> expenses) {
		this.expenses = expenses;
	}

	public Map<Integer, BusinessLoans> getLoans() {
		return loans;
	}

	public void setLoans(Map<Integer, BusinessLoans> loans) {
		this.loans = loans;
	}

	public Double getBusinessCapital() {
		return businessCapital;
	}

	public void setBusinessCapital(Double businessCapital) {
		this.businessCapital = businessCapital;
	}

	public Double getCarCapital() {
		return carCapital;
	}

	public void setCarCapital(Double carCapital) {
		this.carCapital = carCapital;
	}

}
