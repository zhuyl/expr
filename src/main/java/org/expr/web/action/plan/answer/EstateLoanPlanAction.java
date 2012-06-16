package org.expr.web.action.plan.answer;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.plan.answer.EstateLoanPlanAnswer;
import org.expr.model.plan.answer.LoanPayed;
import org.expr.model.plan.answer.Loans;
import org.expr.service.loan.LoanCalculator;

/**
 * 房产规划
 * 
 * @author Administrator
 * 
 */
public class EstateLoanPlanAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(EstateLoanPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<EstateLoanPlanAnswer> answers = entityService.search(query);
		EstateLoanPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = (EstateLoanPlanAnswer) answers.get(0);
		} else {
			answer = new EstateLoanPlanAnswer();
		}
		put("amount",answer.getExpenses());
		put("answer", answer);
		return forward();
	}

	private EstateLoanPlanAnswer getEstateLoanPlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(EstateLoanPlanAnswer.class, "plan");
		query.add(new Condition("plan.caze.id=:cazeId", cazeId));
		List<EstateLoanPlanAnswer> answers = entityService.search(query);
		EstateLoanPlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new EstateLoanPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}
/**贷款*/
	public String save() {
		Long cazeId = getLong("caze.id");
		EstateLoanPlanAnswer answer = getEstateLoanPlanAnswer(cazeId);
		String payType = get("payType");
		String loanType =get("loanType");
		double capital=getFloat("capital").doubleValue();


//		if (StringUtils.equals(loanType, "business")) {
//			answer.setBusinessCapital(capital);
//			for (int i=0;i<answer.getLoans().size();i++)
//			{
//				answer.getLoans().get(i).setBusinessCapital(0.0);
//				answer.getLoans().get(i).setBusiness(new LoanPayed());
//			}
//			
//		} else {
//			answer.setAccumulationCapital(capital);
//			for (int i=0;i<answer.getLoans().size();i++)
//			{
//				answer.getLoans().get(i).setAccumulationCapital(0.0);
//				answer.getLoans().get(i).setAccumulation(new LoanPayed());
//			}
//		}
		Double rate = getFloat("rate").doubleValue();
		rate = rate / 100;
		Integer years = getInteger("years");
		Integer startYear = getInteger("startYear");
		LoanPayed[] pays = calc(capital, rate, years, payType);
		for (int i = 0; i < years; i++) {
			Loans loans = answer.getLoans().get(startYear + i);
			if (null == loans) {
				loans = new Loans();
				answer.getLoans().put(startYear + i, loans);
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
		EstateLoanPlanAnswer answer = getEstateLoanPlanAnswer(cazeId);
		//put("answer", answer);
		String loanType = get("loanType");
		if (StringUtils.equals(loanType, "business")) {
			put("total", answer.getBusinessCapital());
		}else {
			put("total", answer.getAccumulationCapital());
		}
		return forward();
	}
	
	public String houseForm() {
		Long cazeId = getLong("caze.id");
		EstateLoanPlanAnswer answer = getEstateLoanPlanAnswer(cazeId);
		put("answer", answer);
		return forward();
	}
	
	public String saveHouseForm() {
		Long cazeId = getLong("caze.id");
		EstateLoanPlanAnswer answer = getEstateLoanPlanAnswer(cazeId);
		int startYear = getInteger("startYear");
		int endYear = getInteger("endYear");
		Double expense = getFloat("expense").doubleValue();
		answer.setHouseCapital(expense);
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
		EstateLoanPlanAnswer answer = getEstateLoanPlanAnswer(cazeId);
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
