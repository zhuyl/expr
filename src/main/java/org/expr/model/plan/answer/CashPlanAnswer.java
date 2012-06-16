package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

public class CashPlanAnswer extends AbstractPlanAnswer{

	private Set<MemberCashPlanAnswer> members=new HashSet();
	
	public Set<MemberCashPlanAnswer> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberCashPlanAnswer> members) {
		this.members = members;
	}
	
}
