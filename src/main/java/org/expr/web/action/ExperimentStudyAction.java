package org.expr.web.action;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FundsAnalysis;
import org.expr.model.analysis.answer.FundsAnalysisAnswer;
import org.expr.model.analysis.answer.FundsAssetAnswer;
import org.expr.model.analysis.answer.FundsLiabilityAnswer;
import org.expr.model.analysis.result.CazeResult;
import org.expr.model.basecode.Analysis;
import org.expr.model.basecode.AssetProject;
import org.expr.model.basecode.BenefitRelation;
import org.expr.model.basecode.LiabilityProject;
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.Lesson;
import org.expr.model.lesson.StudyLog;

import com.ekingstar.eams.basecode.nation.Gender;
import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class ExperimentStudyAction extends BaseAction {

	public String index() {
		EntityQuery query = new EntityQuery(Experiment.class, "experiment");
		Long lesson_id = getLong("lesson.id");
		query.add(new Condition("experiment.lesson.id=:lessonid", lesson_id));
		/* 找到学生已选择的学习任务 */
		query.join("experiment.students", "student");
		query.add(new Condition("student.code=:stdCode", getLoginName()));

		List experiments = entityService.search(query);
		put("experiments", experiments);

		EntityQuery query1 = new EntityQuery(StudyLog.class, "log");
		query1.add(new Condition("log.std.code=:stdCode", getLoginName()));
		query1.add(new Condition("log.experiment.lesson.id=:lessonId", lesson_id));
		query1.groupBy("log.experiment.id");
		query1.setSelect("log.experiment.id,sum(log.time)");
		List<Object[]> logtimes = entityService.search(query1);
		Map experimenttime = new HashMap();

		for (Object[] logtime : logtimes) {
			experimenttime.put(logtime[0].toString(), logtime[1]);
		}
		put("experimenttimes", experimenttime);

		EntityQuery querylesson = new EntityQuery(Lesson.class, "lesson");
		querylesson.add(new Condition("lesson.id=:lessonid", lesson_id));
		List lessons = entityService.search(querylesson);
		put("lessons", lessons);
		Date present = new Date();
		put("currentTime", present);

		/* 可选任务:选择结束日期大于当前日期，学生尚未选择的，该课程的任务 */
		EntityQuery choosequery = new EntityQuery(Experiment.class, "experiment");
		choosequery.add(new Condition("experiment.lesson.id=:lessonid", lesson_id));
		choosequery.add(new Condition("experiment.endAt>:present", present));
		choosequery.add(new Condition(
				"not exists(from experiment.students student where student.code =:stdCode)",
				getLoginName()));

		List chooseexperiments = entityService.search(choosequery);
		put("chooseexperiments", chooseexperiments);
		
		Map cazeResults = new HashMap();
		for (Iterator iterator = experiments.iterator(); iterator
				.hasNext();) {
			Experiment experiment = (Experiment) iterator.next();
			CazeResult cazeResult = getResult(experiment);
			cazeResults.put(experiment.getId(), cazeResult);
		}
		put("cazeResults", cazeResults);
		return forward();
	}
	
	public String submitAnswer() {
		Long lesson_id = getLong("lesson.id");
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		CazeResult cazeResult = getResult(experiment);
		cazeResult.setIsSubmit(Boolean.TRUE);
		cazeResult.setSubmitAt(new Date(System.currentTimeMillis()));
		entityService.saveOrUpdate(cazeResult);
		return redirect("index", "info.save.success", "&lesson.id=" + lesson_id);
	}
	
	/**
	 * 查询结果，必要时生成初始结果
	 * @param experiment
	 * @return
	 */
	private CazeResult getResult(Experiment experiment) {
		Student std = getLoginStudent();
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student=:std and r.experiment=:exp", std, experiment));
		List<CazeResult> results = entityService.search(query);
		CazeResult result = null;
		if (results.isEmpty()) {
			result = new CazeResult();
			result.setExperiment(experiment);
			result.setStudent(std);
			entityService.saveOrUpdate(result);
		} else {
			result = results.get(0);
		}
		return result;
	}

	public String form() {
		return forward();
	}

	// 家庭基本信息添加
	public String editFamilyInfo() {
		put("Genders", entityService.search(new EntityQuery(Gender.class, "Gender")));
		put("BenefitRealtion",
				entityService.search(new EntityQuery(BenefitRelation.class, "BenefitRelation")));
		return forward();
	}

	public String familyInfo() {
		return forward();
	}

	public String answers() {
		Long expId = getEntityId("experiment");
		Experiment exp = (Experiment) entityService.get(Experiment.class, expId);
		put("experiment", exp);
		return forward();
	}

	/**
	 * 资产负债表
	 * 
	 * @return
	 */
	public String balanceSheet() {
		FundsAnalysisAnswer answer = new FundsAnalysisAnswer();
		EntityQuery query = new EntityQuery(FundsAnalysisAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=" + getLong("caze.id")));
		List answers = entityService.search(query);
		if (!answers.isEmpty()) {
			answer = (FundsAnalysisAnswer) answers.get(0);
		}
		put("answer", answer);
		addBaseCode("assetProjects", AssetProject.class);
		addBaseCode("liabilityProjects", LiabilityProject.class);

		Map assetMap = new HashMap();
		Map liabilityMap = new HashMap();
		if (null != answer.getForm()) {
			for (Iterator iterator = answer.getForm().getAssets().iterator(); iterator.hasNext();) {
				FundsAssetAnswer assetAnswer = (FundsAssetAnswer) iterator.next();
				assetMap.put(assetAnswer.getAsset().getAssetProject().getId().toString(),
						assetAnswer.getAsset().getAmount());
			}
			for (Iterator iterator = answer.getForm().getLiabilities().iterator(); iterator
					.hasNext();) {
				FundsLiabilityAnswer assetAnswer = (FundsLiabilityAnswer) iterator.next();
				liabilityMap.put(assetAnswer.getLiability().getLiabilityProject().getId()
						.toString(), assetAnswer.getLiability().getAmount());
			}
		}
		put("assetMap", assetMap);
		put("liabilityMap", liabilityMap);
		return forward();
	}

	public String saveBalanceSheet() {
		// 将数据库对象和页面上以'answer'开头的数据合并到answer对象中
		FundsAnalysisAnswer answer = (FundsAnalysisAnswer) populateEntity(
				FundsAnalysisAnswer.class, "answer");
		List assets = baseCodeService.getCodes(AssetProject.class);
		if (null == answer.getForm()) {
			answer.setForm(new FundsAnalysis());
		}
		answer.getForm().getAssets().clear();
		for (Iterator iterator = assets.iterator(); iterator.hasNext();) {
			AssetProject project = (AssetProject) iterator.next();
			FundsAssetAnswer assetAnswer = new FundsAssetAnswer();
			assetAnswer.setAnswer(answer);
			assetAnswer.getAsset().setAssetProject(project);
			assetAnswer.getAsset().setAmount(getFloat("assetProject" + project.getId()));
			answer.getForm().getAssets().add(assetAnswer);
		}
		saveOrUpdate(answer);
		return redirect("balanceSheet", "info.save.success");
	}

	public String addExperiment() {
		String lessonId = get("lesson.id");
		try {

			String experimentIdString = get("chooseexperimentId");
			Long[] experimentIds = SeqStringUtil.transformToLong(experimentIdString);
			for (int i = 0; i < experimentIds.length; i++) {
				List studentList = (List) entityService.load(Student.class, "code", getLoginName());
				if (null != studentList && studentList.size() != 0) {
					Student student = (Student) studentList.get(0);
					Experiment experiment = (Experiment) entityService.load(Experiment.class,
							experimentIds[i]);
					if (!experiment.getStudents().contains(student)) {
						experiment.getStudents().add(student);
					}
					saveOrUpdate(experiment);
				}
			}
			return redirect("index", "info.save.success", "&lesson.id=" + lessonId);
		} catch (Exception e) {
			logger.info("saveAndForwad failure for:", e);
		}
		return redirect("index", "info.save.failure", "&lesson.id=" + lessonId);
	}

	public String result() throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		Student std = this.getLoginStudent();
		Long expId = getLong("experiment.id");
		Experiment exp=(Experiment)entityService.get(Experiment.class, expId);
		put("experiment",exp);
		EntityQuery query = new EntityQuery(CazeResult.class, "r");
		query.add(new Condition("r.student=:std",std));
		query.add(new Condition("r.experiment.id=:experimentId",expId));		
		List<CazeResult> results = entityService.search(query);
		List<Analysis> analysisTalbes=entityService.loadAll(Analysis.class);
		Map<String,Float> ScoreMap=new HashMap();
		CazeResult result = null;
		if (results.size() > 0) {
			result = results.get(0);
			put("result", result);
			//取各分析表得分
			for (int i=0;i<analysisTalbes.size();i++){
				Analysis analysisTalbe=analysisTalbes.get(i);
				if (exp.getMark(analysisTalbe)!=null)
				{
					String hql="from "+analysisTalbe.getEngName()+"Result r where r.student=:std and r.experiment.id=:expId";
					Map params=new HashMap();
					params.put("std", std);
					params.put("expId", expId);
					Float score=0f;
					String remark=new String();
					List forms = entityService.searchHQLQuery(hql, params);
					if(forms.size()>0){
						 Object form=forms.get(0);	
						 score=(Float)PropertyUtils.getProperty(form,"score");
					}
					ScoreMap.put(analysisTalbe.getEngName(), score);
				}
			}
			put("ScoreMap",ScoreMap);
		}
		return forward();
	}
	
	public String insuranceDetail() {

		return forward();
	}

	public String incomeExpense() {

		return forward();
	}

	public String riskCapacity() {

		return forward();
	}

	public String clientAnalysis() {

		return forward();
	}

	public String aimAnalysis() {

		return forward();
	}

	public String cashPlan() {

		return forward();
	}

	public String expensePlan() {

		return forward();
	}

	public String educationPlan() {

		return forward();
	}

	public String taxPlan() {

		return forward();
	}

	public String retirementPlan() {

		return forward();
	}

	public String investmentPlan() {

		return forward();
	}

	public String inheritancePlan() {

		return forward();
	}

	public String housePlan() {

		return forward();
	}

	public String comprehensivePlan() {

		return forward();
	}

	public String dynamicBalance() {

		return forward();
	}

	public String schemeEvaluation() {

		return forward();
	}

	public String expStudyRecord() {

		return forward();
	}

	public String browseAnswer() {
		return forward();
	}

	public String browseMark() {
		return forward();
	}

	public String curStudyRecord() {
		return forward();
	}

	public String curStudyRecordindex() {
		return forward();
	}

	public String curNotice() {
		return forward();
	}

}
