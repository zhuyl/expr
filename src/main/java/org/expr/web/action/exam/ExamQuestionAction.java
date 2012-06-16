package org.expr.web.action.exam;


import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;

import org.expr.model.Caze;
import org.expr.model.basecode.LifeCycleType;
import org.expr.model.exam.ExamItem;
import org.expr.model.exam.ExamPaper;
import org.expr.model.exam.ExamQuestion;
import org.expr.model.exam.result.ExamItemResult;
import org.expr.model.exam.result.ExamQuestionResult;
import org.expr.model.exam.result.ExamResult;


import com.ekingstar.eams.web.action.BaseAction;

public class ExamQuestionAction extends BaseAction {

	public String index() {
		return forward();
	}

	protected String saveAndForward(Entity entity) {
		ExamQuestion examQuestion = (ExamQuestion) entity;
		
		try {	
			Long cazeId = getLong("caze.id");
			examQuestion.setCaze((Caze) entityService.load(Caze.class, cazeId));
			saveOrUpdate(examQuestion);
			return redirect("index", "info.save.success");
		} catch (Exception e) {
			logger.error("saveAndForwad failure for:", e);
		}
		return redirect("index", "info.save.failure");
	}
	public String questionQuery() {
		return forward();
	}
	public String questionQueryList() {
		EntityQuery query=new EntityQuery(ExamQuestion.class, "examQuestion");
		query.setLimit(getPageLimit());
		populateConditions(query);
		put("examQuestions", entityService.search(query));
		return forward();
	}
	public String questionAnalysis(){
		Long examQuestion_id=getLong("examQuestionId");
		ExamQuestion examQuestion=(ExamQuestion)entityService.get(ExamQuestion.class, examQuestion_id);
		put("examQuestion", examQuestion);	
		EntityQuery quesitonQuery1 = new EntityQuery(ExamQuestionResult.class, "examQuestionResult");
		quesitonQuery1.add(new Condition("examQuestionResult.question.id=" + examQuestion_id));
		List<Object[]> questionResults1 = entityService.search(quesitonQuery1);
		int total=questionResults1.size();
		put("total",total);
		if(total>0){
			/**求平均分*/
			EntityQuery quesitonQuery = new EntityQuery(ExamQuestionResult.class, "examQuestionResult");
			quesitonQuery.add(new Condition("examQuestionResult.question.id=" + examQuestion_id));
			quesitonQuery.setSelect("sum(examQuestionResult.mark)");
			List<Object[]> questionResults = entityService.search(quesitonQuery);
			Object questionResult=questionResults.get(0);
			double totalScore=(Double)questionResult;
			put("average",Math.round((totalScore/total) * 100) / 100.0);
			
			/**求小题正确率*/
			Map corrects=new HashMap();
			EntityQuery itemQuery = new EntityQuery(ExamItemResult.class, "examItemResult");
			itemQuery.add(new Condition("examItemResult.item.question.id=" + examQuestion_id));
			itemQuery.groupBy("examItemResult.item.code");
			itemQuery.setSelect("examItemResult.item.code,count(examItemResult.id)");/**错误率*/
			itemQuery.add(new Condition("examItemResult.mark=0"));
			List<Object[]> itemResults = entityService.search(itemQuery);
			for (Object[] itemResult : itemResults) {
				long count=(Long)itemResult[1];
				Integer code=(Integer)itemResult[0];
				corrects.put(code.toString(), Math.round((1-count/total)*10000)/100.0);
			}
			put("corrects",corrects);

		}
		
		
		return forward();
	}
}
