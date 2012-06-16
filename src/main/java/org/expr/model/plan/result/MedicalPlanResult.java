package org.expr.model.plan.result;

import java.util.HashSet;
import java.util.Set;

import org.expr.model.analysis.AbstractResult;

public class MedicalPlanResult extends AbstractResult{

	private Set<MemberMedicalPlanResult> members=new HashSet();
	
	public Set<MemberMedicalPlanResult> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberMedicalPlanResult> members) {
		this.members = members;
	}
	
}
