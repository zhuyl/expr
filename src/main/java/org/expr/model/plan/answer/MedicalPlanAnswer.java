package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

public class MedicalPlanAnswer extends AbstractPlanAnswer{

	private Set<MemberMedicalPlanAnswer> members=new HashSet();
	
	public Set<MemberMedicalPlanAnswer> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberMedicalPlanAnswer> members) {
		this.members = members;
	}
	
}
