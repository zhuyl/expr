package org.expr.model.plan.answer;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberMedicalPlanAnswer extends LongIdObject {

	private MedicalPlanAnswer answer;
	
	private String name;
	
	private Map<Integer,Double> expenses=new HashMap();
	
	public MedicalPlanAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(MedicalPlanAnswer answer) {
		this.answer = answer;
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