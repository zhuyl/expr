package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

public class EducationPlanResult extends AbstractResult{

	private Set<MemberEducationPlanResult> members=new HashSet();
	
	public Set<MemberEducationPlanResult> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberEducationPlanResult> members) {
		this.members = members;
	}
	
}
