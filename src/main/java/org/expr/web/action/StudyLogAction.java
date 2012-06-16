package org.expr.web.action;

import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.StudyLog;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class StudyLogAction extends BaseAction {
	/**列出某实验的学习记录*/
 public String studyLogs(){
	EntityQuery query=new EntityQuery(StudyLog.class,"log");
	query.add(new Condition("log.std.code=:stdCode", getLoginName()));
	query.add(new Condition("log.experiment.id=:experimentId", getLong("experimentId")));
	query.addOrder(Order.asc("log.startAt"));
	List rs=(List)entityService.search(query);
	put("logs",rs);
	
	Long experimentId = getLong("experimentId");
	   put("experiment",(Experiment)entityService.load(Experiment.class, experimentId));
	return forward();
 }
 
 
	/**列出某学生某实验的学习记录*/
 public String studentStudyLogs(){
	EntityQuery query=new EntityQuery(StudyLog.class,"log");
	query.add(new Condition("log.std.code=:stdCode", get("studentcode")));
	query.add(new Condition("log.experiment.id=:experimentId", getLong("experimentId")));
	query.addOrder(Order.asc("log.startAt"));
	List rs=(List)entityService.search(query);
	put("logs",rs);
	
	Long experimentId = getLong("experimentId");
	put("experiment",(Experiment)entityService.load(Experiment.class, experimentId));
	List studentList = (List)entityService.load(Student.class,"code",get("studentcode"));
	put("student",(Student)studentList.get(0));
	return forward();
 }
 
 
 public String curStudyLogs(){
		EntityQuery query = new EntityQuery(Experiment.class, "experiment");
		Long lesson_id = getLong("lesson.id");
		query.add(new Condition("experiment.lesson.id=:lessonid", lesson_id));
		query.addOrder(Order.asc("experiment.code"));
		List experiments = entityService.search(query);
		put("experiments", experiments);
	 return forward();
 }
}