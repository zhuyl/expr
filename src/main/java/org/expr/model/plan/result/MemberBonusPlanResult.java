package org.expr.model.plan.result;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberBonusPlanResult extends LongIdObject {

	private BonusPlanResult result;
	
	private String name;
	
	private Map<Integer,Double> bonuses=new HashMap();
	

	public BonusPlanResult getResult() {
		return result;
	}
	public void setResult(BonusPlanResult result) {
		this.result = result;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Map<Integer, Double> getBonuses() {
		return bonuses;
	}
	public void setBonuses(Map<Integer, Double> bonuses) {
		this.bonuses = bonuses;
	}

	
}
