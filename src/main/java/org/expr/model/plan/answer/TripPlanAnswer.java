package org.expr.model.plan.answer;

import java.util.HashMap;
import java.util.Map;

public class TripPlanAnswer  extends AbstractPlanAnswer{
	
	private Map<Integer,Double> expenses=new HashMap();

	public Map<Integer, Double> getExpenses() {
		return expenses;
	}

	public void setExpenses(Map<Integer, Double> expenses) {
		this.expenses = expenses;
	}


	
}
