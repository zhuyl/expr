package org.expr.web.action.plan.result;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.EstateLoanPlanResult;
import org.expr.model.plan.result.LoanPayed;
import org.expr.model.plan.result.Loans;
import org.expr.service.loan.LoanCalculatorResult;

import com.ekingstar.eams.student.Student;

/**
 * 房产规划
 * 
 * @author Administrator
 * 
 */
public class EstateLoanPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(EstateLoanPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));			
		addStdCondition(query, "result",getLoginStudent());
		List<EstateLoanPlanResult> results = entityService.search(query);
		EstateLoanPlanResult result = null;
		if (!results.isEmpty()) {
			result = (EstateLoanPlanResult) results.get(0);
		} else {
			result = new EstateLoanPlanResult();
		}
		put("amount",result.getExpenses());
		put("result", result);
		return forward();
	}

	private EstateLoanPlanResult getEstateLoanPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(EstateLoanPlanResult.class, "plan");
		query.add(new Condition("plan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("plan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "plan",std);		
		List<EstateLoanPlanResult> results = entityService.search(query);
		EstateLoanPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new EstateLoanPlanResult();
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
			entityService.saveOrUpdate(result);
		}
		return result;
	}
/**贷款*/
	public String save() {
		Long experimentId = getLong("experiment.id");
		EstateLoanPlanResult result = getEstateLoanPlanResult(experimentId);
		String payType = get("payType");
		String loanType =get("loanType");
		double capital=getFloat("capital").doubleValue();

		
//		if (StringUtils.equals(loanType, "business")) {
//		result.setBusinessCapital(capital);
//		for (int i=1;i<=getPlanYears();i++)
//		{
//			result.getLoans().get(i).setBusinessCapital(0d);
//			result.getLoans().get(i).setBusiness(new LoanPayed());
//		}
//		
//	} else {
//		result.setAccumulationCapital(capital);
//		for (int i=1;i<getPlanYears();i++)
//		{
//			result.getLoans().get(i).setAccumulationCapital(0d);
//			result.getLoans().get(i).setAccumulation(new LoanPayed());
//		}
//	}
		
		Integer startYear = getInteger("startYear");
		Integer years = getInteger("years");
		Double rate = getFloat("rate").doubleValue();
		rate = rate / 100;
		
		
		LoanPayed[] pays = calc(capital, rate, years, payType);
		for (int i = 0; i < years; i++) {
			Loans loans = result.getLoans().get(startYear + i);
			if (null == loans) {
				loans = new Loans();
				result.getLoans().put(startYear + i, loans);
			}
			if (StringUtils.equals(loanType, "business")) {
				capital = (capital - pays[i].getCapital().floatValue());
				loans.setBusiness(pays[i]);
				loans.setBusinessCapital(capital);
			} else {
				capital = (capital - pays[i].getCapital().floatValue());
				loans.setAccumulation(pays[i]);
				loans.setAccumulationCapital(capital);
			}
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success");
	}

	/**
	 * 计算等额本息
	 * 
	 * @param capital
	 * @param rate
	 * @param years
	 * @return
	 */
	private LoanPayed[] calc(double capital, double rate, Integer years, String type) {
		int month = years * 12;
		double monthRate = rate / 12;
		LoanPayed[] pays = null;
		if (type.equals("averageCapitalInterest")) {
			pays = LoanCalculatorResult.averageCapitalInterest(capital, month, monthRate);
		} else if (type.equals("averageCapital")) {
			pays = LoanCalculatorResult.averageCapital(capital, month, monthRate);
		}
		return accumulateToYear(pays);
	}

	private LoanPayed[] accumulateToYear(LoanPayed[] monthPayed) {
		LoanPayed[] yearPayed = new LoanPayed[monthPayed.length / 12];
		for (int i = 0; i < yearPayed.length; i++) {
			yearPayed[i] = new LoanPayed();
			for (int j = 0; j < 12; j++) {
				yearPayed[i].add(monthPayed[i * 12 + j]);
			}
		}
		return yearPayed;
	}

	public String edit() {
		Long experimentId = getLong("experiment.id");
		EstateLoanPlanResult result = getEstateLoanPlanResult(experimentId);
		//put("result", result);
		String loanType = get("loanType");
		if (StringUtils.equals(loanType, "business")) {
			put("total", result.getBusinessCapital());
		}else {
			put("total", result.getAccumulationCapital());
		}
		return forward();
	}
	
	public String houseForm() {
		Long experimentId = getLong("experiment.id");
		EstateLoanPlanResult result = getEstateLoanPlanResult(experimentId);
		put("result", result);
		return forward();
	}
	
	public String saveHouseForm() {
		Long experimentId = getLong("experiment.id");
		EstateLoanPlanResult result = getEstateLoanPlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		result.setHouseCapital(expense);
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				result.getExpenses().remove(startYear);
			} else {
				result.getExpenses().put(startYear, expense);
			}
			
			expense = calcExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		EstateLoanPlanResult result = getEstateLoanPlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
	
	private double calcExpense(Double expense, Float rate, Float amount) {
		if (null == rate) {
			return expense + amount;
		} else {
			return rate * expense + expense;
		}
	}

}
