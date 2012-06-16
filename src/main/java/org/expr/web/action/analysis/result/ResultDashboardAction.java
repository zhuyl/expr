package org.expr.web.action.analysis.result;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.result.CazeResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.lesson.ExperimentMark;
import org.expr.model.lesson.StudyLog;

import com.ekingstar.eams.student.Student;
import com.opensymphony.xwork2.ActionContext;

/**
 * 答案管理界面
 * 
 * @author Administrator
 * 
 */
public class ResultDashboardAction extends AbstractAnalysisResultAction {

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
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);
			entityService.saveOrUpdate(result);
		} else {
			result = results.get(0);
		}
		return result;
	}

	public String index() {
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		getResult(experiment);
		Set analysisSet = new HashSet();
		for (Iterator iter = experiment.getMarks().iterator(); iter.hasNext();) {
			ExperimentMark mark = (ExperimentMark) iter.next();
			analysisSet.add(mark.getAnalysis().getCode());
		}
		put("analysisSet", analysisSet);
		put("experimentId", experiment_id);
		Long existExperimentId = (Long) ActionContext.getContext().getSession().get("experimentId");
		if (null != existExperimentId) {
			if (!existExperimentId.equals(experiment_id)) {// 允许同时打开一个练习，不同的案例要求关闭上一个练习
				Experiment existExperiment = (Experiment) entityService.load(Experiment.class,
						existExperimentId);
				put("existExperiment", existExperiment);
				return forward("existExperiment");
			}
		} else {
			ActionContext.getContext().getSession().put("experimentId", experiment_id);
			ActionContext.getContext().getSession().put("startAt", new Date());
		}
		return forward();
	}
	
	public String analysisTree() {
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		Set analysisSet = new HashSet();
		Set analysisPhaseSet = new HashSet();
		for (Iterator iter = experiment.getMarks().iterator(); iter.hasNext();) {
			ExperimentMark mark = (ExperimentMark) iter.next();
			analysisSet.add(mark.getAnalysis().getCode());
			analysisPhaseSet.add(mark.getAnalysis().getPhase().getCode());
		}
		put("analysisSet", analysisSet);
		put("analysisPhaseSet", analysisPhaseSet);
		put("cazeId", experiment.getCaze().getId());
		put("experiment", experiment);
		return forward();
	}

	public String studyLogs() {
		EntityQuery query = new EntityQuery(StudyLog.class, "log");
		query.add(new Condition("log.std.code=:stdCode", getLoginName()));
		query.add(new Condition("log.experiment.id=:experimentId", getLong("experimentId")));
		query.addOrder(Order.asc("log.startAt"));
		List rs = (List) entityService.search(query);
		put("logs", rs);
		return forward();
	}

	public String endStudy() {
		Long existExperimentId = (Long) ActionContext.getContext().getSession().get("experimentId");
		if (null != existExperimentId) {
			Experiment experiment = (Experiment) entityService.load(Experiment.class,
					existExperimentId);
			Date finishAt = new Date();
			StudyLog log = new StudyLog();
			log.setStd(getLoginStudent());
			log.setIp(getRemoteAddr());
			Date startAt = (Date) ActionContext.getContext().getSession().get("startAt");
			log.setStartAt(startAt);
			log.setExperiment(experiment);
			log.setFinishAt(finishAt);
			log.setTime((finishAt.getTime() - startAt.getTime()) / 1000);
			entityService.saveOrUpdate(log);
			ActionContext.getContext().getSession().remove("experimentId");
			ActionContext.getContext().getSession().remove("startAt");
		}
		return forward();
	}

	public String experimentDetail() {
		Long experiment_id = getLong("experimentId");
		Experiment experiment = (Experiment) entityService.load(Experiment.class, experiment_id);
		put("experiment", experiment);
		return forward();
	}
}
