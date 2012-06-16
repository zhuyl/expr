package org.expr.model.evaluation.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.evaluation.Benefit;
import org.expr.model.evaluation.BenefitItem;


public class BenefitResult extends AbstractResult implements Benefit {

	protected Set<BenefitItem> items=new HashSet();

	public Set<BenefitItem> getItems() {
		return items;
	}
	public void setItems(Set<BenefitItem> items) {
		this.items = items;
	}
	

}