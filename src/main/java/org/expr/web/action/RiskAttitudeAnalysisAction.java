package org.expr.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.Option;
import org.expr.model.analysis.Question;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.analysis.ScoreRank;

import com.ekingstar.eams.web.action.BaseAction;

public class RiskAttitudeAnalysisAction extends BaseAction {
	public String list()
	{
		EntityQuery query = new EntityQuery(Questionnaire.class,"questionnaire");
		query.add(new Condition("questionnaire.type.code=:code", "01"));
		put("questionnaires", entityService.search(query));
		return forward();
	}


	public String index() {
		Long questionnaireId = getLong("questionnaire.id");
		Questionnaire questionnaire = null;
		EntityQuery query = new EntityQuery(Questionnaire.class, "questionnaire");
		query.add(new Condition("questionnaire.id=" + questionnaireId));
		List<Questionnaire> questionnaires = entityService.search(query);
		questionnaire = questionnaires.get(0);
		put("questionnaire", questionnaire);

		return forward();
	}

	public String save() {
		Long questionnaireId = getLong("questionnaire.id");
		Questionnaire questionnaire = (Questionnaire) entityService.get(Questionnaire.class,
				questionnaireId);

		Float score = 0f;
		Map checkedOptions=new HashMap();
		
		for (Question question : questionnaire.getQuestions()) {
			Long optionId = getLong("option" + question.getId());
			Option option = (Option) entityService.get(Option.class, optionId);
			checkedOptions.put(question, option);
			score += option.getScore();
			
		}
		// answer.setQuestionScore(score);
		// entityService.saveOrUpdate(answer);
		for (ScoreRank rank : questionnaire.getRanks()) {
			if (score >= rank.getLower() && score <= rank.getUpper()) {
				put("rank", rank);
				put("score", score);
				put("questionnaire", questionnaire);
				put("checkedOptions",checkedOptions);
			}
		}
		return forward("index");
	}

}