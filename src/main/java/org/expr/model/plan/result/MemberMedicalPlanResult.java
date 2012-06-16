package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberMedicalPlanResult extends LongIdObject {

	private MedicalPlanResult result;
	
	private String name;
	
	private Map<Integer,Double> expenses=new HashMap();
	
	public MedicalPlanResult getResult() {
		return result;
	}
	public void setResult(MedicalPlanResult result) {
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