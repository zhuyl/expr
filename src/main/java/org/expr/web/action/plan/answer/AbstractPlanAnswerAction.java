package org.expr.web.action.plan.answer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.BonusPlanAnswer;
import org.expr.model.plan.answer.CarPlanAnswer;
import org.expr.model.plan.answer.CashPlanAnswer;
import org.expr.model.plan.answer.ConsumePlanAnswer;
import org.expr.model.plan.answer.EducationPlanAnswer;
import org.expr.model.plan.answer.EstateLoanPlanAnswer;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;
import org.expr.model.plan.answer.MedicalPlanAnswer;
import org.expr.model.plan.answer.MemberBonusPlanAnswer;
import org.expr.model.plan.answer.MemberCashPlanAnswer;
import org.expr.model.plan.answer.MemberEducationPlanAnswer;
import org.expr.model.plan.answer.MemberMedicalPlanAnswer;
import org.expr.model.plan.answer.OtherExpensePlanAnswer;
import org.expr.model.plan.answer.OtherIncomePlanAnswer;
import org.expr.model.plan.answer.TripPlanAnswer;

import com.ekingstar.eams.web.action.BaseAction;
import com.opensymphony.xwork2.ActionContext;

public class AbstractPlanAnswerAction extends BaseAction {

	public int getPlanYears() {
		return 30;
	}

	/** 返回第year年的工资 */
	/** 工资收入map */
	public Double getYearCashes(Caze caze, Integer year) {
		CashPlanAnswer cashanswer = (CashPlanAnswer) ActionContext.getContext().get("_cashanswer");
		if (null == cashanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(CashPlanAnswer.class, "cashPlan");
			query.add(new Condition("cashPlan.caze.id=:cazeId", cazeId));
			List<CashPlanAnswer> cashanswers = entityService.search(query);
			if (!cashanswers.isEmpty()) {
				cashanswer = cashanswers.get(0);
			} else {
				cashanswer = new CashPlanAnswer();
			}
			ActionContext.getContext().put("_cashanswer", cashanswer);
		}
		double cash = 0;
		for (MemberCashPlanAnswer memberAnswer : cashanswer.getMembers()) {
			if (memberAnswer.getSalaries() == null || memberAnswer.getSalaries().get(year) == null) {
				cash = cash + 0;
			} else {
				cash = cash + memberAnswer.getSalaries().get(year);
			}
		}
		return cash;
	}

	/** 返回第year年的奖金 */
	/*** 奖金收入map */
	public Double getYearBonuses(Caze caze, Integer year) {
		BonusPlanAnswer bonusanswer = (BonusPlanAnswer) ActionContext.getContext().get(
				"_bonusanswer");
		if (null == bonusanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(BonusPlanAnswer.class, "bonusPlan");
			query.add(new Condition("bonusPlan.caze.id=:cazeId", cazeId));
			List<BonusPlanAnswer> bonusanswers = entityService.search(query);
			if (!bonusanswers.isEmpty()) {
				bonusanswer = bonusanswers.get(0);
			} else {
				bonusanswer = new BonusPlanAnswer();
			}
			ActionContext.getContext().put("_bonusanswer", bonusanswer);
		}
		double bonuse = 0;
		for (MemberBonusPlanAnswer memberAnswer : bonusanswer.getMembers()) {
			if (memberAnswer.getBonuses() == null || memberAnswer.getBonuses().get(year) == null) {
				bonuse = bonuse + 0;
			} else {
				bonuse = bonuse + memberAnswer.getBonuses().get(year);
			}
		}
		return bonuse;
	}

	/** 返回第year年的其他收入 */
	/** 其他收入 */
	public Double getYearOtherIncomes(Caze caze, Integer year) {
		OtherIncomePlanAnswer incomeanswer = (OtherIncomePlanAnswer) ActionContext.getContext()
				.get("_incomeanswer");
		if (null == incomeanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(OtherIncomePlanAnswer.class, "incomePlan");
			query.add(new Condition("incomePlan.caze.id=:cazeId", cazeId));
			List<OtherIncomePlanAnswer> incomeanswers = entityService.search(query);
			if (!incomeanswers.isEmpty()) {
				incomeanswer = incomeanswers.get(0);
			} else {
				incomeanswer = new OtherIncomePlanAnswer();
			}
			ActionContext.getContext().put("_incomeanswer", incomeanswer);
		}
		double income = 0d;
		if ((incomeanswer.getAmounts() == null) || (incomeanswer.getAmounts().get(year) == null)) {
			income = 0d;
		} else {
			income = incomeanswer.getAmounts().get(year);
		}
		return income;
	}

