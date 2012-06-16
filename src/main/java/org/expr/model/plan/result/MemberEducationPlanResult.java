package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberEducationPlanResult extends LongIdObject {

	private EducationPlanResult result;
	
	private String name;
	
	private Map<Integer,Double> expenses=new HashMap();
	
	public EducationPlanResult getResult() {
		return result;
	}
	public void setResult(EducationPlanResult result) {
		this.result = result;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<Integer, Double> getExpenses() {
		return expenses;
	}
	public void setExpenses(Map<Integer, Double> expenses) {
		this.expenses = expenses;
	}

	
}