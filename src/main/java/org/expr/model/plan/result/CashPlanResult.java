package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

public class CashPlanResult extends AbstractResult{

	private Set<MemberCashPlanResult> members=new HashSet();
	
	public Set<MemberCashPlanResult> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberCashPlanResult> members) {
		this.members = members;
	}
	
}
