package org.expr.web.action.plan.result;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;
import org.expr.model.plan.result.BonusPlanResult;
import org.expr.model.plan.result.CarPlanResult;
import org.expr.model.plan.result.CashPlanResult;
import org.expr.model.plan.result.ConsumePlanResult;
import org.expr.model.plan.result.EducationPlanResult;
import org.expr.model.plan.result.EstateLoanPlanResult;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.InsurancePlanPolicyResult;
import org.expr.model.plan.result.MedicalPlanResult;
import org.expr.model.plan.result.MemberBonusPlanResult;
import org.expr.model.plan.result.MemberCashPlanResult;
import org.expr.model.plan.result.MemberEducationPlanResult;
import org.expr.model.plan.result.MemberMedicalPlanResult;
import org.expr.model.plan.result.OtherExpensePlanResult;
import org.expr.model.plan.result.OtherIncomePlanResult;
import org.expr.model.plan.result.TripPlanResult;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;
import com.opensymphony.xwork2.ActionContext;

public class AbstractPlanResultAction extends BaseAction {

	public int getPlanYears() {
		return 30;
	}

	protected Student getLoginStudent() {
		String loginName = getLoginName();
		if (null == loginName)
			return null;
		else {
			Map<String, Student> stdMap = (Map<String, Student>) ServletActionContext.getRequest()
					.getAttribute("_stds");
			if (null == stdMap) {
				stdMap = new HashMap();
				ServletActionContext.getRequest().setAttribute("_stds", stdMap);
			}
			if (!stdMap.containsKey(loginName)) {
				Student std = null;
				List stds = entityService.load(Student.class, "code", loginName);
				if (!stds.isEmpty())
					std = (Student) stds.get(0);
				stdMap.put(loginName, std);
			}
			return stdMap.get(loginName);
		}
	}

	protected void addStdCondition(EntityQuery query, String prefix, Student std) {
		if (null == std) {
			query.add(new Condition(prefix + ".student.id=:stdId", getLong("std.id")));
		} else {
			query.add(new Condition(prefix + ".student=:std", std));
		}
	}