	/** 返回第year年的消费支出 */
	/** 消费支出 */
	public Double getYearConsumes(Caze caze, Integer year) {
		ConsumePlanAnswer consumeanswer = (ConsumePlanAnswer) ActionContext.getContext().get(
				"_consumeanswer");
		if (null == consumeanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(ConsumePlanAnswer.class, "consumePlan");
			query.add(new Condition("consumePlan.caze.id=:cazeId", cazeId));
			List<ConsumePlanAnswer> consumeanswers = entityService.search(query);
			if (!consumeanswers.isEmpty()) {
				consumeanswer = consumeanswers.get(0);
			} else {
				consumeanswer = new ConsumePlanAnswer();
			}
			ActionContext.getContext().put("_consumeanswer", consumeanswer);
		}
		double consume = 0d;
		if ((consumeanswer.getAmounts() == null) || (consumeanswer.getAmounts().get(year) == null)) {
			consume = 0d;
		} else {
			consume = consumeanswer.getAmounts().get(year);
		}
		return consume;
	}

	/** 返回第year年教育支出 */
	/** 教育支出 */
	public Double getYearEducations(Caze caze, Integer year) {
		EducationPlanAnswer educationanswer = (EducationPlanAnswer) ActionContext.getContext().get(
				"_educationanswer");
		if (null == educationanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(EducationPlanAnswer.class, "educationPlan");
			query.add(new Condition("educationPlan.caze.id=:cazeId", cazeId));
			List<EducationPlanAnswer> educationanswers = entityService.search(query);
			if (!educationanswers.isEmpty()) {
				educationanswer = educationanswers.get(0);
			} else {
				educationanswer = new EducationPlanAnswer();
			}
			ActionContext.getContext().put("_educationanswer", educationanswer);
		}
		double education = 0d;
		for (MemberEducationPlanAnswer memberAnswer : educationanswer.getMembers()) {
			if (memberAnswer.getExpenses() == null || memberAnswer.getExpenses().get(year) == null) {
				education = education + 0;
			} else {
				education = education + memberAnswer.getExpenses().get(year);
			}
		}
		return education;
	}

	/** 返回第year年旅游支出 */
	/** 旅游支出 */
	public Double getYearTrips(Caze caze, Integer year) {
		TripPlanAnswer tripanswer = (TripPlanAnswer) ActionContext.getContext().get("_tripanswer");
		if (null == tripanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(TripPlanAnswer.class, "tripPlan");
			query.add(new Condition("tripPlan.caze.id=:cazeId", cazeId));
			List<TripPlanAnswer> tripanswers = entityService.search(query);
			if (!tripanswers.isEmpty()) {
				tripanswer = tripanswers.get(0);
			} else {
				tripanswer = new TripPlanAnswer();
			}
			ActionContext.getContext().put("_tripanswer", tripanswer);
		}
		double trip = 0d;
		if ((tripanswer.getExpenses() == null) || (tripanswer.getExpenses().get(year) == null)) {
			trip = 0d;
		} else {
			trip = tripanswer.getExpenses().get(year);
		}
		return trip;
	}

	/** 返回第year年医疗支出 */
	/** 医疗支出 */
	public Double getYearMedicals(Caze caze, Integer year) {
		MedicalPlanAnswer medicalanswer = (MedicalPlanAnswer) ActionContext.getContext().get(
				"_medicalanswer");
		if (null == medicalanswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(MedicalPlanAnswer.class, "medicalPlan");
			query.add(new Condition("medicalPlan.caze.id=:cazeId", cazeId));
			List<MedicalPlanAnswer> medicalanswers = entityService.search(query);
			if (!medicalanswers.isEmpty()) {
				medicalanswer = medicalanswers.get(0);
			} else {
				medicalanswer = new MedicalPlanAnswer();
			}
			ActionContext.getContext().put("_medicalanswer", medicalanswer);
		}

		double medical = 0d;
		for (MemberMedicalPlanAnswer memberAnswer : medicalanswer.getMembers()) {
			if (memberAnswer.getExpenses() == null || memberAnswer.getExpenses().get(year) == null) {
				medical = medical + 0;
			} else {
				medical = medical + memberAnswer.getExpenses().get(year);
			}
		}
		return medical;
	}

