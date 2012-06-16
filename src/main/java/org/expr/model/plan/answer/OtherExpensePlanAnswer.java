package org.expr.model.plan.answer;

import java.util.HashMap;
import java.util.Map;

public class OtherExpensePlanAnswer  extends AbstractPlanAnswer{
	
	private Map<Integer,Double> amounts=new HashMap();

	public Map<Integer, Double> getAmounts() {
		return amounts;
	}

	public void setAmounts(Map<Integer, Double> amounts) {
		this.amounts = amounts;
	}
	
}
