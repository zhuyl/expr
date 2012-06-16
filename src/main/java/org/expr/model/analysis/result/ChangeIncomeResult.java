package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;

/**
 * 平衡收入表
 * 
 * @author chaostone
 * 
 */
public class ChangeIncomeResult extends LongIdObject implements IncomeHolder {
    
    private ChangeResult result;

    private Income income;

	public ChangeResult getResult() {
		return result;
	}

	public void setResult(ChangeResult result) {
		this.result = result;
	}


	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

}