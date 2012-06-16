package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;

/**
 * 收入表
 * 
 * @author Administrator
 * 
 */
public class IncomeResult extends LongIdObject implements IncomeHolder {
    
    private BalanceOfPaymentResult result;

    private Income income;

	public BalanceOfPaymentResult getResult() {
		return result;
	}

	public void setResult(BalanceOfPaymentResult result) {
		this.result = result;
	}

	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

}