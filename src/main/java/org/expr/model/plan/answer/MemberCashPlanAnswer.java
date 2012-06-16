package org.expr.model.plan.answer;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberCashPlanAnswer extends LongIdObject {

	private CashPlanAnswer answer;
	
	private String name;
	
	private Map<Integer,Double> salaries=new HashMap();
	
	public CashPlanAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(CashPlanAnswer answer) {
		this.answer = answer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<Integer, Double> getSalaries() {
		return salaries;
	}
	public void setSalaries(Map<Integer, Double> salaries) {
		this.salaries = salaries;
	}
	
}
