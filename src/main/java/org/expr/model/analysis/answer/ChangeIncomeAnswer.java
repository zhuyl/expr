package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;

/**
 * 平衡收入表
 * 
 * @author chaostone
 * 
 */
public class ChangeIncomeAnswer extends LongIdObject implements IncomeHolder {
    
    private ChangeAnswer answer;

    private Income income;

	public ChangeAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(ChangeAnswer answer) {
		this.answer = answer;
	}


	public Income getIncome() {
		return income;
	}

	public void setIncome(Income income) {
		this.income = income;
	}

}