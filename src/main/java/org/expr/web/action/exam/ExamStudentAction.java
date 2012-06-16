package org.expr.web.action.exam;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.transfer.exporter.Context;
import org.expr.model.Caze;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.analysis.result.CazeResult;
import org.expr.model.assessment.Assessment;
import org.expr.model.basecode.Analysis;
import org.expr.model.basecode.AnalysisPhase;
import org.expr.model.basecode.ExperimentType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.exam.ExamItem;
import org.expr.model.exam.ExamOption;
import org.expr.model.exam.ExamPaper;
import org.expr.model.exam.ExamQuestion;
import org.expr.model.exam.ExamQuestionMark;
import org.expr.model.exam.result.ExamItemResult;
import org.expr.model.exam.result.ExamQuestionResult;
import org.expr.model.exam.result.ExamResult;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.ExperimentMark;
import org.expr.model.lesson.Lesson;
import org.expr.model.lesson.StudyLog;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;
import com.opensymphony.xwork2.ActionContext;

public class ExamStudentAction extends BaseAction {

	public String index() {
		EntityQuery query = new EntityQuery(ExamPaper.class, "examPaper");
		Long lesson_id = getLong("lesson.id");
		query.add(new Condition("examPaper.lesson.id=:lessonid", lesson_id));	
		List examPapers = entityService.search(query);
		put("examPapers",examPapers);
		put("lesson", entityService.get(Lesson.class, lesson_id));
		Student std=getLoginStudent();
		
		Map ExamPaperResults = new HashMap();
		for (Iterator iterator = examPapers.iterator(); iterator
				.hasNext();) {
			ExamPaper examPaper = (ExamPaper) iterator.next();
			ExamResult examPaperResult = getResult(examPaper,std);
			ExamPaperResults.put(examPaper.getId(), examPaperResult);
		}
		put("examPaperResults", ExamPaperResults);
		
		Date present = new Date();
		put("currentTime", present);
		return forward();
	}
	public String examAnswer(){
		Date present = new Date();
		put("currentTime", present);
		Student std = getLoginStudent();
		put("std",std);
		Long examPaper_id = getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		put("examPaper", examPaper);
		ExamResult examPaperResult=(ExamResult)getResult(examPaper,std);
		put("examPaperResult", examPaperResult);
		String diffStr=timeDiff(examPaperResult.getEndAt(),examPaperResult.getBeginAt());
		put("examSpan",diffStr);
		return forward();
	}
	
	public static String timeDiff(Date date1,Date date2){
		String diffStr="";
	    long diff = date1.getTime() - date2.getTime();
	    long mins = diff / (1000 * 60 );
	    long secs=diff/1000-mins*60;
	    diffStr=mins+"分"+secs+"秒";
		return diffStr;
	}
	
	public String examIndex(){
		Student std = getLoginStudent();
		put("std",std);
		Long examPaper_id = getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		put("examPaper", examPaper);
		ActionContext.getContext().getSession().put("startAt", new Date());
		put("startAt",get("startAt"));
		ExamResult examPaperResult=(ExamResult)getResult(examPaper,std);
		put("examPaperResult", examPaperResult);		
		Map<String,ExamQuestion> questions=new HashMap();
		Map<String,Integer> totals=new HashMap();
		for (Iterator iterator = examPaper.getQuestionMarks().iterator(); iterator.hasNext();) {
			ExamQuestionMark questionMark = (ExamQuestionMark) iterator.next();
			Integer max=questionMark.getQuestions().size();
			Integer rand=getRandomInt(0,max);
			int i=0;
			for (Iterator questionIterator = questionMark.getQuestions().iterator(); questionIterator.hasNext();)
			{
				ExamQuestion examQuestion=(ExamQuestion)questionIterator.next();
				if((i==rand)&&!(contain(questions,examQuestion))){//题目不重复
					questions.put(questionMark.getCode().toString(),examQuestion);
					int total=0;
					for (Iterator itmeIterator = examQuestion.getItems().iterator(); itmeIterator.hasNext();)
					{
						ExamItem examItem=(ExamItem)itmeIterator.next();
						total=total+examItem.getWeight();
					}
					totals.put(questionMark.getCode().toString(), total);
					break;
				}
				i++;
				
			}
			i=0;
		}
		put("questions",questions);
		put("totals",totals);
		return forward();
	}
	
	public static boolean contain(Map map,Object value){
		boolean result=false;
		for (Iterator iterator = map.values().iterator(); iterator.hasNext();) {
			Object tempvalue=iterator.next();
			if(value.equals(tempvalue)) 
				{
				result=true;
				break;
				}
		}
		
		return result;
	}
	
    public static int getRandomInt( int min, int max )   
    {   
        // include min, exclude max   
        int result = min + new Double( Math.random() * ( max - min ) ).intValue();   
  
        return result;   
    } 

