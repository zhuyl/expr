package org.expr.web.action.analysis.answer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.Option;
import org.expr.model.analysis.Question;
import org.expr.model.analysis.QuestionAnswer;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.analysis.answer.QuestionAnswerAnswer;
import org.expr.model.analysis.answer.RiskToleranceAnswer;

public class RiskToleranceAnalysisAction extends AbstractAnalysisAnswerAction {

	private RiskToleranceAnswer getAnswer(){
		Long answerId=getLong("answer.id");
		if(null!=answerId){
			return (RiskToleranceAnswer)entityService.load(RiskToleranceAnswer.class, answerId);
		}
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(RiskToleranceAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<RiskToleranceAnswer> answers = entityService.search(query);
		if (answers.isEmpty()) {
			return null;
		}else{
			return  answers.get(0);
		}
	}
	public String index() {
		Long cazeId = getLong("caze.id");
		RiskToleranceAnswer answer =getAnswer();
		Map<Question, Option> checkedOptions = new HashMap();
		Questionnaire questionnaire = null;
		if (null==answer) {
			EntityQuery query = new EntityQuery(Caze.class, "caze");
			query.add(new Condition("caze.id=" + cazeId));
			List<Caze> cazes = entityService.search(query);
			if (null != cazes.get(0).getQuestionnaire()) {
				questionnaire = cazes.get(0).getQuestionnaire();
			}
		} else {
			for (QuestionAnswer questionAnswer : answer.getAnswers()) {
				checkedOptions.put(questionAnswer.getQuestion(), questionAnswer.getOption());
			}
			questionnaire = answer.getQuestionnaire();
			put("answer", answer);
		}
		put("questionnaire",questionnaire);
		put("checkedOptions", checkedOptions);
		return forward();
	}
	
	public String save(){
		RiskToleranceAnswer answer = getAnswer();
		Long questionnaireId=getLong("questionnaire.id");
		Questionnaire questionnaire=(Questionnaire)entityService.get(Questionnaire.class, questionnaireId);
		if(null==answer){
			answer=new RiskToleranceAnswer();
			Long cazeId = getLong("caze.id");
			answer.setCaze((Caze)entityService.get(Caze.class, cazeId));
			answer.setQuestionnaire(questionnaire);
		}
		Map<Question,QuestionAnswerAnswer> existed=new HashMap();
		for(Iterator iter=answer.getAnswers().iterator();iter.hasNext();){
			QuestionAnswerAnswer questionAnswer=(QuestionAnswerAnswer)iter.next();
			existed.put(questionAnswer.getQuestion(), questionAnswer);
		}
		Float score=0f;
		for(Question question:questionnaire.getQuestions()){
			Long optionId=getLong("option"+question.getId());
			QuestionAnswerAnswer questionAnswer=existed.get(question);
			if(null==questionAnswer){
				questionAnswer=new QuestionAnswerAnswer();
				questionAnswer.setAnswer(answer);
				questionAnswer.setQuestion(question);
				answer.getAnswers().add(questionAnswer);
			}
			Option option=(Option)entityService.get(Option.class, optionId);
			score+=option.getScore();
			questionAnswer.setOption(option);
		}
		answer.setQuestionScore(score);
		entityService.saveOrUpdate(answer);
		return redirect("index","info.save.success");
	}
	
	public String info() {
		index();
		return forward();
	}

}