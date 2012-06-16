package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.expr.model.analysis.AbstractResult;

/**
 * 房产规划
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
public class EstateLoanPlanResult extends AbstractResult {

	private Map<Integer, Loans> loans = new HashMap();

	public Map<Integer, Loans> getLoans() {
		return loans;
	}

	public void setLoans(Map<Integer, Loans> loans) {
		this.loans = loans;
	}

	
	//	房产价值
	private Double houseCapital;
	
	//	商业贷款总额
	private Double businessCapital;

	//	公积金贷款总额
	private Double accumulationCapital;
	//房产价值
	private Map<Integer,Double> expenses=new HashMap();

	public Map<Integer, Double> getExpenses() {
		return expenses;
	}

	public void setExpenses(Map<Integer, Double> expenses) {
		this.expenses = expenses;
	}

	public Double getBusinessCapital() {
		return businessCapital;
	}

	public void setBusinessCapital(Double businessCapital) {
		this.businessCapital = businessCapital;
	}

	public Double getHouseCapital() {
		return houseCapital;
	}

	public void setHouseCapital(Double houseCapital) {
		this.houseCapital = houseCapital;
	}

	public Double getAccumulationCapital() {
		return accumulationCapital;
	}

	public void setAccumulationCapital(Double accumulationCapital) {
		this.accumulationCapital = accumulationCapital;
	}

}
