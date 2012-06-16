package org.expr.web.action.analysis.answer;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyAnalysis;
import org.expr.model.analysis.answer.FamilyAnalysisAnswer;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.basecode.BenefitRelation;
import org.expr.model.insurance.Career;

import com.ekingstar.eams.basecode.nation.Gender;

public class FamilyAnalysisAction extends AbstractAnalysisAnswerAction {

	public String index() {
		return search();
	}

	private FamilyAnalysisAnswer getFamilyAnalysisAnswer() {
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(FamilyAnalysisAnswer.class, "caze.id", cazeid);
		FamilyAnalysisAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new FamilyAnalysisAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
			answer.setForm(new FamilyAnalysis());
		} else {
			answer = (FamilyAnalysisAnswer) answers.get(0);
		}
		return answer;
	}

	public String search() {
		Long cazeid = getLong("caze.id");
		FamilyAnalysisAnswer analysisAnswer = getFamilyAnalysisAnswer();
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "m");
		query.add(new Condition("m.answer.caze.id=:cazeid", cazeid));
		query.setLimit(getPageLimit());
		put("answers", entityService.search(query));
		put("analysisAnswer", analysisAnswer);
		return forward();
	}

	public void editSetting(Entity entity) {
		put("Genders", entityService.search(new EntityQuery(Gender.class, "Gender")));
		put("BenefitRealtion",
				entityService.search(new EntityQuery(BenefitRelation.class, "BenefitRelation")));
		EntityQuery query = new EntityQuery(Career.class, "career");
		query.add(new Condition("length(career.code)=2"));
		put("careers", entityService.search(query));
	}

	protected String saveAndForward(Entity entity) {
		FamilyMemberAnswer memberAnswer = (FamilyMemberAnswer) entity;
		if (memberAnswer.isVO()) {
			Long cazeid = getLong("caze.id");
			List answers = entityService.load(FamilyAnalysisAnswer.class, "caze.id", cazeid);
			FamilyAnalysisAnswer answer = null;
			if (answers.isEmpty()) {
				answer = new FamilyAnalysisAnswer();
				answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
				answer.setForm(new FamilyAnalysis());
			} else {
				answer = (FamilyAnalysisAnswer) answers.get(0);
			}
			memberAnswer.setAnswer(answer);
			answer.getForm().getMembers().add(memberAnswer);
			entityService.saveOrUpdate(answer);
		} else {
			entityService.saveOrUpdate(memberAnswer);
		}
		return redirect("search", "info.save.success");
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		FamilyAnalysisAnswer answer = null;
		List answers = entityService.load(FamilyAnalysisAnswer.class, "caze.id", cazeId);

		if (answers.isEmpty()) {
			answer = new FamilyAnalysisAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeId));
			answer.setForm(new FamilyAnalysis());
		} else {
			answer = (FamilyAnalysisAnswer) answers.get(0);
		}

		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}

	// 查看答案
	public String info() {
		search();
		return forward();
	}

}