package org.expr.model.evaluation.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;
import org.expr.model.evaluation.Risk;
import org.expr.model.evaluation.RiskItem;


public class RiskResult extends AbstractResult implements Risk {
	
	protected Set<RiskItem> items=new HashSet();

	public Set<RiskItem> getItems() {
		return items;
	}

	public void setItems(Set<RiskItem> items) {
		this.items = items;
	}


}