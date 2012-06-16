package org.expr.model.plan.answer;

import java.util.HashSet;
import java.util.Set;

public class EducationPlanAnswer extends AbstractPlanAnswer{

	private Set<MemberEducationPlanAnswer> members=new HashSet();
	
	public Set<MemberEducationPlanAnswer> getMembers() {
		return members;
	}
	public void setMembers(Set<MemberEducationPlanAnswer> members) {
		this.members = members;
	}
	
}
