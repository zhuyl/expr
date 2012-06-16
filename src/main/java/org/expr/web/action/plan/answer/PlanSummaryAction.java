package org.expr.web.action.plan.answer;



import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.plan.answer.BonusPlanAnswer;
import org.expr.model.plan.answer.CarPlanAnswer;
import org.expr.model.plan.answer.CashPlanAnswer;
import org.expr.model.plan.answer.ConsumePlanAnswer;
import org.expr.model.plan.answer.EducationPlanAnswer;
import org.expr.model.plan.answer.EstateLoanPlanAnswer;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;
import org.expr.model.plan.answer.MedicalPlanAnswer;
import org.expr.model.plan.answer.MemberBonusPlanAnswer;
import org.expr.model.plan.answer.MemberCashPlanAnswer;
import org.expr.model.plan.answer.MemberEducationPlanAnswer;
import org.expr.model.plan.answer.MemberMedicalPlanAnswer;
import org.expr.model.plan.answer.OtherExpensePlanAnswer;
import org.expr.model.plan.answer.OtherIncomePlanAnswer;
import org.expr.model.plan.answer.PlanSummaryAnswer;
import org.expr.model.plan.answer.TripPlanAnswer;

/**
 *理财规划综述
 * 
 * @return
 */
public class PlanSummaryAction extends AbstractPlanAnswerAction {

