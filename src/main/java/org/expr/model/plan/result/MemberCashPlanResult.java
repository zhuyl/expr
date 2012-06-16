package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberCashPlanResult extends LongIdObject {

	private CashPlanResult result;
	
	private String name;
	
	private Map<Integer,Double> salaries=new HashMap();
	

	public CashPlanResult getResult() {
		return result;
	}
	public void setResult(CashPlanResult result) {
		this.result = result;
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