	/** 返回第year年车贷支出 */
	public Double getYearCarDeposits(Caze caze, Integer year) {
		CarPlanAnswer caranswer = (CarPlanAnswer) ActionContext.getContext().get("_caranswer");
		if (null == caranswer) {
			Long cazeId = caze.getId();
			EntityQuery query = new EntityQuery(CarPlanAnswer.class, "answer");
			query.add(new Condition("answer.caze.id=:cazeId", cazeId));
			List<CarPlanAnswer> caranswers = entityService.search(query);
			if (!caranswers.isEmpty()) {
				caranswer = caranswers.get(0);
			} else {
				caranswer = new CarPlanAnswer();
			}
			ActionContext.getContext().put("_caranswer", caranswer);
		}
		double cardeposit = 0d;
		if (caranswer.getLoans() == null || caranswer.getLoans().get(year) == null
				|| caranswer.getLoans().get(year).getBusiness() == null
				|| caranswer.getLoans().get(year).getBusiness().getTotal() == null) {
			cardeposit = cardeposit + 0;
		} else {
			cardeposit = cardeposit
					+ caranswer.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		return cardeposit;
	}

	/** 返回第year年房贷支出 */
	public Double getYearHouseDeposits(Caze caze, Integer year) {
		Long cazeId = caze.getId();
		EstateLoanPlanAnswer estateanswer = (EstateLoanPlanAnswer) ActionContext.getContext().get(
				"_estateanswer");
		if (null == estateanswer) {
			EntityQuery query = new EntityQuery(EstateLoanPlanAnswer.class, "answer");
			query.add(new Condition("answer.caze.id=:cazeId", cazeId));
			List<EstateLoanPlanAnswer> estateanswers = entityService.search(query);
			estateanswer = new EstateLoanPlanAnswer();
			if (!estateanswers.isEmpty()) {
				estateanswer = estateanswers.get(0);
			} else {
				ActionContext.getContext().put("_estateanswer", estateanswer);
			}
		}
		double housedeposit = 0d;
		if (estateanswer.getLoans() == null || estateanswer.getLoans().get(year) == null
				|| estateanswer.getLoans().get(year).getAccumulation() == null
				|| estateanswer.getLoans().get(year).getAccumulation().getTotal() == null) {
			housedeposit = housedeposit + 0;
		} else {
			housedeposit = housedeposit
					+ estateanswer.getLoans().get(year).getAccumulation().getTotal().doubleValue();
		}
		if (estateanswer.getLoans() == null || estateanswer.getLoans().get(year) == null
				|| estateanswer.getLoans().get(year).getBusiness() == null
				|| estateanswer.getLoans().get(year).getBusiness().getTotal() == null) {
			housedeposit = housedeposit + 0;
		} else {
			housedeposit = housedeposit
					+ estateanswer.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}

		return housedeposit;
	}

	/** 返回第year年还贷款支出 */
	/** 还贷支出 */
	/** 车贷 */
	public Double getYearDeposits(Caze caze, Integer year) {
		Long cazeId = caze.getId();
		CarPlanAnswer caranswer = (CarPlanAnswer) ActionContext.getContext().get("_caranswer");
		if (null == caranswer) {
			EntityQuery query = new EntityQuery(CarPlanAnswer.class, "answer");
			query.add(new Condition("answer.caze.id=:cazeId", cazeId));
			List<CarPlanAnswer> caranswers = entityService.search(query);
			if (!caranswers.isEmpty()) {
				caranswer = caranswers.get(0);
			} else {
				caranswer = new CarPlanAnswer();
			}
			ActionContext.getContext().put("_caranswer", caranswer);
		}

		/** 房贷 */
		EstateLoanPlanAnswer estateanswer = (EstateLoanPlanAnswer) ActionContext.getContext().get(
				"_estateanswer");
		if (null == estateanswer) {
			EntityQuery query = new EntityQuery(EstateLoanPlanAnswer.class, "answer");
			query.add(new Condition("answer.caze.id=:cazeId", cazeId));
			List<EstateLoanPlanAnswer> estateanswers = entityService.search(query);
			if (!estateanswers.isEmpty()) {
				estateanswer = estateanswers.get(0);
			} else {
				estateanswer = new EstateLoanPlanAnswer();
			}
			ActionContext.getContext().put("_estateanswer", estateanswer);
		}

		double deposit = 0d;
		if (caranswer.getLoans() == null || caranswer.getLoans().get(year) == null
				|| caranswer.getLoans().get(year).getBusiness() == null
				|| caranswer.getLoans().get(year).getBusiness().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ caranswer.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		if (estateanswer.getLoans() == null || estateanswer.getLoans().get(year) == null
				|| estateanswer.getLoans().get(year).getAccumulation() == null
				|| estateanswer.getLoans().get(year).getAccumulation().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ estateanswer.getLoans().get(year).getAccumulation().getTotal().doubleValue();
		}
		if (estateanswer.getLoans() == null || estateanswer.getLoans().get(year) == null
				|| estateanswer.getLoans().get(year).getBusiness() == null
				|| estateanswer.getLoans().get(year).getBusiness().getTotal() == null) {
			deposit = deposit + 0;
		} else {
			deposit = deposit
					+ estateanswer.getLoans().get(year).getBusiness().getTotal().doubleValue();
		}
		return deposit;
	}

	/** 返回当年保险支出 */
	/** 保险支出 */
	public Double getYearInsurances(Caze caze, Integer year) {
		Long cazeId = caze.getId();
		List<FamilyMember> members = (List<FamilyMember>) ActionContext.getContext().get(
				"_membersanswer");
		if (null == members) {
			EntityQuery query = new EntityQuery();
			query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
			query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
			query.setSelect("memberAnswer.member");
			members = entityService.search(query);
			ActionContext.getContext().put("_membersanswer", members);
		}
		Map<String, List<InsurancePlanPolicyAnswer>> memberpolicyMap = (Map<String, List<InsurancePlanPolicyAnswer>>) ActionContext
				.getContext().get("_memberpolicyMap");
		if (null == memberpolicyMap) {
			EntityQuery productquery = new EntityQuery();
			productquery = new EntityQuery(InsurancePlanPolicyAnswer.class, "policyanswer");
			productquery.add(new Condition("policyanswer.answer.caze.id=:cazeId", cazeId));
			List<InsurancePlanPolicyAnswer> rs = entityService.search(productquery);
			memberpolicyMap = new HashMap();
			for (InsurancePlanPolicyAnswer policyAnswer : rs) {
				List<InsurancePlanPolicyAnswer> pa = memberpolicyMap
						.get(policyAnswer.getInsurant());
				if (null == pa) {
					pa = new ArrayList();
					memberpolicyMap.put(policyAnswer.getInsurant(), pa);
				}
				pa.add(policyAnswer);
			}
			ActionContext.getContext().put("_memberpolicyMap", memberpolicyMap);
		}
		Double insurance = 0d;
		for (int j = 0; j < members.size(); j++) {
			FamilyMember member = members.get(j);
			List<InsurancePlanPolicyAnswer> memberpolicies = memberpolicyMap.get(member.getName());
			if (null == memberpolicies)
				continue;
			for (InsurancePlanPolicyAnswer policyAnswer : memberpolicies) {
				int paytime = calcYears(member.getAge(), policyAnswer.getPayTime().getDuration());
				if ((policyAnswer.getApplyOn() <= year)
						&& (paytime + policyAnswer.getApplyOn() >= year)) {
					insurance = insurance + policyAnswer.getExpense();
				}
			}
		}
		return insurance;
	}

	/** 返回当年其他支出 */
	/** 其他支出 */
	public Double getYearOtherExpenses(Caze caze, Integer year) {
		Long cazeId = caze.getId();
		OtherExpensePlanAnswer expenseanswer = (OtherExpensePlanAnswer) ActionContext.getContext()
				.get("_expenseanswer");
		if (null == expenseanswer) {
			EntityQuery query = new EntityQuery(OtherExpensePlanAnswer.class, "expensePlan");
			query.add(new Condition("expensePlan.caze.id=:cazeId", cazeId));
			List<OtherExpensePlanAnswer> expenseanswers = entityService.search(query);
			if (!expenseanswers.isEmpty()) {
				expenseanswer = expenseanswers.get(0);
			} else {
				expenseanswer = new OtherExpensePlanAnswer();
			}
			ActionContext.getContext().put("_expenseanswer", expenseanswer);
		}
		double expense = 0d;
		if ((expenseanswer.getAmounts() == null) || (expenseanswer.getAmounts().get(year) == null)) {
			expense = 0d;
		} else {
			expense = expenseanswer.getAmounts().get(year);
		}
		return expense;
	}

	/** 计算第0年总结余 */
	public Double getFirstBalance(Caze caze) {
		Long cazeId = caze.getId();
		Double balance = 0d;
		EntityQuery balancequery = new EntityQuery(BalanceOfPaymentAnswer.class, "answer");
		balancequery.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List balanceanswers = entityService.search(balancequery);
		BalanceOfPaymentAnswer balanceanswer = new BalanceOfPaymentAnswer();
		if (!balanceanswers.isEmpty()) {
			balanceanswer = (BalanceOfPaymentAnswer) balanceanswers.get(0);
		}
		if (null != balanceanswer && null != balanceanswer.getForm()
				&& null != balanceanswer.getForm().getTotalBalance()) {
			balance = balanceanswer.getForm().getTotalBalance().doubleValue() * 12;
		}
		return balance;
	}

	/*** 计算第0年的投资支出 */
	/****
	 * /**计算不同类型金融资产的收入 public Map<String,Double> getYearPerInverstIncomes(Caze
	 * caze,Integer year) { Long cazeId=caze.getId(); Map<String,Double>
	 * incomes=new HashMap(); EntityQuery query = new
	 * EntityQuery(FinanceType.class, "types"); query.add(new
	 * Condition("parent is null")); List<FinanceType> financetypes =
	 * entityService.search(query); EntityQuery planquery = new
	 * EntityQuery(FinancePlanAnswer.class, "plananswer"); Double income=0d;
	 * for(FinanceType financetype : financetypes) { income=0d;
	 * planquery.add(new Condition("plananswer.answer.caze.id=:cazeId",
	 * cazeId)); planquery.add(new
	 * Condition("plananswer.financetype.parent:=parent",financetype));
	 * List<FinancePlanAnswer> plananswers = entityService.search(planquery);
	 * for(FinancePlanAnswer plananswer:plananswers) {
	 * income=income+getYearIncomes(caze,plananswer,year); }
	 * incomes.put(financetype.getName(),income); }
	 * 
	 * return incomes; }
	 */

	/**
	 * 计算当年金融资产 public Double getYearCapitals(Caze caze,FinancePlanAnswer
	 * answer,Integer year) { Double capital=0d; if(year==answer.getStartYear())
	 * { capital=answer.getAmount(); } else {
	 * capital=capital*(1+answer.getRate()
	 * .doubleValue()/100d)+getYearExpenses(caze,answer,year-1); } return
	 * capital;
	 * 
	 * }
	 */
	/**
	 * 计算当年金融追加投资 public Double getYearExpenses(Caze caze,FinancePlanAnswer
	 * plananswer,Integer year) { Long cazeId=caze.getId(); double expense=0d;
	 * if((year==1)&&(plananswer.getStartYear()==1)) { EntityQuery query = new
	 * EntityQuery(); EntityQuery balancequery = new
	 * EntityQuery(BalanceOfPaymentAnswer.class, "answer"); query.add(new
	 * Condition("answer.caze.id=:cazeId",cazeId)); List balanceanswers =
	 * entityService.search(balancequery); BalanceOfPaymentAnswer
	 * balanceanswer=new BalanceOfPaymentAnswer(); if
	 * (!balanceanswers.isEmpty()) { balanceanswer = (BalanceOfPaymentAnswer)
	 * balanceanswers.get(0); }
	 * expense=balanceanswer.getForm().getTotalBalance()
	 * .doubleValue()*12*plananswer.getAppend().doubleValue()/100d; } else {
	 * expense
	 * =getYearBalances(caze,year)*plananswer.getAppend().doubleValue()/100d; }
	 * return expense; }
	 */
	/**
	 * 计算当年金融投资收益 public Double getYearIncomes(Caze caze,FinancePlanAnswer
	 * plananswer,Integer year) { double income=0d; if(year==1) {
	 * income=plananswer.getAmount()*plananswer.getAppend().doubleValue()/100d;
	 * } else {
	 * income=getYearCapitals(caze,plananswer,year)*plananswer.getAppend
	 * ().doubleValue()/100d; } return income; }
	 ****/

	/***
	 * 返回各年总结余 public Map<Integer,Double> getBalances( Caze caze) {
	 * FinanceAssetPlanAnswer planAnswer=getFinanceAssetPlanAnswer(caze);
	 * EntityQuery query = new EntityQuery(FinancePlanAnswer.class, "asset");
	 * query.addOrder(Order.parse(get("orderBy"))); query.add(new
	 * Condition("asset.answer.caze.id=:cazeid", caze.getId()));
	 * List<FinancePlanAnswer> financeanswers=entityService.search(query);
	 * double firstbalance=getFirstBalance(caze);
	 * 
	 * Map<Integer,Double> totalcapital=new HashMap(); Map<Integer,Double>
	 * totalexpense=new HashMap();/**追加 Map<Integer,Double> totalincome=new
	 * HashMap();/**收益 Map<Integer,Double> totalbalance=new HashMap();/**结余
	 * 
	 * for(int i=1;i<=getPlanYears();i++) { totalcapital.put(i, 0d); } for(int
	 * i=1;i<=getPlanYears();i++) { totalexpense.put(i, 0d); } for(int
	 * i=1;i<=getPlanYears();i++) { totalincome.put(i, 0d); } Map<String,Double>
	 * lastcapital=new HashMap(); for(FinancePlanAnswer
	 * plananswer:financeanswers) {
	 * lastcapital.put(plananswer.getFinancetype().getName(),
	 * plananswer.getAmount()); } for(int i=1;i<=getPlanYears();i++) { double
	 * expense=0d; double income=0d; double capital=0d; double balance=0d;
	 * 
	 * if(i==1) { for(FinancePlanAnswer plananswer:financeanswers) {
	 * if(plananswer.getStartYear()==1) {
	 * 
	 * expense=expense+plananswer.getAppend().doubleValue()*firstbalance/100d;
	 * capital
	 * =capital+plananswer.getAmount()+plananswer.getAppend().doubleValue(
	 * )*firstbalance/100d;
	 * income=income+(plananswer.getAmount()+firstbalance*plananswer
	 * .getAppend().doubleValue()/100d)*plananswer.getRate().doubleValue()/100d;
	 * lastcapital.put(plananswer.getFinancetype().getName(),
	 * plananswer.getAmount
	 * ()+plananswer.getAppend().doubleValue()*firstbalance/100d); } } }else {
	 * for(FinancePlanAnswer plananswer:financeanswers) {
	 * if((i<=plananswer.getEndYear())&&(i>=plananswer.getStartYear())) { double
	 * nowcapital=0d;
	 * expense=expense+plananswer.getAppend().doubleValue()*totalbalance
	 * .get(i-1)/100d; if (i==plananswer.getStartYear()){
	 * nowcapital=plananswer.getAmount
	 * ()+plananswer.getAppend().byteValue()*totalbalance.get(i-1)/100d; }else {
	 * nowcapital
	 * =lastcapital.get(plananswer.getFinancetype().getName())*(1+plananswer
	 * .getRate
	 * ().doubleValue()/100d)+plananswer.getAppend().byteValue()*totalbalance
	 * .get(i-1)/100d; } capital=capital+nowcapital;
	 * lastcapital.put(plananswer.getFinancetype().getName(), nowcapital);
	 * income=income+(nowcapital)*plananswer.getRate().doubleValue()/100d; } } }
	 * balance
	 * =getYearCashes(caze,i)+getYearBonuses(caze,i)+getYearOtherIncomes(caze
	 * ,i)+income-getYearConsumes(caze,i)
	 * -expense-getYearEducations(caze,i)-getYearTrips
	 * (caze,i)-getYearMedicals(caze,i)-getYearDeposits(caze,i)
	 * -getYearInsurances(caze,i)-getYearOtherExpenses(caze,i);
	 * 
	 * totalexpense.put(i,expense); totalincome.put(i,income);
	 * totalcapital.put(i,capital); totalbalance.put(i,balance); } return
	 * totalbalance;
	 * 
	 * }
	 ****/

	protected FinanceAssetPlanAnswer getFinanceAssetPlanAnswer(Caze caze) {
		EntityQuery query = new EntityQuery(FinanceAssetPlanAnswer.class, "answer");
		Long cazeId = caze.getId();
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List answers = entityService.search(query);
		FinanceAssetPlanAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new FinanceAssetPlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			answer.setAssets(new HashSet());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (FinanceAssetPlanAnswer) answers.get(0);
		}
		return answer;
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

	protected String getTypeName(String phase, String type) {
		return "org.expr.model.plan.answer." + type + "Answer";
	}

	public String infolet() {
		Long cazeId = getEntityId("caze");
		String type = get("type");
		if (StringUtils.isNotEmpty(type)) {
			EntityQuery query = new EntityQuery(getTypeName(null, type), "a");
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
		return forward("../../infolet/info");
	}
}
