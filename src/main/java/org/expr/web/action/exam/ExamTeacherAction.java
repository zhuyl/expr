package org.expr.web.action.exam;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.transfer.exporter.Context;
import org.expr.model.analysis.answer.IncomeAnswer;
import org.expr.model.exam.ExamPaper;
import org.expr.model.exam.ExamQuestion;
import org.expr.model.exam.ExamQuestionMark;
import org.expr.model.exam.result.ExamQuestionResult;
import org.expr.model.exam.result.ExamResult;
import org.expr.model.lesson.Lesson;


import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.web.action.BaseAction;

public class ExamTeacherAction extends BaseAction {

	public String index() {
		Long lesson_id = getLong("lesson.id");
		put("examPapers", entityService.load(ExamPaper.class, "lesson.id", lesson_id));
		put("lesson", entityService.get(Lesson.class, lesson_id));
		return forward();
	}
	protected void editSetting(Entity entity) {
		ExamPaper examPaper = (ExamPaper) entity;
		if (examPaper.isVO()) {
			Long lessonId = getLong("lessonId");
			examPaper.setLesson((Lesson) entityService.get(Lesson.class, lessonId));
		}
	}
	
	public String studentList(){
		Long examPaper_id = getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		put("examPaper", examPaper);
		
		Long lesson_id = getLong("lesson.id");	
		Lesson lesson=(Lesson)entityService.get(Lesson.class, lesson_id);	
		put("students",lesson.getStudents());
			
		int submited=0;	
		Map examPaperResults = new HashMap();
		for (Iterator iterator = lesson.getStudents().iterator(); iterator
				.hasNext();) {
			Student student = (Student) iterator.next();
			ExamResult examPaperResult = getResult(examPaper, student);
			if (examPaperResult.getMark()!=null){
				submited=submited+1;
			}
			examPaperResults.put(student.getId(), examPaperResult);
		}
		put("examPaperResults", examPaperResults);
		put("totals",lesson.getStudents().size());
		put("submiteds",submited);
		return forward();
	}
	