	public String index() {
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(PlanSummaryAnswer.class, "plansummary");
		query.add(new Condition("plansummary.caze.id=:cazeId", cazeId));
		List<PlanSummaryAnswer> answers = entityService.search(query);
		PlanSummaryAnswer answer=new PlanSummaryAnswer();
		if (!answers.isEmpty()) {
			 answer = (PlanSummaryAnswer) answers.get(0);
		}		
		put("answer", answer);		
		
	
		query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		
		/**工资收入map*/
		query = new EntityQuery(CashPlanAnswer.class, "cashPlan");
		query.add(new Condition("cashPlan.caze.id=:cazeId", cazeId));
		List<CashPlanAnswer> cashanswers = entityService.search(query);
		CashPlanAnswer cashanswer=new 	CashPlanAnswer();	
		if(!cashanswers.isEmpty())
		{
			cashanswer=cashanswers.get(0);
		}

		Map<Integer, Double> cashes = new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			double sum=0;
			for (MemberCashPlanAnswer memberAnswer : cashanswer.getMembers()) {
				if(memberAnswer.getSalaries()==null||memberAnswer.getSalaries().get(i)==null){
					sum=sum+0;
				}else
				{
					sum=sum+memberAnswer.getSalaries().get(i);
				}
			}
			cashes.put(i, sum);
		}
		put("cashes",cashes);
		
		
		/***奖金收入map*/
		query = new EntityQuery(BonusPlanAnswer.class, "bonusPlan");
		query.add(new Condition("bonusPlan.caze.id=:cazeId", cazeId));
		List<BonusPlanAnswer> bonusanswers = entityService.search(query);
		BonusPlanAnswer bonusanswer=new BonusPlanAnswer();
		if(!bonusanswers.isEmpty())
		{
			bonusanswer=bonusanswers.get(0);
		}
		Map<Integer, Double> bonuses = new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			double sum=0;
			for (MemberBonusPlanAnswer memberAnswer : bonusanswer.getMembers()) {
				if(memberAnswer.getBonuses()==null||memberAnswer.getBonuses().get(i)==null){
					sum=sum+0;
				}else
				{
					sum=sum+memberAnswer.getBonuses().get(i);
				}
			}
			bonuses.put(i, sum);
		}
		put("bonuses",bonuses);		
		
		/**其他收入*/
	     query = new EntityQuery(OtherIncomePlanAnswer.class, "incomePlan");
		query.add(new Condition("incomePlan.caze.id=:cazeId", cazeId));
		List<OtherIncomePlanAnswer> incomeanswers=entityService.search(query);
		OtherIncomePlanAnswer incomeanswer=new OtherIncomePlanAnswer();		
		if (!incomeanswers.isEmpty()){
			incomeanswer=incomeanswers.get(0);
		}
		Map<Integer, Double> incomes = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((incomeanswer.getAmounts()==null)||(incomeanswer.getAmounts().get(i)==null))
			{
				incomes.put(i,0d);
			}
			else
			{
				incomes.put(i, incomeanswer.getAmounts().get(i));
			}
		}
		put("incomes",incomes);
		
		
		/**消费支出*/
	     query = new EntityQuery(ConsumePlanAnswer.class, "consumePlan");
		query.add(new Condition("consumePlan.caze.id=:cazeId", cazeId));
		List<ConsumePlanAnswer> consumeanswers=entityService.search(query);
		ConsumePlanAnswer consumeanswer=new ConsumePlanAnswer();		
		if (!consumeanswers.isEmpty()){
			 consumeanswer=consumeanswers.get(0);
		}
		Map<Integer, Double> consumes = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((consumeanswer.getAmounts()==null)||(consumeanswer.getAmounts().get(i)==null))
			{
				consumes.put(i,0d);
			}
			else
			{
				consumes.put(i, consumeanswer.getAmounts().get(i));
			}
		}	
		put("consumes",consumes);
		
		
		/**教育支出*/
		query = new EntityQuery(EducationPlanAnswer.class, "educationPlan");
		query.add(new Condition("educationPlan.caze.id=:cazeId", cazeId));
		List<EducationPlanAnswer> educationanswers = entityService.search(query);
		EducationPlanAnswer educationanswer=new EducationPlanAnswer();
		if (!educationanswers.isEmpty()){
			educationanswer=educationanswers.get(0);	
		}	
		Map<Integer, Double> educations = new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			double sum=0;
			for (MemberEducationPlanAnswer memberAnswer : educationanswer.getMembers()) {
				if(memberAnswer.getExpenses()==null||memberAnswer.getExpenses().get(i)==null){
					sum=sum+0;
				}else
				{
				sum=sum+memberAnswer.getExpenses().get(i);
				}
			}
			educations.put(i, sum);
		}
		put("educations",educations);	
		
		/**旅游支出*/
		 query = new EntityQuery(TripPlanAnswer.class, "tripPlan");
		query.add(new Condition("tripPlan.caze.id=:cazeId", cazeId));
		List<TripPlanAnswer> tripanswers=entityService.search(query);
		TripPlanAnswer tripanswer=new TripPlanAnswer();
		if (!tripanswers.isEmpty()){
			tripanswer=tripanswers.get(0);;
		}
		Map<Integer, Double> trips = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((tripanswer.getExpenses()==null)||(tripanswer.getExpenses().get(i)==null))
			{
				trips.put(i,0d);
			}
			else
			{
				trips.put(i, tripanswer.getExpenses().get(i));
			}
		}	
		
		put("trips",trips);
		
		
		
		/**医疗支出*/
		query = new EntityQuery(MedicalPlanAnswer.class, "medicalPlan");
		query.add(new Condition("medicalPlan.caze.id=:cazeId", cazeId));
		List<MedicalPlanAnswer> medicalanswers = entityService.search(query);
		MedicalPlanAnswer medicalanswer=new MedicalPlanAnswer();		
		if (!medicalanswers.isEmpty()){
			medicalanswer=medicalanswers.get(0);		
		}
		Map<Integer, Double> medicals = new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			double sum=0;
			for (MemberMedicalPlanAnswer memberAnswer : medicalanswer.getMembers()) {
				if(memberAnswer.getExpenses()==null||memberAnswer.getExpenses().get(i)==null){
					sum=sum+0;
				}else
				{
				sum=sum+memberAnswer.getExpenses().get(i);
				}
			}
			medicals.put(i, sum);
		}
		put("medicals",medicals);	

		
		/**还贷支出*/
	    /**车贷*/
		query = new EntityQuery(CarPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<CarPlanAnswer> caranswers = entityService.search(query);
		CarPlanAnswer caranswer =new CarPlanAnswer();		
		if (!caranswers.isEmpty()) {
			 caranswer = caranswers.get(0);
		}

		/**房贷*/
		query = new EntityQuery(EstateLoanPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<EstateLoanPlanAnswer> estateanswers = entityService.search(query);
		EstateLoanPlanAnswer estateanswer=new 	EstateLoanPlanAnswer();	
		if (!estateanswers.isEmpty()) {
			estateanswer=estateanswers.get(0);
		}			
		
		Map<Integer, Double> deposits = new HashMap();
		Map<Integer,Double> cardeposits=new HashMap();
		Map<Integer,Double> housedeposits=new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			double sum=0d;
			double housesum=0d;
				if(caranswer.getLoans()==null||caranswer.getLoans().get(i)==null||caranswer.getLoans().get(i).getBusiness()==null||caranswer.getLoans().get(i).getBusiness().getTotal()==null){
					sum=sum+0;
				}else
				{
				sum=sum+caranswer.getLoans().get(i).getBusiness().getTotal().doubleValue();
				}
				if(caranswer.getLoans()==null||caranswer.getLoans().get(i)==null||caranswer.getLoans().get(i).getCapital()==null){
					cardeposits.put(i,0d);
				}else
				{
					cardeposits.put(i, caranswer.getLoans().get(i).getCapital());
				}
				if(estateanswer.getLoans()==null||estateanswer.getLoans().get(i)==null||estateanswer.getLoans().get(i).getAccumulation()==null||estateanswer.getLoans().get(i).getAccumulation().getTotal()==null)
				{
					sum=sum+0;
				}else
				{
					sum=sum+estateanswer.getLoans().get(i).getAccumulation().getTotal().doubleValue();
				}
				if(estateanswer.getLoans()==null||estateanswer.getLoans().get(i)==null||estateanswer.getLoans().get(i).getBusiness()==null||estateanswer.getLoans().get(i).getBusiness().getTotal()==null)
				{
					sum=sum+0;
				}
				else
				{
					sum=sum+estateanswer.getLoans().get(i).getBusiness().getTotal().doubleValue();
				}
				if(estateanswer.getLoans()==null||estateanswer.getLoans().get(i)==null||estateanswer.getLoans().get(i).getAccumulationCapital()==null){
					housesum=housesum+0;
				}else
				{
					housesum=housesum+estateanswer.getLoans().get(i).getAccumulationCapital();
				}
				if(estateanswer.getLoans()==null||estateanswer.getLoans().get(i)==null||estateanswer.getLoans().get(i).getBusinessCapital()==null){
					housesum=housesum+0;
				}else
				{
					housesum=housesum+estateanswer.getLoans().get(i).getBusinessCapital();
				}
					housedeposits.put(i, housesum);
					deposits.put(i, sum);
		}		
		put("deposits",deposits);
		put("housedeposits",housedeposits);
		put("cardeposits",cardeposits);
		
		/**保险支出*/
		/**保单保额保费*/
		
		Map<Integer,Double> insurances = new HashMap();	
		Map<Integer,Double> coverages=new HashMap();
		for(int i=1;i<=getPlanYears();i++)
		{
			insurances.put(i, 0d);
			coverages.put(i,0d);
		}
		
		EntityQuery productquery = new EntityQuery();		

		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);

			productquery=new EntityQuery(InsurancePlanPolicyAnswer.class, "policyanswer");
			productquery.add(new Condition("policyanswer.answer.caze.id=:cazeId", cazeId));		
			productquery.add(new Condition("policyanswer.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyAnswer> memberpolicy=entityService.search(productquery);
			
		for (InsurancePlanPolicyAnswer policyAnswer : memberpolicy) {
			int paytime=calcYears(member.getAge(),policyAnswer.getPayTime().getDuration());
			for(int i=policyAnswer.getApplyOn();i<=paytime+policyAnswer.getApplyOn();i++)
			{
				if (i>30) 
				{
				 break;
				 }
				insurances.put(i, insurances.get(i)+policyAnswer.getExpense().doubleValue());
			}
			int insurancetime=calcYears(member.getAge()+policyAnswer.getApplyOn(),policyAnswer.getTime().getDuration());
			for(int i=policyAnswer.getApplyOn();i<=insurancetime+policyAnswer.getApplyOn();i++)
			{
				if (i>30) 
				{
				 break; 
				}
				coverages.put(i,coverages.get(i)+policyAnswer.getCoverage().doubleValue());/**保额*/
			}
		}
		}
		put("insurances",insurances);
		put("coverages",coverages);
		
		/**其他支出*/
	     query = new EntityQuery(OtherExpensePlanAnswer.class, "expensePlan");
		query.add(new Condition("expensePlan.caze.id=:cazeId", cazeId));
		List<OtherExpensePlanAnswer> expenseanswers=entityService.search(query);
		OtherExpensePlanAnswer expenseanswer=new OtherExpensePlanAnswer();		
		if (!expenseanswers.isEmpty()){
			expenseanswer=expenseanswers.get(0);
		}
		Map<Integer, Double> expenses = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((expenseanswer.getAmounts()==null)||(expenseanswer.getAmounts().get(i)==null))
			{
				expenses.put(i,0d);
			}
			else
			{
				expenses.put(i, expenseanswer.getAmounts().get(i));
			}
		}	
		
		put("expenses",expenses);
		
		
		
		/**理财收入支出*/
		Caze caze=(Caze)entityService.load(Caze.class, cazeId);
		FinanceAssetPlanAnswer planAnswer=getFinanceAssetPlanAnswer();
	    query = new EntityQuery(FinancePlanAnswer.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.answer.caze.id=:cazeid", cazeId));
		List<FinancePlanAnswer> financeanswers=entityService.search(query);		
		double firstbalance=getFirstBalance(caze);
		
		Map<Integer,Double> totalcapital=new HashMap();
		Map<Integer,Double> totalexpense=new HashMap();/**追加*/
		Map<Integer,Double> totalincome=new HashMap();/**收益*/
		Map<Integer,Double> totalbalance=new HashMap();/**结余*/

		for(int i=1;i<=getPlanYears();i++)
		{
			totalcapital.put(i, 0d);
		}		
		for(int i=1;i<=getPlanYears();i++)
		{
			totalexpense.put(i, 0d);
		}			
		for(int i=1;i<=getPlanYears();i++)
		{
			totalincome.put(i, 0d);
		}
		Map<String,Double> lastcapital=new HashMap();
		for(FinancePlanAnswer plananswer:financeanswers)
		{
			lastcapital.put(plananswer.getFinancetype().getName(), plananswer.getAmount());
		}
for(int i=1;i<=getPlanYears();i++)
{
	double expense=0d;
	double income=0d;
	double capital=0d;/*期初+追加资产*/
	double balance=0d;

	if(i==1)
	{
		for(FinancePlanAnswer plananswer:financeanswers)
		{
			if(plananswer.getStartYear()==1)
			{

				expense=expense+plananswer.getAppend().doubleValue()*firstbalance/100d;
				capital=capital+plananswer.getAmount()+plananswer.getAppend().doubleValue()*firstbalance/100d;
				income=income+(plananswer.getAmount()+firstbalance*plananswer.getAppend().doubleValue()/100d)*plananswer.getRate().doubleValue()/100d;
				lastcapital.put(plananswer.getFinancetype().getName(), plananswer.getAmount()+plananswer.getAppend().doubleValue()*firstbalance/100d);
			}
		}
	}else
	{
		for(FinancePlanAnswer plananswer:financeanswers)
		{
			if((i<=plananswer.getEndYear())&&(i>=plananswer.getStartYear()))
			{
				double nowcapital=0d;
				expense=expense+plananswer.getAppend().doubleValue()*totalbalance.get(i-1)/100d;
				if (i==plananswer.getStartYear()){
					nowcapital=plananswer.getAmount()+plananswer.getAppend().byteValue()*totalbalance.get(i-1)/100d;
				}else
				{
					nowcapital=lastcapital.get(plananswer.getFinancetype().getName())*(1+plananswer.getRate().doubleValue()/100d)+plananswer.getAppend().byteValue()*totalbalance.get(i-1)/100d;
				}
				capital=capital+nowcapital;
				lastcapital.put(plananswer.getFinancetype().getName(), nowcapital);
				income=income+(nowcapital)*plananswer.getRate().doubleValue()/100d;
			}
		}
	}
	balance=cashes.get(i)+bonuses.get(i)+incomes.get(i)+income-consumes.get(i)
			-expense-educations.get(i)-trips.get(i)-medicals.get(i)-deposits.get(i)
			-insurances.get(i)-expenses.get(i);
	totalexpense.put(i,expense);
	totalincome.put(i,income);
	totalcapital.put(i,capital+income);/**期初+追加+收益*/
	totalbalance.put(i,balance);
}
put("capitals",totalcapital);
put("investexpenses",totalexpense);
put("investincomes",totalincome);	
put("balances",totalbalance);
	



	/**房屋资产**/

		query = new EntityQuery(EstateLoanPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<EstateLoanPlanAnswer> estatePlananswers = entityService.search(query);
		EstateLoanPlanAnswer estatePlananswer = new EstateLoanPlanAnswer();
		if (!estatePlananswers.isEmpty()) {
			estatePlananswer = (EstateLoanPlanAnswer) estatePlananswers.get(0);
		} 
		Map<Integer, Double> estates = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((estatePlananswer.getExpenses()==null)||(estatePlananswer.getExpenses().get(i)==null))
			{
				estates.put(i,0d);
			}
			else
			{
				estates.put(i, estatePlananswer.getExpenses().get(i));
			}
		}	
		put("estates",estates);

		//**汽车资产**/
		query = new EntityQuery(CarPlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List<CarPlanAnswer> carPlananswers = entityService.search(query);
		CarPlanAnswer carPlananswer = new CarPlanAnswer();
		if (!carPlananswers.isEmpty()) {
			carPlananswer = (CarPlanAnswer) carPlananswers.get(0);
		} 
		Map<Integer, Double> cars = new HashMap();		
		for(int i=1;i<=getPlanYears();i++)
		{
			if((carPlananswer.getExpenses()==null)||(carPlananswer.getExpenses().get(i)==null))
			{
				cars.put(i,0d);
			}
			else
			{
				cars.put(i, carPlananswer.getExpenses().get(i));
			}
		}			
		put("cars",cars);














		
		return forward();
	}
	
	

	protected FinanceAssetPlanAnswer getFinanceAssetPlanAnswer() {
		EntityQuery query = new EntityQuery(FinanceAssetPlanAnswer.class, "answer");
		Long cazeId = getLong("caze.id");
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
	
	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		PlanSummaryAnswer answer = getPlanSummaryAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	
	private PlanSummaryAnswer getPlanSummaryAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(PlanSummaryAnswer.class, "plansummary");
		query.add(new Condition("plansummary.caze.id=:cazeId", cazeId));
		List<PlanSummaryAnswer> answers = entityService.search(query);
		PlanSummaryAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new PlanSummaryAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}
	/**计算保险期限，缴费期限的年份*/	
	/**计算保险期限，缴费期限的年份*/	
	private Integer calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return 30;
		}
		else 
		{
			if(StringUtils.contains(script, "age"))
			{
				return Integer.parseInt(script.substring(0,script.indexOf("-")))-age+1;
			}
			else
			{
				return Integer.parseInt(script)-1;
			}
		}
	}
	
	public String info() {
		index();
		return forward();
	}
	
	public String infolet() {
		index();
		return forward("../../infolet/info");
	}	
}