package org.expr.web.action.plan.result;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.BusinessLoans;
import org.expr.model.plan.result.CarPlanResult;
import org.expr.model.plan.result.LoanPayed;
import org.expr.service.loan.LoanCalculatorResult;

import com.ekingstar.eams.student.Student;

/**
 * 购车规划
 * 
 * @author Administrator
 * 
 */
public class CarPlanAction extends AbstractPlanResultAction {

	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(CarPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result",getLoginStudent());
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));	
		List<CarPlanResult> results = entityService.search(query);
		CarPlanResult result = null;
		if (!results.isEmpty()) {
			result = (CarPlanResult) results.get(0);
		} else {
			result = new CarPlanResult();
		}
		put("amount",result.getExpenses());
		put("result", result);
		return forward();
	}

	private CarPlanResult getCarPlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(CarPlanResult.class, "plan");
		query.add(new Condition("plan.experiment.id=:experimentId", experimentId));
		Student std=getLoginStudent();
		addStdCondition(query, "plan",std);
		//query.add(new Condition("plan.student.code=:stdCode", getLoginName()));		
		List<CarPlanResult> results = entityService.search(query);
		CarPlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new CarPlanResult();
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

	public String save() {
		Long experimentId = getLong("experiment.id");
		CarPlanResult result = getCarPlanResult(experimentId);
		result.getLoans().clear();
		String payType = get("payType");
		String loanType = get("loanType");
		double capital = getFloat("capital").doubleValue();
		result.setBusinessCapital(capital);
		double rate = getFloat("rate").doubleValue();
		rate = rate / 100;
		Integer years = getInteger("years");
		Integer startYear = getInteger("startYear");
		LoanPayed[] pays = calc(capital, rate, years, payType);
		for (int i = 0; i < years; i++) {
			BusinessLoans loans = result.getLoans().get(startYear + i);
			if (null == loans) {
				loans = new BusinessLoans();
				result.getLoans().put(startYear + i, loans);
			}
			capital = capital - pays[i].getCapital().floatValue();
			loans.setBusiness(pays[i]);
			loans.setCapital(capital);
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
		CarPlanResult result = getCarPlanResult(experimentId);
		put("result", result);
		return forward();
	}
	
	public String carForm() {
		Long experimentId = getLong("experiment.id");
		CarPlanResult result = getCarPlanResult(experimentId);
		put("result", result);
		return forward();
	}
	
	public String saveCarForm() {
		Long experimentId = getLong("experiment.id");
		CarPlanResult result = getCarPlanResult(experimentId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		result.setCarCapital(expense);
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
		CarPlanResult result = getCarPlanResult(experimentId);
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
