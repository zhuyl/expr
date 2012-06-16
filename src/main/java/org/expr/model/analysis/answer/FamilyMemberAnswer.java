package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.analysis.FamilyMember;

/**
 * 家庭成员表
 * 
 * @author Administrator
 * 
 */
public class FamilyMemberAnswer extends LongIdObject {

	private FamilyAnalysisAnswer answer;

	private FamilyMember member;

	public FamilyMember getMember() {
		return member;
	}

	public void setMember(FamilyMember member) {
		this.member = member;
	}

	public FamilyAnalysisAnswer getAnswer() {
		return answer;
	}

	public void setAnswer(FamilyAnalysisAnswer answer) {
		this.answer = answer;
	}

}