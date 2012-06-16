package org.expr.web.action.questionnaire;

import java.util.HashMap;
import java.util.Map;

import org.beanfuse.model.Entity;
import org.expr.model.analysis.Option;
import org.expr.model.analysis.Question;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.basecode.QuestionType;

import com.ekingstar.eams.web.action.BaseAction;

public class QuestionAction extends BaseAction {
	
	protected void editSetting(Entity entity) {
		put("questionTypes", entityService.loadAll(QuestionType.class));
	}

	protected String saveAndForward(Entity entity) {
		Question question = (Question) populateEntity(Question.class, "question");
		Long questionnaireid = getLong("questionnaire.id");
		Questionnaire questionnaire = (Questionnaire) entityService.get(Questionnaire.class,
				questionnaireid);
		question.setQuestionnaire(questionnaire);
		int count = getInteger("optionCount");
		Map<Long, Option> existed = new HashMap();

		for (Option option : question.getOptions()) {
			existed.put(option.getId(), option);
		}
		for (int i = 0; i < count; i++) {
			String optionPrefix = "option" + i + ".";
			Long optionId = getLong(optionPrefix + "id");
			String seq=get(optionPrefix + "seq");
			if(null==seq) continue;
			Option option = null;
			if (null != optionId && existed.containsKey(optionId)) {
				option = existed.remove(optionId);
			} else {
				option = new Option();
				option.setQuestion(question);
				question.getOptions().add(option);
			}
			option.setContext(get(optionPrefix + "name"));
			option.setSeq(seq);
			option.setScore(getFloat(optionPrefix + "score"));
		}
		question.getOptions().removeAll(existed.values());
		entityService.saveOrUpdate(question);
		return redirect("search", "info.save.success", "&questionnaire.id=" + questionnaireid);
	}

}
