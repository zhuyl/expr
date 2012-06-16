package org.expr.web.action.analysis.result;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.InsuranceAnalysis;
import org.expr.model.analysis.Option;
import org.expr.model.analysis.Question;
import org.expr.model.analysis.QuestionAnswer;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.analysis.result.InsuranceAnalysisResult;
import org.expr.model.analysis.result.QuestionAnswerResult;
import org.expr.model.analysis.result.RiskToleranceResult;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class RiskToleranceAnalysisAction extends AbstractAnalysisResultAction {

	private RiskToleranceResult getResult(){
		Long resultId=getLong("result.id");
		if(null!=resultId){
			return (RiskToleranceResult)entityService.load(RiskToleranceResult.class, resultId);
		}
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(RiskToleranceResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List<RiskToleranceResult> results = entityService.search(query);
		RiskToleranceResult result = null;
		if (results.isEmpty()) {
			result = new RiskToleranceResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentId));
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
			entityService.saveOrUpdate(result);
			return result;
		}else{
			return  results.get(0);
		}
	}
	public String index() {
		Long experimentId = getLong("experiment.id");
		Experiment experiment=(Experiment)entityService.load(Experiment.class, experimentId);
		RiskToleranceResult result =getResult();
		Map<Question, Option> checkedOptions = new HashMap();
		Questionnaire questionnaire = null;
		if (null==result) {
			EntityQuery query = new EntityQuery(Caze.class, "caze");
			query.add(new Condition("caze.id=" + experiment.getCaze().getId()));
			List<Caze> cazes = entityService.search(query);
			if (null != cazes.get(0).getQuestionnaire()) {
				questionnaire = cazes.get(0).getQuestionnaire();
			}
		} else {
			for (QuestionAnswer questionAnswer : result.getAnswers()) {
				checkedOptions.put(questionAnswer.getQuestion(), questionAnswer.getOption());
			}
			questionnaire = result.getQuestionnaire();
			put("result", result);
		}
		put("questionnaire",questionnaire);
		put("checkedOptions", checkedOptions);
		return forward();
	}
	
	public String save(){
		RiskToleranceResult result = getResult();
		Long questionnaireId=getLong("questionnaire.id");
		Questionnaire questionnaire=(Questionnaire)entityService.get(Questionnaire.class, questionnaireId);
		if(null==result){
			result=new RiskToleranceResult();
			Long experimentId = getLong("experiment.id");
			result.setExperiment((Experiment)entityService.get(Experiment.class, experimentId));
			result.setQuestionnaire(questionnaire);
			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
			if (null != studentList && studentList.size()!=0){
				result.setStudent((Student)studentList.get(0));
			}	
		}
		Map<Question,QuestionAnswerResult> existed=new HashMap();
		for(Iterator iter=result.getAnswers().iterator();iter.hasNext();){
			QuestionAnswerResult questionAnswer=(QuestionAnswerResult)iter.next();
			existed.put(questionAnswer.getQuestion(), questionAnswer);
		}
		Float score=0f;
		for(Question question:questionnaire.getQuestions()){
			Long optionId=getLong("option"+question.getId());
			QuestionAnswerResult questionAnswer=existed.get(question);
			if(null==questionAnswer){
				questionAnswer=new QuestionAnswerResult();
				questionAnswer.setResult(result);
				questionAnswer.setQuestion(question);
				result.getAnswers().add(questionAnswer);
			}
			Option option=(Option)entityService.get(Option.class, optionId);
			score+=option.getScore();
			questionAnswer.setOption(option);
		}
		result.setQuestionScore(score);
		entityService.saveOrUpdate(result);
		return redirect("index","info.save.success");
	}

}