	/** 返回第year年的工资 */
	/** 工资收入map */
	public Double getYearCashes(Experiment experiment, Integer year) {
		CashPlanResult cashresult = (CashPlanResult) ActionContext.getContext().get("_cashresult");
		if (null == cashresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(CashPlanResult.class, "cashPlan");
			query.add(new Condition("cashPlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "cashPlan", getLoginStudent());
			List<CashPlanResult> cashresults = entityService.search(query);
			if (!cashresults.isEmpty()) {
				cashresult = cashresults.get(0);
			} else {
				cashresult = new CashPlanResult();
			}
			ActionContext.getContext().put("_cashresult", cashresult);
		}
		double cash = 0;
		for (MemberCashPlanResult memberResult : cashresult.getMembers()) {
			if (memberResult.getSalaries() == null || memberResult.getSalaries().get(year) == null) {
				cash = cash + 0;
			} else {
				cash = cash + memberResult.getSalaries().get(year);
			}
		}
		return cash;
	}

	/** 返回第year年的奖金 */
	/*** 奖金收入map */
	public Double getYearBonuses(Experiment experiment, Integer year) {
		BonusPlanResult bonusresult = (BonusPlanResult) ActionContext.getContext().get(
				"_bonusresult");
		if (null == bonusresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(BonusPlanResult.class, "bonusPlan");
			query.add(new Condition("bonusPlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "bonusPlan", getLoginStudent());
			List<BonusPlanResult> bonusresults = entityService.search(query);
			if (!bonusresults.isEmpty()) {
				bonusresult = bonusresults.get(0);
			} else {
				bonusresult = new BonusPlanResult();
			}
			ActionContext.getContext().put("_bonusresult", bonusresult);
		}
		double bonuse = 0;
		for (MemberBonusPlanResult memberResult : bonusresult.getMembers()) {
			if (memberResult.getBonuses() == null || memberResult.getBonuses().get(year) == null) {
				bonuse = bonuse + 0;
			} else {
				bonuse = bonuse + memberResult.getBonuses().get(year);
			}
		}

		return bonuse;
	}

	/** 返回第year年的其他收入 */
	/** 其他收入 */
	public Double getYearOtherIncomes(Experiment experiment, Integer year) {
		OtherIncomePlanResult incomeresult = (OtherIncomePlanResult) ActionContext.getContext()
				.get("_incomeresult");
		if (null == incomeresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(OtherIncomePlanResult.class, "incomePlan");
			query.add(new Condition("incomePlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "incomePlan", getLoginStudent());
			List<OtherIncomePlanResult> incomeresults = entityService.search(query);
			if (!incomeresults.isEmpty()) {
				incomeresult = incomeresults.get(0);
			} else {
				incomeresult = new OtherIncomePlanResult();
			}
			ActionContext.getContext().put("_incomeresult", incomeresult);
		}
		double income = 0d;
		if ((incomeresult.getAmounts() == null) || (incomeresult.getAmounts().get(year) == null)) {
			income = 0d;
		} else {
			income = incomeresult.getAmounts().get(year);
		}
		return income;
	}

	/** 返回第year年的消费支出 */
	/** 消费支出 */
	public Double getYearConsumes(Experiment experiment, Integer year) {
		ConsumePlanResult consumeresult = (ConsumePlanResult) ActionContext.getContext().get(
				"_consumeresult");
		if (null == consumeresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(ConsumePlanResult.class, "consumePlan");
			query.add(new Condition("consumePlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "consumePlan", getLoginStudent());
			List<ConsumePlanResult> consumeresults = entityService.search(query);
			if (!consumeresults.isEmpty()) {
				consumeresult = consumeresults.get(0);
			} else {
				consumeresult = new ConsumePlanResult();
			}
			ActionContext.getContext().put("_consumeresult", consumeresult);
		}
		double consume = 0d;
		if ((consumeresult.getAmounts() == null) || (consumeresult.getAmounts().get(year) == null)) {
			consume = 0d;
		} else {
			consume = consumeresult.getAmounts().get(year);
		}
		return consume;
	}

	/** 返回第year年教育支出 */
	/** 教育支出 */
	public Double getYearEducations(Experiment experiment, Integer year) {
		EducationPlanResult educationresult = (EducationPlanResult) ActionContext.getContext().get(
				"_educationresult");
		if (null == educationresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(EducationPlanResult.class, "educationPlan");
			query.add(new Condition("educationPlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "educationPlan", getLoginStudent());
			List<EducationPlanResult> educationresults = entityService.search(query);
			if (!educationresults.isEmpty()) {
				educationresult = educationresults.get(0);
			} else {
				educationresult = new EducationPlanResult();
			}
			ActionContext.getContext().put("_educationresult", educationresult);
		}
		double education = 0d;
		for (MemberEducationPlanResult memberResult : educationresult.getMembers()) {
			if (memberResult.getExpenses() == null || memberResult.getExpenses().get(year) == null) {
				education = education + 0;
			} else {
				education = education + memberResult.getExpenses().get(year);
			}
		}
		return education;
	}

	/** 返回第year年旅游支出 */
	/** 旅游支出 */
	public Double getYearTrips(Experiment experiment, Integer year) {
		TripPlanResult tripresult = (TripPlanResult) ActionContext.getContext().get("_tripresult");
		if (null == tripresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(TripPlanResult.class, "tripPlan");
			query.add(new Condition("tripPlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "tripPlan", getLoginStudent());
			List<TripPlanResult> tripresults = entityService.search(query);
			if (!tripresults.isEmpty()) {
				tripresult = tripresults.get(0);
			} else {
				tripresult = new TripPlanResult();
			}
			ActionContext.getContext().put("_tripresult", tripresult);
		}
		double trip = 0d;
		if ((tripresult.getExpenses() == null) || (tripresult.getExpenses().get(year) == null)) {
			trip = 0d;
		} else {
			trip = tripresult.getExpenses().get(year);
		}
		return trip;
	}

	/** 返回第year年医疗支出 */
	/** 医疗支出 */
	public Double getYearMedicals(Experiment experiment, Integer year) {
		MedicalPlanResult medicalresult = (MedicalPlanResult) ActionContext.getContext().get(
				"_medicalResult");
		if (null == medicalresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(MedicalPlanResult.class, "medicalPlan");
			query.add(new Condition("medicalPlan.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "medicalPlan", getLoginStudent());
			List<MedicalPlanResult> medicalresults = entityService.search(query);
			if (!medicalresults.isEmpty()) {
				medicalresult = medicalresults.get(0);
			} else {
				medicalresult = new MedicalPlanResult();
			}
			ActionContext.getContext().put("_medicalResult", medicalresult);
		}
		double medical = 0d;
		for (MemberMedicalPlanResult memberResult : medicalresult.getMembers()) {
			if (memberResult.getExpenses() == null || memberResult.getExpenses().get(year) == null) {
				medical = medical + 0;
			} else {
				medical = medical + memberResult.getExpenses().get(year);
			}
		}
		return medical;
	}

	/** 返回第year年车贷支出 */

	public Double getYearCarDeposits(Experiment experiment, Integer year) {
		CarPlanResult carresult = (CarPlanResult) ActionContext.getContext().get("_carresult");
		if (null == carresult) {
			Long experimentId = experiment.getId();
			EntityQuery query = new EntityQuery(CarPlanResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "result", getLoginStudent());
			List<CarPlanResult> carresults = entityService.search(query);
			if (!carresults.isEmpty()) {
				carresult = carresults.get(0);
			} else {
				carresult = new CarPlanResult();
			}
			ActionContext.getContext().put("_carresult", carresult);
		}
		double cardeposit = 0d;
		if (carresult.getLoans() == null || carresult.getLoans().get(year) == null
				|| carresult.getLoans().get(year).getBusiness() == null
				|| carresult.getLoans().get(year).getBusiness().getTotal() == null) {
			cardeposit = cardeposit + 0;
		} else {
			cardeposit = cardeposit
					+ carresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		return cardeposit;
	}

	/** 返回第year年房贷支出 */
	public Double getYearHouseDeposits(Experiment experiment, Integer year) {
		Long experimentId = experiment.getId();
		EntityQuery query = new EntityQuery(EstateLoanPlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result", getLoginStudent());
		List<EstateLoanPlanResult> estateresults = entityService.search(query);
		EstateLoanPlanResult estateresult = new EstateLoanPlanResult();
		if (!estateresults.isEmpty()) {
			estateresult = estateresults.get(0);
		}
		double housedeposit = 0d;
		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
				|| estateresult.getLoans().get(year).getAccumulation() == null
				|| estateresult.getLoans().get(year).getAccumulation().getTotal() == null) {
			housedeposit = housedeposit + 0;
		} else {
			housedeposit = housedeposit
					+ estateresult.getLoans().get(year).getAccumulation().getTotal().doubleValue();
		}
		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
				|| estateresult.getLoans().get(year).getBusiness() == null
				|| estateresult.getLoans().get(year).getBusiness().getTotal() == null) {
			housedeposit = housedeposit + 0;
		} else {
			housedeposit = housedeposit
					+ estateresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}

		return housedeposit;
	}

	/** 返回第year年还贷款支出 */
	/** 还贷支出 */
	/** 车贷 */
	public Double getYearDeposits(Experiment experiment, Integer year) {
		CarPlanResult carresult = (CarPlanResult) ActionContext.getContext().get("_carresult");
		Long experimentId = experiment.getId();
		Student std = getLoginStudent();
		if (null == carresult) {
			EntityQuery query = new EntityQuery(CarPlanResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "result", std);
			List<CarPlanResult> carresults = entityService.search(query);
			if (!carresults.isEmpty()) {
				carresult = carresults.get(0);
			} else {
				carresult = new CarPlanResult();
			}
			ActionContext.getContext().put("_carresult", carresult);
		}

		/** 房贷 */
		EstateLoanPlanResult estateresult = (EstateLoanPlanResult) ActionContext.getContext().get(
				"_estateLoanPlanResult");
		if (null == estateresult) {
			EntityQuery query = new EntityQuery(EstateLoanPlanResult.class, "result");
			query.add(new Condition("result.experiment.id=:experimentId", experimentId));
			addStdCondition(query, "result", std);
			List<EstateLoanPlanResult> estateresults = entityService.search(query);
			if (!estateresults.isEmpty()) {
				estateresult = estateresults.get(0);
			} else {
				estateresult = new EstateLoanPlanResult();
			}
			ActionContext.getContext().put("_estateLoanPlanResult", estateresult);
		}

		double deposit = 0d;
		if (carresult.getLoans() == null || carresult.getLoans().get(year) == null
				|| carresult.getLoans().get(year).getBusiness() == null
				|| carresult.getLoans().get(year).getBusiness().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ carresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
				|| estateresult.getLoans().get(year).getAccumulation() == null
				|| estateresult.getLoans().get(year).getAccumulation().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ estateresult.getLoans().get(year).getAccumulation().getTotal().doubleValue();
		}
		if (estateresult.getLoans() == null || estateresult.getLoans().get(year) == null
				|| estateresult.getLoans().get(year).getBusiness() == null
				|| estateresult.getLoans().get(year).getBusiness().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ estateresult.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		return deposit;
	}

	private List<FamilyMember> getFamilyMemberResult(Experiment experiment) {
		List<FamilyMember> members = (List<FamilyMember>) ActionContext.getContext().get(
				"_familymembers");
		if (null == members) {
			EntityQuery query = new EntityQuery();
			query = new EntityQuery(FamilyMemberResult.class, "memberResult");
			query.add(new Condition("memberResult.result.experiment=:experiment", experiment));
			Student std = getLoginStudent();
			addStdCondition(query, "memberResult.result", std);
			query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));
			query.setSelect("memberResult.member");
			members = entityService.search(query);
			ActionContext.getContext().put("_familymembers", members);
		}
		return members;
	}

	/** 返回当年保险支出 */
	public Double getYearInsurances(Experiment experiment, Integer year) {
		Long experimentId = experiment.getId();
		List<FamilyMember> members = getFamilyMemberResult(experiment);
		Map<String, List<InsurancePlanPolicyResult>> memberpolicyMap = (Map<String, List<InsurancePlanPolicyResult>>) ActionContext
				.getContext().get("_memberpolicyMap");
		if (null == memberpolicyMap) {
			EntityQuery productquery = new EntityQuery();
			productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
			productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
					experimentId));
			addStdCondition(productquery, "policyresult.result", getLoginStudent());
			List<InsurancePlanPolicyResult> rs = entityService.search(productquery);
			memberpolicyMap = new HashMap();
			for (InsurancePlanPolicyResult policyResult : rs) {
				List<InsurancePlanPolicyResult> pa = memberpolicyMap
						.get(policyResult.getInsurant());
				if (null == pa) {
					pa = new ArrayList();
					memberpolicyMap.put(policyResult.getInsurant(), pa);
				}
				pa.add(policyResult);
			}
			ActionContext.getContext().put("_memberpolicyMap", memberpolicyMap);
		}

		Double insurance = 0d;
		for (int j = 0; j < members.size(); j++) {
			FamilyMember member = members.get(j);
			List<InsurancePlanPolicyResult> memberpolicy = memberpolicyMap.get(member.getName());
			if (null == memberpolicy)
				continue;
			for (InsurancePlanPolicyResult policyResult : memberpolicy) {
				int paytime = calcYears(member.getAge(), policyResult.getPayTime().getDuration());
				if ((policyResult.getApplyOn() <= year)
						&& (paytime + policyResult.getApplyOn() >= year)) {
					insurance = insurance + policyResult.getExpense();
				}
			}
		}
		return insurance;
	}

	/** 返回当年其他支出 */
	/** 其他支出 */
	public Double getYearOtherExpenses(Experiment experiment, Integer year) {
		OtherExpensePlanResult expenseresult = (OtherExpensePlanResult) ActionContext.getContext()
				.get("_expenseresult");
		if (null == expenseresult) {
			EntityQuery query = new EntityQuery(OtherExpensePlanResult.class, "expensePlan");
			query.add(new Condition("expensePlan.experiment=:experiment", experiment));
			addStdCondition(query, "expensePlan", getLoginStudent());
			List<OtherExpensePlanResult> expenseresults = entityService.search(query);
			if (!expenseresults.isEmpty()) {
				expenseresult = expenseresults.get(0);
			} else {
				expenseresult = new OtherExpensePlanResult();
			}
			ActionContext.getContext().put("_expenseresult", expenseresult);
		}
		double expense = 0d;
		if ((expenseresult.getAmounts() == null) || (expenseresult.getAmounts().get(year) == null)) {
			expense = 0d;
		} else {
			expense = expenseresult.getAmounts().get(year);
		}
		return expense;
	}

	/** 计算第0年总结余 */
	public Double getFirstBalance(Experiment experiment) {
		Long experimentId = experiment.getId();
		Double balance = 0d;
		EntityQuery balancequery = new EntityQuery(BalanceOfPaymentResult.class, "result");
		balancequery.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(balancequery, "result", getLoginStudent());
		List balanceresults = entityService.search(balancequery);
		BalanceOfPaymentResult balanceresult = new BalanceOfPaymentResult();
		if (!balanceresults.isEmpty()) {
			balanceresult = (BalanceOfPaymentResult) balanceresults.get(0);
		}
		if (null != balanceresult && null != balanceresult.getForm()
				&& null != balanceresult.getForm().getTotalBalance()) {
			balance = balanceresult.getForm().getTotalBalance().doubleValue() * 12;
		}
		return balance;
	}

	/*** 计算第0年的投资支出 */
	/****
	 * /**计算不同类型金融资产的收入 public Map<String,Double>
	 * getYearPerInverstIncomes(Experiment experiment,Integer year) { Long
	 * experimentId=experiment.getId(); Map<String,Double> incomes=new
	 * HashMap(); EntityQuery query = new EntityQuery(FinanceType.class,
	 * "types"); query.add(new Condition("parent is null")); List<FinanceType>
	 * financetypes = entityService.search(query); EntityQuery planquery = new
	 * EntityQuery(FinancePlanResult.class, "planresult"); Double income=0d;
	 * for(FinanceType financetype : financetypes) { income=0d;
	 * planquery.add(new
	 * Condition("planresult.result.experiment.id=:experimentId",
	 * experimentId)); planquery.add(new
	 * Condition("planresult.financetype.parent:=parent",financetype));
	 * List<FinancePlanResult> planresults = entityService.search(planquery);
	 * for(FinancePlanResult planresult:planresults) {
	 * income=income+getYearIncomes(experiment,planresult,year); }
	 * incomes.put(financetype.getName(),income); }
	 * 
	 * return incomes; }
	 */

	/**
	 * 计算当年金融资产 public Double getYearCapitals(Experiment
	 * experiment,FinancePlanResult result,Integer year) { Double capital=0d;
	 * if(year==result.getStartYear()) { capital=result.getAmount(); } else {
	 * capital=capital*(1+result.getRate().doubleValue()/100d)+getYearExpenses(
	 * experiment,result,year-1); } return capital;
	 * 
	 * }
	 */
	/**
	 * 计算当年金融追加投资 public Double getYearExpenses(Experiment
	 * experiment,FinancePlanResult planresult,Integer year) { Long
	 * experimentId=experiment.getId(); double expense=0d;
	 * if((year==1)&&(planresult.getStartYear()==1)) { EntityQuery query = new
	 * EntityQuery(); EntityQuery balancequery = new
	 * EntityQuery(BalanceOfPaymentResult.class, "result"); query.add(new
	 * Condition("result.experiment.id=:experimentId",experimentId)); List
	 * balanceresults = entityService.search(balancequery);
	 * BalanceOfPaymentResult balanceresult=new BalanceOfPaymentResult(); if
	 * (!balanceresults.isEmpty()) { balanceresult = (BalanceOfPaymentResult)
	 * balanceresults.get(0); }
	 * expense=balanceresult.getForm().getTotalBalance()
	 * .doubleValue()*12*planresult.getAppend().doubleValue()/100d; } else {
	 * expense
	 * =getYearBalances(experiment,year)*planresult.getAppend().doubleValue
	 * ()/100d; } return expense; }
	 */
	/**
	 * 计算当年金融投资收益 public Double getYearIncomes(Experiment
	 * experiment,FinancePlanResult planresult,Integer year) { double income=0d;
	 * if(year==1) {
	 * income=planresult.getAmount()*planresult.getAppend().doubleValue()/100d;
	 * } else {
	 * income=getYearCapitals(experiment,planresult,year)*planresult.getAppend
	 * ().doubleValue()/100d; } return income; }
	 ****/

	/***
	 * 返回各年总结余 public Map<Integer,Double> getBalances( Experiment experiment) {
	 * FinanceAssetPlanResult planResult=getFinanceAssetPlanResult(experiment);
	 * EntityQuery query = new EntityQuery(FinancePlanResult.class, "asset");
	 * query.addOrder(Order.parse(get("orderBy"))); query.add(new
	 * Condition("asset.result.experiment.id=:experimentid",
	 * experiment.getId())); List<FinancePlanResult>
	 * financeresults=entityService.search(query); double
	 * firstbalance=getFirstBalance(experiment);
	 * 
	 * Map<Integer,Double> totalcapital=new HashMap(); Map<Integer,Double>
	 * totalexpense=new HashMap();/**追加 Map<Integer,Double> totalincome=new
	 * HashMap();/**收益 Map<Integer,Double> totalbalance=new HashMap();/**结余
	 * 
	 * for(int i=1;i<=getPlanYears();i++) { totalcapital.put(i, 0d); } for(int
	 * i=1;i<=getPlanYears();i++) { totalexpense.put(i, 0d); } for(int
	 * i=1;i<=getPlanYears();i++) { totalincome.put(i, 0d); } Map<String,Double>
	 * lastcapital=new HashMap(); for(FinancePlanResult
	 * planresult:financeresults) {
	 * lastcapital.put(planresult.getFinancetype().getName(),
	 * planresult.getAmount()); } for(int i=1;i<=getPlanYears();i++) { double
	 * expense=0d; double income=0d; double capital=0d; double balance=0d;
	 * 
	 * if(i==1) { for(FinancePlanResult planresult:financeresults) {
	 * if(planresult.getStartYear()==1) {
	 * 
	 * expense=expense+planresult.getAppend().doubleValue()*firstbalance/100d;
	 * capital
	 * =capital+planresult.getAmount()+planresult.getAppend().doubleValue(
	 * )*firstbalance/100d;
	 * income=income+(planresult.getAmount()+firstbalance*planresult
	 * .getAppend().doubleValue()/100d)*planresult.getRate().doubleValue()/100d;
	 * lastcapital.put(planresult.getFinancetype().getName(),
	 * planresult.getAmount
	 * ()+planresult.getAppend().doubleValue()*firstbalance/100d); } } }else {
	 * for(FinancePlanResult planresult:financeresults) {
	 * if((i<=planresult.getEndYear())&&(i>=planresult.getStartYear())) { double
	 * nowcapital=0d;
	 * expense=expense+planresult.getAppend().doubleValue()*totalbalance
	 * .get(i-1)/100d; if (i==planresult.getStartYear()){
	 * nowcapital=planresult.getAmount
	 * ()+planresult.getAppend().byteValue()*totalbalance.get(i-1)/100d; }else {
	 * nowcapital
	 * =lastcapital.get(planresult.getFinancetype().getName())*(1+planresult
	 * .getRate
	 * ().doubleValue()/100d)+planresult.getAppend().byteValue()*totalbalance
	 * .get(i-1)/100d; } capital=capital+nowcapital;
	 * lastcapital.put(planresult.getFinancetype().getName(), nowcapital);
	 * income=income+(nowcapital)*planresult.getRate().doubleValue()/100d; } } }
	 * balance=getYearCashes(experiment,i)+getYearBonuses(experiment,i)+
	 * getYearOtherIncomes(experiment,i)+income-getYearConsumes(experiment,i)
	 * -expense-getYearEducations(experiment,i)-getYearTrips(experiment,i)-
	 * getYearMedicals(experiment,i)-getYearDeposits(experiment,i)
	 * -getYearInsurances(experiment,i)-getYearOtherExpenses(experiment,i);
	 * 
	 * totalexpense.put(i,expense); totalincome.put(i,income);
	 * totalcapital.put(i,capital); totalbalance.put(i,balance); } return
	 * totalbalance;
	 * 
	 * }
	 ****/

	protected FinanceAssetPlanResult getFinanceAssetPlanResult(Experiment experiment) {
		EntityQuery query = new EntityQuery(FinanceAssetPlanResult.class, "result");
		Long experimentId = experiment.getId();
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "result", getLoginStudent());
		List results = entityService.search(query);
		FinanceAssetPlanResult result = null;
		if (results.isEmpty()) {
			result = new FinanceAssetPlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
			result.setAssets(new HashSet());
			entityService.saveOrUpdate(result);
		} else {
			result = (FinanceAssetPlanResult) results.get(0);
		}
		return result;
	}

	/** 计算保险期限，缴费期限的年份 */
	private Integer calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return 30;
		} else {
			if (StringUtils.contains(script, "age")) {
				return Integer.parseInt(script.substring(0, script.indexOf("-"))) - age + 1;
			} else {
				return Integer.parseInt(script) - 1;
			}
		}
	}

	protected String getTypeName(String type) {
		return "org.expr.model.plan.result." + type + "Result";
	}

	public String infolet() {
		Long stdId = getLong("std.id");
		Long expId = getEntityId("experiment");
		String type = get("type");
		if (StringUtils.isNotEmpty(type)) {
			EntityQuery query = new EntityQuery(getTypeName(type), "r");
			query.add(new Condition("r.student.id=:stdId and r.experiment.id=:expId", stdId, expId));
			List<AnalysisForm> results = entityService.search(query);
			if (results.size() > 0) {
				put("result", results.get(0));
			}
			String needMembers = get("members");
			if (StringUtils.isNotBlank(needMembers)) {
				query = new EntityQuery(FamilyMemberResult.class, "m");
				query.add(new Condition(
						"m.result.student.id=:stdId and m.result.experiment.id=:expId", stdId,
						expId));
				query.setSelect("m.member");
				List<FamilyMember> members = entityService.search(query);
				Map membersMap = new HashMap();
				for (FamilyMember member : members) {
					membersMap.put(member.getName(), member);
				}
				put("membersMap", membersMap);
				put("members", members);
			}
		}
		return forward("../../infolet/info");
	}
}
