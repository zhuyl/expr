package org.expr.model.plan.answer;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.pojo.LongIdObject;

public class MemberBonusPlanAnswer extends LongIdObject {

	private BonusPlanAnswer answer;
	
	private String name;
	
	private Map<Integer,Double> bonuses=new HashMap();
	
	public BonusPlanAnswer getAnswer() {
		return answer;
	}
	public void setAnswer(BonusPlanAnswer answer) {
		this.answer = answer;
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
