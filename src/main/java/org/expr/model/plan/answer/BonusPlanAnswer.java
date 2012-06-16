package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

public class BonusPlanAnswer extends AbstractPlanAnswer{

	private Set<MemberBonusPlanAnswer> members=new HashSet();
	
	public Set<MemberBonusPlanAnswer> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberBonusPlanAnswer> members) {
		this.members = members;
	}
	
}
