package org.expr.web.action.analysis.result;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.BalanceOfPayment;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.ExpendResult;
import org.expr.model.analysis.result.IncomeResult;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

/**
 * 月度收支表
 * 
 * @return
 */
public class IncomeExpenseAction extends AbstractAnalysisResultAction {
	
	public String index() {
		BalanceOfPaymentResult result = getIncomeExpenseResult();
		put("result", result);
		addBaseCode("incomeProjects", IncomeProject.class);
		addBaseCode("expendProjects", ExpendProject.class);

		Map incomeMap = new HashMap();
		Map expendMap = new HashMap();
		if (null != result.getForm()) {
			for (Iterator iterator = result.getForm().getIncomes().iterator(); iterator.hasNext();) {
				IncomeResult incomeResult = (IncomeResult) iterator.next();
				incomeMap.put(incomeResult.getIncome().getIncomeProject().getId().toString(),
						incomeResult.getIncome().getAmount());
			}
			for (Iterator iterator = result.getForm().getExpends().iterator(); iterator.hasNext();) {
				ExpendResult expendResult = (ExpendResult) iterator.next();
				expendMap.put(expendResult.getExpend().getExpendProject().getId().toString(),
						expendResult.getExpend().getAmount());
			}
		}
		
		put("incomeMap", incomeMap);
		put("expendMap", expendMap);
		put("analysisResult", result);
		return forward();
	}

	/** 将数据库对象和页面上以'result'开头的数据合并到result对象中 */
	public String saveIncomeExpense() {
		BalanceOfPaymentResult result = (BalanceOfPaymentResult) populateEntity(
				BalanceOfPaymentResult.class, "result");
		if (null == result.getForm()) {
			result.setForm(new BalanceOfPayment());
		}
		List incomes = baseCodeService.getCodes(IncomeProject.class);
		result.getForm().getIncomes().clear();
		for (Iterator iterator = incomes.iterator(); iterator.hasNext();) {
			IncomeProject project = (IncomeProject) iterator.next();
			IncomeResult incomeResult = new IncomeResult();
			incomeResult.setResult(result);
			incomeResult.setIncome(new Income());
			incomeResult.getIncome().setIncomeProject(project);
			incomeResult.getIncome().setAmount(getFloat("incomeProject" + project.getId()));
			result.getForm().getIncomes().add(incomeResult);
		}
		List expends = baseCodeService.getCodes(ExpendProject.class);
		result.getForm().getExpends().clear();
		for (Iterator iterator = expends.iterator(); iterator.hasNext();) {
			ExpendProject project = (ExpendProject) iterator.next();
			ExpendResult expendResult = new ExpendResult();
			expendResult.setExpend(new Expend());
			expendResult.setResult(result);
			expendResult.getExpend().setExpendProject(project);
			expendResult.getExpend().setAmount(getFloat("expendProject" + project.getId()));
			result.getForm().getExpends().add(expendResult);
		}
		saveOrUpdate(result);
		return redirect("index", "info.save.success");
	}

	protected BalanceOfPaymentResult getIncomeExpenseResult() {
		EntityQuery query = new EntityQuery(BalanceOfPaymentResult.class, "result");
		Long experimentId = getLong("experiment.id");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List results = entityService.search(query);
		BalanceOfPaymentResult result = null;
		if (results.isEmpty()) {
			result = new BalanceOfPaymentResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
			result.setForm(new BalanceOfPayment());
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}
			if (std==null){
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
			entityService.saveOrUpdate(result);
		} else {
			result = (BalanceOfPaymentResult) results.get(0);
		}
		return result;
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		BalanceOfPaymentResult result = getIncomeExpenseResult();
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

}