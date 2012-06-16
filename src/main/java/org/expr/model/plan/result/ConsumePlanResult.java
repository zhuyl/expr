package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.expr.model.analysis.AbstractResult;

public class ConsumePlanResult  extends AbstractResult{
	
	private Map<Integer,Double> amounts=new HashMap();

	public Map<Integer, Double> getAmounts() {
		return amounts;
	}

	public void setAmounts(Map<Integer, Double> amounts) {
		this.amounts = amounts;
	}
	
}
