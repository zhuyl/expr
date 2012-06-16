package org.expr.model.evaluation.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.RiskItem;


public class RiskItemAnswer extends LongIdObject implements RiskItem {
	
	private RiskAnswer answer;
	
	private FinanceType financetype;
	
	private String content;
	
	public RiskAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(RiskAnswer answer) {
		this.answer = answer;
	}


	public FinanceType getFinancetype() {
		return financetype;
	}
	public void setFinancetype(FinanceType financetype) {
		this.financetype = financetype;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}