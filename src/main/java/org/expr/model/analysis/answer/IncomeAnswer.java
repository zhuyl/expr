package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;

/**
 * 收入表
 * 
 * @author Administrator
 * 
 */
public class IncomeAnswer extends LongIdObject implements IncomeHolder {
    
    private BalanceOfPaymentAnswer answer;

    private Income income;

	public BalanceOfPaymentAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(BalanceOfPaymentAnswer answer) {
		this.answer = answer;
	}

	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

}