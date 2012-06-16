package org.expr.web.action.plan.answer;

import java.util.List;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.BusinessLoans;
import org.expr.model.plan.answer.CarPlanAnswer;
import org.expr.model.plan.answer.LoanPayed;
import org.expr.service.loan.LoanCalculator;

/**
 * 购车规划
 * 
 * @author Administrator
 * 
 */
public class CarPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(CarPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<CarPlanAnswer> answers = entityService.search(query);
		CarPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = (CarPlanAnswer) answers.get(0);
		} else {
			answer = new CarPlanAnswer();
		}
		put("amount",answer.getExpenses());
		put("answer", answer);
		return forward();
	}

	private CarPlanAnswer getCarPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(CarPlanAnswer.class, "plan");
		query.add(new Condition("plan.caze.id=:cazeId", cazeId));
		List<CarPlanAnswer> answers = entityService.search(query);
		CarPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new CarPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String save() {
		Long cazeId = getLong("caze.id");
		CarPlanAnswer answer = getCarPlanAnswer(cazeId);
		answer.getLoans().clear();
		String payType = get("payType");
		String loanType = get("loanType");
		double capital = getFloat("capital").doubleValue();
		answer.setBusinessCapital(capital);
		double rate = getFloat("rate").doubleValue();
		rate = rate / 100;
		Integer years = getInteger("years");
		Integer startYear = getInteger("startYear");
		LoanPayed[] pays = calc(capital, rate, years, payType);
		for (int i = 0; i < years; i++) {
			BusinessLoans loans = answer.getLoans().get(startYear + i);
			if (null == loans) {
				loans = new BusinessLoans();
				answer.getLoans().put(startYear + i, loans);
			}
			capital = capital - pays[i].getCapital().floatValue();
			loans.setBusiness(pays[i]);
			loans.setCapital(capital);
		}
		entityService.saveOrUpdate(answer);
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
			pays = LoanCalculator.averageCapitalInterest(capital, month, monthRate);
		} else if (type.equals("averageCapital")) {
			pays = LoanCalculator.averageCapital(capital, month, monthRate);
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
		Long cazeId = getLong("caze.id");
		CarPlanAnswer answer = getCarPlanAnswer(cazeId);
		put("answer", answer);
		return forward();
	}
	
	public String carForm() {
		Long cazeId = getLong("caze.id");
		CarPlanAnswer answer = getCarPlanAnswer(cazeId);
		put("answer", answer);
		return forward();
	}
	
	public String saveCarForm() {
		Long cazeId = getLong("caze.id");
		CarPlanAnswer answer = getCarPlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		answer.setCarCapital(expense);
		Float rate = getFloat("rate");
		Float amount = getFloat("amount");
		while (startYear <= endYear) {
			if (Double.compare(expense, 0F) <= 0) {
				answer.getExpenses().remove(startYear);
			} else {
				answer.getExpenses().put(startYear, expense);
			}
			
			expense = calcExpense(expense, rate, amount);
			startYear++;
		}
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		CarPlanAnswer answer = getCarPlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	
	private double calcExpense(Double expense, Float rate, Float amount) {
		if (null == rate) {
			return expense + amount;
		} else {
			return rate * expense + expense;
		}
	}
	
	public String info() {
		index();
		return forward();
	}

}
