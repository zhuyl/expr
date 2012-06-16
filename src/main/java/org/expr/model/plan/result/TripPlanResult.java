package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.expr.model.analysis.AbstractResult;

public class TripPlanResult  extends AbstractResult{
	
	private Map<Integer,Double> expenses=new HashMap();

	public Map<Integer, Double> getExpenses() {
		return expenses;
	}

	public void setExpenses(Map<Integer, Double> expenses) {
		this.expenses = expenses;
	}


	
}
