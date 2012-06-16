package org.expr.model.evaluation.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.evaluation.BenefitItem;

public class BenefitItemResult extends LongIdObject implements BenefitItem {
	
	private BenefitResult result;
	
	private FinanceType financetype;
	
	private String content;

	public BenefitResult getResult() {
		return result;
	}

	public void setResult(BenefitResult result) {
		this.result = result;
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