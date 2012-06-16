package org.expr.web.action.analysis.result;

import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FinanceAssetAnalysis;
import org.expr.model.analysis.result.FinanceAssetAnalysisResult;
import org.expr.model.analysis.result.FinanceAssetResult;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RatePayPeriod;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class FinanceAssetAnalysisAction extends AbstractAnalysisResultAction {

	public String index() {
		return search();
	}
	
	public String search() {
		Long experimentid = getLong("experiment.id");
		FinanceAssetAnalysisResult analysisResult=getFinanceAssetAnalysisResult();
		EntityQuery query = new EntityQuery(FinanceAssetResult.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.result.experiment.id=:experimentid", experimentid));
		addStdCondition(query, "asset.result",getLoginStudent());
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		if(get("nopage")==null){
		query.setLimit(getPageLimit());
		}// 加分页，否则删除会有误
		put("results", entityService.search(query));
		put("analysisResult",analysisResult);
		return forward();
	}

	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}

	public void editSetting(Entity entity) {
		put("FinanceTypes", getTopFinanceTypes());
		put("Mobilities", entityService.loadAll(Mobility.class));
		put("RiskGrades", entityService.loadAll(RiskGrade.class));
		put("RatePayPeriods", entityService.loadAll(RatePayPeriod.class));
	}

	protected FinanceAssetAnalysisResult getFinanceAssetAnalysisResult() {
		EntityQuery query = new EntityQuery(FinanceAssetAnalysisResult.class, "result");
		Long experimentId = getLong("experiment.id");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);		
		List results = entityService.search(query);
		FinanceAssetAnalysisResult result = null;
		if (results.isEmpty()) {
			result = new FinanceAssetAnalysisResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}		
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
			result.setForm(new FinanceAssetAnalysis());
			entityService.saveOrUpdate(result);
		} else {
			result = (FinanceAssetAnalysisResult) results.get(0);
		}
		return result;
	}

	@Override
	protected String saveAndForward(Entity entity) {
		FinanceAssetResult result = (FinanceAssetResult) entity;
		if (null == result.getResult()) {
			result.setResult(getFinanceAssetAnalysisResult());
		}
		return super.saveAndForward(entity);
	}
	
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		FinanceAssetAnalysisResult result = getFinanceAssetAnalysisResult();
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("search", "info.save.success", "&experiment.id=" + experimentId);
	}

}