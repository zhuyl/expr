package org.expr.model.evaluation.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.BenefitItem;

public class BenefitItemAnswer extends LongIdObject implements BenefitItem {
	
	private BenefitAnswer answer;
	
	private FinanceType financetype;
	
	private String content;
	
	public BenefitAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(BenefitAnswer answer) {
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