	protected void configExportContext(Context context) {
		Long examPaper_id = getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		context.put("examPaper", examPaper);
		
		Long lesson_id = getLong("lessonId");	
		Lesson lesson=(Lesson)entityService.get(Lesson.class, lesson_id);	
		context.put("students",lesson.getStudents());
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
			
		Map examPaperResults = new HashMap();
		Map examTimes=new HashMap();
		for (Iterator iterator = lesson.getStudents().iterator(); iterator
				.hasNext();) {
			Student student = (Student) iterator.next();
			ExamResult examPaperResult = getResult(examPaper, student);
			examPaperResults.put(student.getId(), examPaperResult);
			if((examPaperResult.getBeginAt()!=null)&&(examPaperResult.getEndAt()!=null)){
				examTimes.put(student.getId(),formatter.format(examPaperResult.getBeginAt())+"-"+formatter.format(examPaperResult.getEndAt()));
			}else
			{
				examTimes.put(student.getId(), "");
			}
			}
		context.put("examPaperResults", examPaperResults);
		context.put("examTimes", examTimes);
	}
	
	
	public String examAnswer(){
		Long student_id = getLong("studentId");
		Student std=(Student)entityService.get(Student.class, student_id);
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
		
	protected String saveAndForward(Entity entity) {
		ExamPaper examPaper = (ExamPaper) populateEntity(ExamPaper.class, "examPaper");	
		int count = getInteger("optionCount");
		Map<Long, ExamQuestionMark> existed = new HashMap();

		for (ExamQuestionMark examQuestionMark : examPaper.getQuestionMarks()) {
			existed.put(examQuestionMark.getId(), examQuestionMark);
		}
		for (int i = 0; i < count; i++) {
			String questionMarkPrefix = "questionMark" + i + ".";
			Long questionMarkId = getLong(questionMarkPrefix + "id");
			String name=get(questionMarkPrefix + "code");
			if(StringUtils.isBlank(name)){
				continue;
			}
			ExamQuestionMark examQuestionMark = null;
			if (null != questionMarkId && existed.containsKey(questionMarkId)) {
				examQuestionMark = existed.remove(questionMarkId);
			} else {
				examQuestionMark = new ExamQuestionMark();
				examQuestionMark.setPaper(examPaper);
				examPaper.getQuestionMarks().add(examQuestionMark);
			}
			examQuestionMark.setMark(getInteger(questionMarkPrefix + "mark"));
			examQuestionMark.setCode(getInteger(questionMarkPrefix + "code"));
			examQuestionMark.getQuestions().clear();
			examQuestionMark.getQuestions().addAll(entityService.load(ExamQuestion.class, "id", SeqStringUtil.transformToLong(get("selectedQuestion"+i+"Ids"))));		
		}
		examPaper.getQuestionMarks().removeAll(existed.values());
		entityService.saveOrUpdate(examPaper);
		return redirect("index", "info.save.success", "&lesson.id=" + examPaper.getLesson().getId());
	}
	protected String removeAndForward(Collection examPapers) {
		entityService.remove(examPapers);
		return redirect("index", "info.delete.success");
	}
	public String backTest(){
		Long student_id = getLong("studentId");
		Student std=(Student)entityService.get(Student.class, student_id);		
		Long examPaper_id = getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		ExamResult examPaperResult=getResult(examPaper,std);
		examPaperResult.setMark(null);
		entityService.saveOrUpdate(examPaperResult);		
		return redirect("studentList","info.back.success","&lesson.id="+examPaper.getLesson().getId()+"&examPaperId="+examPaper.getId());
	}
	public String examAnalysis(){
		Long examPaper_id=getLong("examPaperId");
		ExamPaper examPaper=(ExamPaper)entityService.get(ExamPaper.class, examPaper_id);
		put("examPaper", examPaper);		
		EntityQuery query = new EntityQuery(ExamResult.class, "examPaperResult");
        query.add(new Condition("examPaperResult.paper.id=" + examPaper_id));
		List examPaperResults = entityService.search(query);
		int total=0;
		Map analysisResults=new HashMap();
		Map percentResults=new HashMap();
		int excellent=0;
		int good=0;
		int middle=0;
		int pass=0;
		int nopass=0;
		float totalScore=0f;
		   for (Iterator iter = examPaperResults.iterator(); iter.hasNext();) {
			   ExamResult examPaperResult = (ExamResult) iter.next();
			   if(examPaperResult.getMark()!=null){
				   total=total+1;
				   totalScore=totalScore+examPaperResult.getMark();
			   if(examPaperResult.getMark()>=90){
				   excellent=excellent+1;
			   }else if(examPaperResult.getMark()>=80&&examPaperResult.getMark()<90)
			   {
				   good=good+1;
			   }else if(examPaperResult.getMark()>=70&&examPaperResult.getMark()<80){
				   middle=middle+1;
			   }else if(examPaperResult.getMark()>=60){
				   pass=pass+1;
			   }else
			   {
				   nopass=nopass+1;
			   }
			   }
		   }
		put("total",total);
		if(total>0)
		{
        analysisResults.put("excellent", excellent);
        analysisResults.put("good", good);
        analysisResults.put("middle", middle);
        analysisResults.put("pass", pass);
        analysisResults.put("nopass", nopass);
        percentResults.put("excellent",Math.round((excellent*100/total) * 100)/100.0);
        percentResults.put("good",Math.round((good*100/total) * 100)/100.0);
        percentResults.put("middle",Math.round((middle*100/total) * 100)/100.0);
        percentResults.put("pass",Math.round((pass*100/total) * 100)/100.0);
        percentResults.put("nopass",Math.round((nopass*100/total) * 100)/100.0);
		put("average", Math.round((totalScore/total) * 100) / 100.0);
		put("analysisResults",analysisResults);
		put("percentResults",percentResults);
		
		
		/**各大题分析*/
		Map questionAverages=new HashMap();
		EntityQuery quesitonQuery = new EntityQuery(ExamQuestionResult.class, "examQuestionResult");
		quesitonQuery.add(new Condition("examQuestionResult.examResult.paper.id=" + examPaper_id));
		quesitonQuery.groupBy("examQuestionResult.code");
		quesitonQuery.setSelect("examQuestionResult.code,sum(examQuestionResult.mark)");
		List<Object[]> questionResults = entityService.search(quesitonQuery);
		for (Object[] questionResult : questionResults) {
			double avg=(Double)questionResult[1];
			Integer code=(Integer)questionResult[0];
			questionAverages.put(code.toString(), Math.round((avg/total)*100)/100.0);
		}
		put("questionAverages",questionAverages);
		}
		return forward();
	}
}
