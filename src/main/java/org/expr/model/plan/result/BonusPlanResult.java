package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

public class BonusPlanResult extends AbstractResult{

	private Set<MemberBonusPlanResult> members=new HashSet();
	
	public Set<MemberBonusPlanResult> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberBonusPlanResult> members) {
		this.members = members;
	}
	
}
