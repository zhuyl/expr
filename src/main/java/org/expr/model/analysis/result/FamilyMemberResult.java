package org.expr.model.analysis.result;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FamilyMember;

/**
 * 家庭成员
 * 
 * @author chaostone
 * 
 */
public class FamilyMemberResult extends LongIdObject {

	private FamilyAnalysisResult result;

	private FamilyMember member;

	public FamilyMember getMember() {
		return member;
	}

	public void setMember(FamilyMember member) {
		this.member = member;
	}

	public FamilyAnalysisResult getResult() {
		return result;
	}

	public void setResult(FamilyAnalysisResult result) {
		this.result = result;
	}

}