    public static String getString(String[] strings){
    	String result="";
    	for(int i=0;i<strings.length;i++)
    	{
    		if(i==strings.length-1)
    		{
    			result=result+strings[i];
    		}
    		else
    		{
    			result=result+strings[i]+",";
    		}
    		
    	}
    	return result;
    }
    public String submitAnswer(){
		Long examPaper_id = getLong("examPaper.id");
		Long question_id=0l;
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		Student student=getLoginStudent();
		ExamResult result=getResult(examPaper,student);		
		Float totalmark=0f;
		for (Iterator iterator = examPaper.getQuestionMarks().iterator(); iterator.hasNext();) {
			ExamQuestionMark questionMark=(ExamQuestionMark)iterator.next();
			question_id=getLong("question"+questionMark.getCode().toString()+"Id");
			ExamQuestion question=(ExamQuestion)entityService.get(ExamQuestion.class, question_id);
			float total=0f;
			for(Iterator markIterator = question.getItems().iterator(); markIterator.hasNext();){
				ExamItem markItem=(ExamItem)markIterator.next();
				total=total+markItem.getWeight();
			}
		  if (!question.getItems().isEmpty()){/**小题目存在*/
			/**构造大题答案*/
			ExamQuestionResult questionResult=getQuestionResult(result,questionMark.getCode(),question);
			float totalscore=0f;
					for(Iterator itemIterator = question.getItems().iterator(); itemIterator.hasNext();){
						/**构造小题答案*/
						ExamItem item=(ExamItem)itemIterator.next();
						ExamItemResult itemResult=getItemResult(questionResult,item);
						String[] answers = getValues("option"+questionMark.getCode().toString()+"_"+item.getId().toString());						
						String answer="";
						float score=0f;
						if (answers==null)
						{
							answer="";
						}else
						{
							answer=getString(answers);
						}
						itemResult.setResult(answer);
						if(item.getAnswer().equals(answer)){
							score=item.getWeight()*questionMark.getMark()/total;
							totalscore=totalscore+item.getWeight();
							itemResult.setMark(score);
						}else
						{
							itemResult.setMark(0f);/**0为错误*/
						}
						questionResult.getItemResults().add(itemResult);
					}
			float mark=totalscore*questionMark.getMark()/total;/**计算大题得分*/
			questionResult.setMark(mark);
			result.getQuestionResults().add(questionResult);
			totalmark=totalmark+mark;
		  }
		}
		Date startAt = (Date) ActionContext.getContext().getSession().get("startAt");
		result.setBeginAt(startAt);
		result.setEndAt(new Date(System.currentTimeMillis()));
		result.setMark(totalmark);
		entityService.saveOrUpdate(result);		
		return redirect("examAnswer", "info.save.success", "&examPaperId="+ examPaper_id);

    }
    
	private ExamResult getResult(ExamPaper examPaper, Student student) {
		EntityQuery query = new EntityQuery(ExamResult.class, "r");
		query.add(new Condition("r.student=:std and r.paper=:examPaper", student, examPaper));
		List<ExamResult> results = entityService.search(query);
		ExamResult result = null;
		if (results.isEmpty()) {
			result = new ExamResult();
			result.setPaper(examPaper);
			result.setStudent(student);
			entityService.saveOrUpdate(result);
		} else {
			result = results.get(0);
		}
		return result;
	}
	
	private ExamQuestionResult getQuestionResult(ExamResult result,Integer code,ExamQuestion question){
		EntityQuery query = new EntityQuery(ExamQuestionResult.class, "r");	
		query.add(new Condition("r.examResult=:result and r.code=:code and r.question=:question",result,code,question));
		List<ExamQuestionResult> questionResults = entityService.search(query);	
		ExamQuestionResult questionResult=null;
		if(questionResults.isEmpty()){
			questionResult=new ExamQuestionResult();
			questionResult.setCode(code);
			questionResult.setExamResult(result);
			questionResult.setQuestion(question);
			entityService.saveOrUpdate(questionResult);			
		}else
		{
			questionResult=questionResults.get(0);
		}
		return questionResult;
	}
	
	private ExamItemResult getItemResult(ExamQuestionResult questionResult,ExamItem item){
		EntityQuery query = new EntityQuery(ExamItemResult.class, "r");	
		query.add(new Condition("r.questionResult=:questionResult and r.item=:item",questionResult,item));
		List<ExamItemResult> itemResults = entityService.search(query);	
		ExamItemResult itemResult=null;
		if(itemResults.isEmpty()){
			itemResult=new ExamItemResult();
			itemResult.setItem(item);
			itemResult.setQuestionResult(questionResult);
			entityService.saveOrUpdate(itemResult);			
		}else
		{
			itemResult=itemResults.get(0);
		}
		return itemResult;
	}
}
