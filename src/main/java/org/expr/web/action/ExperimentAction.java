package org.expr.web.action;
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
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.ExperimentMark;
import org.expr.model.lesson.Lesson;
import org.expr.model.lesson.StudyLog;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class ExperimentAction extends BaseAction {

	public String index() {
		Long lesson_id = getLong("lesson.id");
		put("experiments", entityService.load(Experiment.class, "lesson.id", lesson_id));
		put("lesson", entityService.get(Lesson.class, lesson_id));
		return forward();
	}

	public int getPlanYears() {
		return 30;
	}

	public String studentList() {
		Long experimentId = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experimentId);
		put("experiment", experiment);

		EntityQuery choosequery = new EntityQuery(Experiment.class, "experiment");
		choosequery.add(new Condition("experiment.id=:experimentId", experimentId));
		/* 学生查询 */
		choosequery.join("left", "experiment.students", "student");
		String code = get("student.code");
		if (StringUtils.isNotBlank(code)) {
			choosequery.add(new Condition("student.code like :stdCode", "%" + code + "%"));
		}
		String name = get("student.name");
		if (StringUtils.isNotBlank(name)) {
			choosequery.add(new Condition("student.name like :stdName", "%" + name + "%"));
		}
		choosequery.setSelect("student");
		// choosequery.setLimit(getPageLimit());
		String orderBy = get(Order.ORDER_STR);
		if (null == orderBy) {
			orderBy = "student.code asc";
		}
		choosequery.addOrder(Order.parse(orderBy));
		List students = entityService.search(choosequery);

		if (!(students.size()==1&&students.get(0)==null)){
			put("students", students);
		Map cazeResults = new HashMap();
		for (Iterator iterator = students.iterator(); iterator
				.hasNext();) {
			Student student = (Student) iterator.next();
			CazeResult cazeResult = getResult(experiment, student);
			cazeResults.put(student.getId(), cazeResult);
		}
		put("cazeResults", cazeResults);

		EntityQuery query1 = new EntityQuery(StudyLog.class, "log");
		query1.add(new Condition("log.experiment.id=:experimentId", experimentId));
		query1.groupBy("log.std.id");
		query1.setSelect("log.std.id,sum(log.time)");
		List<Object[]> logtimes = entityService.search(query1);
		Map experimenttime = new HashMap();

		for (Object[] logtime : logtimes) {
			experimenttime.put(logtime[0].toString(), logtime[1]);
		}
		put("experimenttimes", experimenttime);
		}
		return forward();
	}
	
	public String cancelAnswer() {
		Long lesson_id = getLong("lesson.id");
		Student student = (Student) entityService.load(Student.class, getLong("std.id"));
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		CazeResult cazeResult = getResult(experiment, student);
		cazeResult.setIsSubmit(Boolean.FALSE);
		cazeResult.setSubmitAt(new Date(System.currentTimeMillis()));
		entityService.saveOrUpdate(cazeResult);
		return redirect("studentList", "info.save.success", "&lesson.id=" + lesson_id + "&experimentId=" + experiment_id + "&orderBy=student.code asc");
	}
	
	/**
	 * 查询结果，必要时生成初始结果
	 * @param experiment
	 * @return
	 */
	private CazeResult getResult(Experiment experiment, Student student) {
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student=:std and r.experiment=:exp", student, experiment));
		List<CazeResult> results = entityService.search(query);
		CazeResult result = null;
		if (results.isEmpty()) {
			result = new CazeResult();
			result.setExperiment(experiment);
			result.setStudent(student);
			entityService.saveOrUpdate(result);
		} else {
			result = results.get(0);
		}
		return result;
	}

	protected void editSetting(Entity entity) {
		Experiment experiment = (Experiment) entity;
		if (experiment.isVO()) {
			Long lessonId = getLong("lessonId");
			experiment.setLesson((Lesson) entityService.get(Lesson.class, lessonId));
		}
		addBaseCode("experimentTypes", ExperimentType.class);
		addBaseCode("analysisPhases", AnalysisPhase.class);
		put("analysisTables",
				(List) entityService.search(new EntityQuery(Analysis.class, "analysistable")));
		put("assessments",
				(List) entityService.search(new EntityQuery(Assessment.class, "assessment")));
	}

	protected void infoSetting(Entity entity) {
		addBaseCode("experimentTypes", ExperimentType.class);
		addBaseCode("analysisPhases", AnalysisPhase.class);
		put("analysisTables",
				(List) entityService.search(new EntityQuery(Analysis.class, "analysistable")));

	}

	
	@Override
	protected void configExportContext(Context context) {
		Long experimentId = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experimentId);
		context.put("experiment", experiment);

		EntityQuery choosequery = new EntityQuery(Experiment.class, "experiment");
		choosequery.add(new Condition("experiment.id=:experimentId", experimentId));
		/* 学生查询 */
		choosequery.join("left", "experiment.students", "student");
		String code = get("student.code");
		if (StringUtils.isNotBlank(code)) {
			choosequery.add(new Condition("student.code like :stdCode", "%" + code + "%"));
		}
		String name = get("student.name");
		if (StringUtils.isNotBlank(name)) {
			choosequery.add(new Condition("student.name like :stdName", "%" + name + "%"));
		}
		choosequery.setSelect("student");
		// choosequery.setLimit(getPageLimit());
		String orderBy = get(Order.ORDER_STR);
		if (null == orderBy) {
			orderBy = "student.code asc";
		}
		choosequery.addOrder(Order.parse(orderBy));
		List students = entityService.search(choosequery);
		context.put("students", students);
		
		Map cazeResults = new HashMap();
		for (Iterator iterator = students.iterator(); iterator
				.hasNext();) {
			Student student = (Student) iterator.next();
			CazeResult cazeResult = getResult(experiment, student);
			cazeResults.put(student.getId(), cazeResult);
		}
		context.put("cazeResults", cazeResults);

		EntityQuery query1 = new EntityQuery(StudyLog.class, "log");
		query1.add(new Condition("log.experiment.id=:experimentId", experimentId));
		query1.groupBy("log.std.id");
		query1.setSelect("log.std.id,sum(log.time)");
		List<Object[]> logtimes = entityService.search(query1);
		Map experimenttime = new HashMap();

		for (Object[] logtime : logtimes) {
			long time= (Long)logtime[1];
			long min=time/60;
			long sec=time%60;
			experimenttime.put(logtime[0], min+"分"+sec+"秒");
		}
		context.put("experimenttimes", experimenttime);
	}
	
	public String submitCheck() throws Exception {
		Long stdId = getLong("std.id");
		Long expId = getLong("experiment.id");
		Experiment experiment=(Experiment)entityService.get(Experiment.class, expId);
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student.id=:stdId and r.experiment.id=:expId", stdId, expId));
		List<CazeResult> results = entityService.search(query);
		CazeResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			String[] types = getValues("typeName");
			float sum = 0f;
			for (String type : types) {
				Float score = getFloat("label_"+type + "Score");
				String hql="from "+type+"Result r where r.student.id=:stdId and r.experiment.id=:expId";
				Map params=new HashMap();
				params.put("stdId", stdId);
				params.put("expId", expId);
				List<AnalysisForm> forms = entityService.searchHQLQuery(hql, params);
				Object form=null;
				if (forms.size() > 0) {
					form=forms.get(0);
					PropertyUtils.setProperty(form, "score", score);
					if (null != score) {
						sum += score;
					}
					entityService.saveOrUpdate(form);
				}else{
					System.out.println("dd");
				}
			}
			result.setScore(sum);
			entityService.saveOrUpdate(result);
			put("sum",sum);
		}
		return forward();
	}

	protected String saveAndForward(Entity entity) {
		Experiment experiment = (Experiment) entity;
		try {
			Long cazeId = getLong("caze.id");
			experiment.setCaze((Caze) entityService.load(Caze.class, cazeId));
			experiment.getMarks().clear();
			Long[] analysisIds = SeqStringUtil.transformToLong(get("analysisId"));
			if (null != analysisIds) {
				for (int i = 0; i < analysisIds.length; i++) {
					ExperimentMark mark = new ExperimentMark();
					mark.setExperiment(experiment);
					mark.setAnalysis((Analysis) entityService.get(Analysis.class, analysisIds[i]));
					mark.setMark(getFloat(analysisIds[i] + "mark"));
					experiment.getMarks().add(mark);
				}
			}
			saveOrUpdate(experiment);
			return redirect("index", "info.save.success", "&lesson.id="
					+ experiment.getLesson().getId());
		} catch (Exception e) {
			logger.error("saveAndForwad failure for:", e);
		}
		return redirect("index", "info.save.failure", "&lesson.id="
				+ experiment.getLesson().getId());
	}

	protected String removeAndForward(Collection experiments) {
		entityService.remove(experiments);
		return redirect("index", "info.delete.success");
	}

	public String experimentDetail() {
		return forward();
	}

	public String familyAnalysis() {

		return forward();
	}

	public String study() {

		return forward();
	}

	public String analysisTree() {

		return forward();
	}

	public String familyInfo() {

		return forward();
	}

	public String balanceSheet() {
		return forward();
	}

	public String instructionIndex() {
		Long experimentId = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experimentId);
		put("experiment", experiment);
		return forward();
	}

	public String browseMark() {
		return forward();
	}

	public String answers() {
		Long cazeId = getEntityId("caze");
		Caze caze = (Caze) entityService.load(Caze.class, cazeId);
		put("caze", caze);
		put("analysises", entityService.loadAll(Analysis.class));
		return forward();
	}

	public String answer() {
		Long cazeId = getEntityId("caze");
		String type = get("type");
		String phase = get("phase");
		if (StringUtils.isNotEmpty(type) && StringUtils.isNotEmpty(phase)) {
			EntityQuery query = new EntityQuery(getAnswerTypeName(phase, type), "a");
			query.add(new Condition("a.caze.id=:cazeId ", cazeId));
			List<AnalysisForm> answers = entityService.search(query);
			if (answers.size() > 0) {
				put("result", answers.get(0));
			}
			String needMembers = get("members");
			if (StringUtils.isNotBlank(needMembers)) {
				query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
				query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
				query.setSelect("memberAnswer.member");
				List<FamilyMember> members = entityService.search(query);
				Map membersMap = new HashMap();
				for (FamilyMember member : members) {
					membersMap.put(member.getName(), member);
				}
				put("membersMap", membersMap);
				put("members", members);
			}
		}
		return forward();
	}

	private String getResultTypeName(String phase, String type) {
		return "org.expr.model." + phase + ".result." + type + "Result";
	}

	private String getAnswerTypeName(String phase, String type) {
		return "org.expr.model." + phase + ".answer." + type + "Answer";
	}

	public String result() {
		Long stdId = getLong("std.id");
		Long expId = getEntityId("experiment");
		String type = get("type");
		String phase = get("phase");
		if (StringUtils.isNotEmpty(type) && StringUtils.isNotEmpty(phase)) {
			EntityQuery query = new EntityQuery(getResultTypeName(phase, type), "r");
			query.add(new Condition("r.student.id=:stdId and r.experiment.id=:expId", stdId, expId));
			List<AnalysisForm> results = entityService.search(query);
			if (results.size() > 0) {
				put("result", results.get(0));
			}
		}
		return forward();
	}
	


}
