package org.expr.web.action.evaluation.answer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.ExpendAnswer;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.analysis.answer.FinanceAssetAnswer;
import org.expr.model.analysis.answer.IncomeAnswer;
import org.expr.model.analysis.answer.InsurancePolicyAnswer;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;

public class AnalysisChartsStatAction extends AbstractEvaluationAnswerAction {
	
	public String index() {
        return forward();
    }
	
	public String incomeExpense() {
		/**理财前*/
		Long cazeid = getLong("caze.id");
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));
		Double nowTotalIncomeAmount = 0d;
		Double nowTotalExpendAmount = 0d;
		EntityQuery nowTotalQuery = new EntityQuery(BalanceOfPaymentAnswer.class, "balanceOfPaymentAnswer");
		nowTotalQuery.add(new Condition("balanceOfPaymentAnswer.caze.id=" + cazeid));
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			BalanceOfPaymentAnswer balanceOfPaymentAnswer = (BalanceOfPaymentAnswer)nowTotalAmountList.get(0);
			nowTotalIncomeAmount = balanceOfPaymentAnswer.getForm().getTotalIncome().doubleValue();
			nowTotalExpendAmount = balanceOfPaymentAnswer.getForm().getTotalExpend().doubleValue();
		}
		put("nowTotalIncomeAmount", nowTotalIncomeAmount);
		put("nowTotalExpendAmount", nowTotalExpendAmount);
		List notZeroItemsIncome = new ArrayList();
		List notZeroItemsExpense = new ArrayList();
		
		EntityQuery nowIncomeQuery = new EntityQuery(IncomeAnswer.class, "incomeAnswer");
        nowIncomeQuery.add(new Condition("incomeAnswer.answer.caze.id=" + cazeid));
        nowIncomeQuery.groupBy("incomeAnswer.income.incomeProject");
        nowIncomeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(incomeAnswer.income.amount), incomeAnswer.income.incomeProject) ");
        nowIncomeQuery.add(new Condition("incomeAnswer.income.incomeProject.parent is null"));
		List nowIncomeItems = entityService.search(nowIncomeQuery);
		DefaultPieDataset nowIncomeDataSet = new DefaultPieDataset();
		if (!nowIncomeItems.isEmpty()) {
			Collections.sort(nowIncomeItems);
	        for (Iterator iter = nowIncomeItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalIncomeAmount*10000);
	            	nowIncomeDataSet.setValue(((IncomeProject) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	                notZeroItemsIncome.add(item);
	            }
	        }
		}
		put("nowIncome", new GeneralDatasetProducer("test", nowIncomeDataSet));
		put("countResultIncome", notZeroItemsIncome);
		
		EntityQuery nowExpenseQuery = new EntityQuery(ExpendAnswer.class, "expendAnswer");
		nowExpenseQuery.add(new Condition("expendAnswer.answer.caze.id=" + cazeid));
		nowExpenseQuery.groupBy("expendAnswer.expend.expendProject");
		nowExpenseQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(expendAnswer.expend.amount), expendAnswer.expend.expendProject) ");
		nowExpenseQuery.add(new Condition("expendAnswer.expend.expendProject.parent is null"));
		List nowExpenseItems = entityService.search(nowExpenseQuery);
		DefaultPieDataset nowExpenseDataSet = new DefaultPieDataset();
		if (!nowExpenseItems.isEmpty()) {
			Collections.sort(nowExpenseItems);
	
	        for (Iterator iter = nowExpenseItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalExpendAmount*10000);
	            	nowExpenseDataSet.setValue(((ExpendProject) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	                notZeroItemsExpense.add(item);
	            }
	        }
		}
		put("nowExpense", new GeneralDatasetProducer("test", nowExpenseDataSet));
		put("countResultExpense", notZeroItemsExpense);

		
		
		
		
		String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.parseInt(year);
		/*List notZeroItems = new ArrayList();
		if (year != null && "".equals(year)) {
            
            DefaultPieDataset dataset = new DefaultPieDataset();
            CountItem item = new CountItem(1,"");
            if (item.getCount().intValue() != 0) {
                dataset.setValue(((Department) item.getWhat()).getName(), item.getCount()
                        .intValue());
                notZeroItems.add(item);
            }
            put("year", year);
            put("incomeExpense", new GeneralDatasetProducer("test", dataset));
        }
		put("countResult", notZeroItems);*/
		put("defaultYear", year);
		
/**理财后*/
		FinanceAssetPlanAnswer planAnswer=getFinanceAssetPlanAnswer(caze);
		EntityQuery query = new EntityQuery(FinancePlanAnswer.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.answer.caze.id=:cazeid", caze.getId()));
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanAnswer> financeanswers=entityService.search(query);
		
		double firstbalance=getFirstBalance(caze);
	
		Map<String,Map<Integer,Double>> capitals=new HashMap();
		Map<String,Map<Integer,Double>> expenses=new HashMap();/**追加*/
		Map<String,Map<Integer,Double>> incomes=new HashMap();/**收益*/
		
		 Map<Integer,Double>[] expensearray=new Map[financeanswers.size()];
		 Map<Integer,Double>[] capitalarray=new Map[financeanswers.size()];
		 Map<Integer,Double>[] incomearray=new Map[financeanswers.size()];
			for(int i=0;i<financeanswers.size();i++){
				expensearray[i]=new HashMap<Integer, Double>();
				capitalarray[i]=new HashMap<Integer, Double>();
				incomearray[i]=new HashMap<Integer, Double>();	
			}
			for(int i=1;i<=getPlanYears();i++)
			{
				double expense=0d;
				double capital=0d;/**期初资产*/
				double income=0d;
				if(i==1){
					for(int j=0;j<financeanswers.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;
						FinancePlanAnswer plananswer=financeanswers.get(j);
						if(plananswer.getStartYear()==1)
						{
							expense=plananswer.getAppend().doubleValue()*firstbalance/100d;
							capital=plananswer.getAmount();
							income=(capital+expense)*plananswer.getRate()/100d;
						}
						expensearray[j].put(i, expense);
						capitalarray[j].put(i,capital);
						incomearray[j].put(i,income);
					}
				}else
				{/**计算上一年收益和支出*/
					double lastexpense=0d;
					double lastincome=0d;
					double lastbalance=0d;
					for(int p=0;p<financeanswers.size();p++){
						if((i>financeanswers.get(p).getStartYear())&&(i<=financeanswers.get(p).getEndYear()+1))
						{
							lastexpense=expensearray[p].get(i-1)+lastexpense;
							lastincome=incomearray[p].get(i-1)+lastincome;
						}
					}
					lastbalance=getYearCashes(caze,i-1)+getYearBonuses(caze,i-1)+getYearOtherIncomes(caze,i-1)+lastincome-getYearConsumes(caze,i-1)
					-lastexpense-getYearEducations(caze,i-1)-getYearTrips(caze,i-1)-getYearMedicals(caze,i-1)-getYearDeposits(caze,i-1)
					-getYearInsurances(caze,i-1)-getYearOtherExpenses(caze,i-1);
					
					for(int j=0;j<financeanswers.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;			
						FinancePlanAnswer plananswer=financeanswers.get(j);
						if((plananswer.getStartYear()<=i)&&(plananswer.getEndYear()>=i)){
						if(plananswer.getStartYear()==i)
						{
							expense=plananswer.getAppend().doubleValue()*lastbalance/100d;
							capital=plananswer.getAmount();
							income=(expense+capital)*plananswer.getRate()/100d;
						}else
						{
							expense=plananswer.getAppend().doubleValue()*lastbalance/100d;
							capital=expensearray[j].get(i-1)+incomearray[j].get(i-1)+capitalarray[j].get(i-1);
							income=(expense+capital)*plananswer.getRate()/100d;							
						}
						}
						expensearray[j].put(i, expense);
						capitalarray[j].put(i,capital);
						incomearray[j].put(i,income);
					}
				}
			}
			for(int i=0;i<financeanswers.size();i++){
				capitals.put(financeanswers.get(i).getFinancetype().getName(), capitalarray[i]);
				expenses.put(financeanswers.get(i).getFinancetype().getName(), expensearray[i]);
				incomes.put(financeanswers.get(i).getFinancetype().getName(), incomearray[i]);				
			}
			/**第n年金融收入、支出、资本*/
			Map<Integer,Double> yearincomes=new HashMap();
			Map<Integer,Double> yearexpenses=new HashMap();	
			Map<Integer,Double> yearcapitals=new HashMap();
			for(int i=1;i<=getPlanYears();i++){
				double tempincome=0d;
				double tempexpense=0d;
				double tempcapital=0d;
				for(int j=0;j<financeanswers.size();j++)
				{
					FinancePlanAnswer plan=financeanswers.get(j);
					tempincome=incomes.get(plan.getFinancetype().getName()).get(i)+tempincome;
					tempexpense=expenses.get(plan.getFinancetype().getName()).get(i)+tempexpense;
					tempcapital=capitals.get(plan.getFinancetype().getName()).get(i)+tempcapital;
				}
				yearincomes.put(i, tempincome);
				yearexpenses.put(i,tempexpense);
				yearcapitals.put(i, tempcapital);
			}
				
			
			
		
	/*收入*/	
		double laterTotalIncomeAmount=0d;
		laterTotalIncomeAmount=getYearCashes(caze,intyear)+getYearBonuses(caze,intyear)+yearincomes.get(intyear)+getYearOtherIncomes(caze,intyear);
		DefaultPieDataset laterIncomeDataSet = new DefaultPieDataset();
		List<IncomeProject> laterIncomeProjects=getTopIncomeProjects();
		
		if (!laterIncomeProjects.isEmpty()) {
			Collections.sort(laterIncomeProjects);
	        for (Iterator iter = laterIncomeProjects.iterator(); iter.hasNext();) {
	        	IncomeProject project=(IncomeProject)iter.next();
	        	double pertempValue=0d;
	        	double tempValue=0d;
	        	if(project.getName().equals("工资性收入")){
	        		tempValue=getYearCashes(caze,intyear)+getYearBonuses(caze,intyear);
	        		pertempValue=Math.rint((getYearCashes(caze,intyear)+getYearBonuses(caze,intyear))/laterTotalIncomeAmount*10000);
	        	}else if(project.getName().equals("理财性收入")){
	        		tempValue=yearincomes.get(intyear);
	        		pertempValue=Math.rint((yearincomes.get(intyear))/laterTotalIncomeAmount*10000);

	        	}else if(project.getName().equals("其他收入")){
	        		tempValue=getYearOtherIncomes(caze,intyear);
	        		pertempValue=Math.rint((getYearOtherIncomes(caze,intyear))/laterTotalIncomeAmount*10000);
	        	}

	        	laterIncomeDataSet.setValue(project.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
	        	
	        }
	    }
		put("laterIncome", new GeneralDatasetProducer("test", laterIncomeDataSet));
		put("laterTotalIncomeAmount",laterTotalIncomeAmount);
		
		
		
		/**支出*/
		double laterTotalExpenseAmount=0d;
		laterTotalExpenseAmount=getYearConsumes(caze,intyear)+getYearEducations(caze,intyear)+getYearMedicals(caze,intyear)+getYearHouseDeposits(caze,intyear)+getYearCarDeposits(caze,intyear)+yearexpenses.get(intyear)+getYearInsurances(caze,intyear)
		+getYearTrips(caze,intyear)+getYearOtherExpenses(caze,intyear);
		DefaultPieDataset laterExpendDataSet = new DefaultPieDataset();
		List<ExpendProject> laterExpenseProjects=getTopExpendProjects();
		if (!laterExpenseProjects.isEmpty()) {
			Collections.sort(laterExpenseProjects);
	        for (Iterator iter = laterExpenseProjects.iterator(); iter.hasNext();) {
	        	ExpendProject project=(ExpendProject)iter.next();
	        	double pertempValue=0d;
	        	double tempValue=0d;
	        	if(project.getName().equals("消费支出")){
	        		tempValue=getYearConsumes(caze,intyear);
	        		pertempValue=Math.rint((getYearConsumes(caze,intyear))/laterTotalExpenseAmount*10000);

	        	}else if(project.getName().equals("教育支出")){
	        		tempValue=getYearEducations(caze,intyear);        		
	        		pertempValue=Math.rint((getYearEducations(caze,intyear))/laterTotalExpenseAmount*10000);
	        	}else if(project.getName().equals("医疗支出")){
	        		tempValue=getYearMedicals(caze,intyear);	        		
	        		pertempValue=Math.rint((getYearMedicals(caze,intyear))/laterTotalExpenseAmount*10000);

	        	}else if(project.getName().equals("贷款支出")){
	        		tempValue=getYearHouseDeposits(caze,intyear)+getYearCarDeposits(caze,intyear);
	        		pertempValue=Math.rint((getYearHouseDeposits(caze,intyear)+getYearCarDeposits(caze,intyear))/laterTotalExpenseAmount*10000);

	        	}else if(project.getName().equals("投资支出")){
	        		tempValue=yearexpenses.get(intyear); 	        		
	        		pertempValue=Math.rint((yearexpenses.get(intyear))/laterTotalExpenseAmount*10000);
	        	}else if(project.getName().equals("保费支出")){
	        		tempValue=getYearInsurances(caze,intyear);		        		
	        		pertempValue=Math.rint((getYearInsurances(caze,intyear))/laterTotalExpenseAmount*10000);        		
	        	}else if(project.getName().equals("旅游支出")){
	        		tempValue=getYearTrips(caze,intyear);	  	        		
	        		pertempValue=Math.rint((getYearTrips(caze,intyear))/laterTotalExpenseAmount*10000);	   	        		
	        	}else if(project.getName().equals("其他支出")){
	        		tempValue=getYearOtherExpenses(caze,intyear);	        		
	        		pertempValue=Math.rint((getYearOtherExpenses(caze,intyear))/laterTotalExpenseAmount*10000);	        		
	        	}	

	        	laterExpendDataSet.setValue(project.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
	        	
	        }
	    }
		put("laterExpense", new GeneralDatasetProducer("test", laterExpendDataSet));
		put("laterTotalExpendAmount",laterTotalExpenseAmount);
		return forward();
	}
	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}
	
	private List getTopIncomeProjects() {
		EntityQuery query = new EntityQuery(IncomeProject.class, "project");
		query.add(new Condition("project.parent is null"));
		List IncomeProjects = entityService.search(query);
		return IncomeProjects;
	}
	private List getTopExpendProjects() {
		EntityQuery query = new EntityQuery(ExpendProject.class, "project");
		query.add(new Condition("project.parent is null"));
		List ExpendProjects = entityService.search(query);
		return ExpendProjects;
	}	
	private List getTopInsuranceTypes() {
		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
		query.add(new Condition("insuranceType.parent is null"));
		List insuranceTypes = entityService.search(query);
		return insuranceTypes;
	}
	public String insuranceAnalysis() {
		Long cazeid = getLong("caze.id");
		Double nowTotalAmount = 0d;
		EntityQuery nowTotalQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
		nowTotalQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
		nowTotalQuery.setSelect("select sum(insurancePolicyAnswer.policy.coverage)");
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			nowTotalAmount = (Double)nowTotalAmountList.get(0);
		}
		put("nowTotalAmount", nowTotalAmount);
		
		
		
		/**取人员*/		
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeid));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members",members);
		Map<String,Double> nowMemberTotalAmountMap=new HashMap();
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			Double nowMemberTotalAmount = 0d;
			EntityQuery nowMemberTotalQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
			nowMemberTotalQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
			nowMemberTotalQuery.add(new Condition("insurancePolicyAnswer.policy.insurant='" + member.getName()+"'"));
			nowMemberTotalQuery.setSelect("select sum(insurancePolicyAnswer.policy.coverage)");
			List nowMemberTotalAmountList = entityService.search(nowMemberTotalQuery);
			if (!nowMemberTotalAmountList.isEmpty()) {
				nowMemberTotalAmount = (Double)nowMemberTotalAmountList.get(0)==null?0:(Double)nowMemberTotalAmountList.get(0);
			}
			nowMemberTotalAmountMap.put(member.getName(), nowMemberTotalAmount);
		}
		put("nowMemberTotalAmountMap",nowMemberTotalAmountMap);
		
		// 按保险类型
		List notZeroItemsInsuranceType = new ArrayList();
		EntityQuery nowInsuranceTypeQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
        nowInsuranceTypeQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
        nowInsuranceTypeQuery.groupBy("insurancePolicyAnswer.policy.type.parent");
        nowInsuranceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyAnswer.policy.coverage), insurancePolicyAnswer.policy.type.parent) ");
        List nowInsuranceTypeItems = entityService.search(nowInsuranceTypeQuery);
		DefaultPieDataset nowInsuranceTypeDataSet = new DefaultPieDataset();
		if (!nowInsuranceTypeItems.isEmpty()) {
			Collections.sort(nowInsuranceTypeItems);
	        for (Iterator iter = nowInsuranceTypeItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
	            	nowInsuranceTypeDataSet.setValue(((InsuranceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	                notZeroItemsInsuranceType.add(item);
	            }
	        }
		}
		put("nowInsuranceType", new GeneralDatasetProducer("test", nowInsuranceTypeDataSet));
		put("countResultInsuranceType", notZeroItemsInsuranceType);
		// 按被保险人
		List notZeroItemsInsurant = new ArrayList();
		EntityQuery nowInsurantQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
        nowInsurantQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
        nowInsurantQuery.groupBy("insurancePolicyAnswer.policy.insurant");
        nowInsurantQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyAnswer.policy.coverage), insurancePolicyAnswer.policy.insurant) ");
		List nowInsurantItems = entityService.search(nowInsurantQuery);
		DefaultPieDataset nowInsurantDataSet = new DefaultPieDataset();
		if (!nowInsurantItems.isEmpty()) {
			Collections.sort(nowInsurantItems);
	        for (Iterator iter = nowInsurantItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
	            	nowInsurantDataSet.setValue(item.getWhat() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	                notZeroItemsInsurant.add(item);
	            }
	        }
		}
		put("nowInsurant", new GeneralDatasetProducer("test", nowInsurantDataSet));
		put("countResultInsurant", notZeroItemsInsurant);
		
		Map<String,GeneralDatasetProducer> nowMemberInsuranceTypeMap=new HashMap();
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			if((nowMemberTotalAmountMap.get(member.getName())==0d)||(nowMemberTotalAmountMap.get(member.getName())==null)){
			}else{	
			Double nowMemberTotalAmount	=nowMemberTotalAmountMap.get(member.getName());
			List notZeroMemberItemsInsuranceType = new ArrayList();
			EntityQuery nowMemberInsuranceTypeQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
			nowMemberInsuranceTypeQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
			nowMemberInsuranceTypeQuery.add(new Condition("insurancePolicyAnswer.policy.insurant='" + member.getName()+"'"));
			nowMemberInsuranceTypeQuery.groupBy("insurancePolicyAnswer.policy.type.parent");
			nowMemberInsuranceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(insurancePolicyAnswer.policy.coverage), insurancePolicyAnswer.policy.type.parent) ");
			List nowMemberInsuranceTypeItems = entityService.search(nowMemberInsuranceTypeQuery);			

			DefaultPieDataset nowMemberInsuranceTypeDataSet = new DefaultPieDataset();
			if (!nowMemberInsuranceTypeItems.isEmpty()) {
				Collections.sort(nowMemberInsuranceTypeItems);
		        for (Iterator iter = nowMemberInsuranceTypeItems.iterator(); iter.hasNext();) {
		            CountItem item = (CountItem) iter.next();
		            if (item.getCount().intValue() != 0) {
		            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowMemberTotalAmount*10000);
		            	nowMemberInsuranceTypeDataSet.setValue(((InsuranceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
		                        .intValue());
		            	notZeroMemberItemsInsuranceType.add(item);
		            }
		        }
			}
			put("nowMemberInsuranceType"+member.getName(), new GeneralDatasetProducer("test", nowMemberInsuranceTypeDataSet));
			}
		}	
		
		
		
		
		/*
		 * 
			理财后
		 */
		String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.parseInt(year);
		put("defaultYear", year);	

		/**每个成员每种类型保额*/
		Map<String,Map<String, Map<Integer,Double>>>coverages = new HashMap();		
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			Map<String, Map<Integer,Double>> typecoverages = new HashMap();			
			EntityQuery productquery=new EntityQuery(InsurancePlanPolicyAnswer.class, "policyanswer");
			productquery.add(new Condition("policyanswer.answer.caze.id=:cazeId", cazeid));		
			productquery.add(new Condition("policyanswer.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyAnswer> memberpolicy=entityService.search(productquery);
			List<InsuranceType> insurancetypes=getTopInsuranceTypes();
			for (InsuranceType insurancetype : insurancetypes) {
				Map<Integer, Double> coverage=new HashMap();
				for(int i=0;i<=getPlanYears();i++)
				{
					coverage.put(i, 0d);
				}
				for(InsurancePlanPolicyAnswer policyAnswer : memberpolicy){
					if(policyAnswer.getProduct().getType().getParent()==insurancetype){
						int insurancetime=calcYears(member.getAge()+policyAnswer.getApplyOn(),policyAnswer.getTime().getDuration());
						for(int i=policyAnswer.getApplyOn();i<=insurancetime+policyAnswer.getApplyOn();i++)
						{
							if (i>30) 
							{
							 break; 
							}
							coverage.put(i,coverage.get(i)+policyAnswer.getCoverage().doubleValue());/**保额*/
						}						
					}
				}
				typecoverages.put(insurancetype.getName(), coverage);
			}
			coverages.put(member.getName(), typecoverages);
		}		
			


		/**第intyear的总保额和个人的总保额*/
		Double laterTotalCoverage=0d;
		Map<String,Double> sumcoverage=new HashMap();
		List<InsuranceType> insurancetypes=getTopInsuranceTypes();
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			Double membersum=0d;
				for(InsuranceType insurancetype : insurancetypes)
					{
						membersum=membersum+coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
					}
				sumcoverage.put(member.getName(), membersum);
				laterTotalCoverage=laterTotalCoverage+membersum;			
		}
		put("laterTotalCoverage",laterTotalCoverage);

		/**按被保险人统计*/		
		DefaultPieDataset laterInsurantDataSet = new DefaultPieDataset();
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);	
			double tempValue=sumcoverage.get(member.getName());
    		double pertempValue = Math.rint(tempValue/laterTotalCoverage*10000);	
    		if (tempValue!=0){
    			laterInsurantDataSet.setValue(member.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
    		}
		}
		
		put("laterInsurant", new GeneralDatasetProducer("test", laterInsurantDataSet));	
		
		/**按保险类型统计*/
		DefaultPieDataset laterInsuranceType = new DefaultPieDataset();
		for(InsuranceType insurancetype : insurancetypes)	{
			double tempValue=0d;
			for(FamilyMember member : members){
			 tempValue=tempValue+coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
			}
    		double pertempValue = Math.rint(tempValue/laterTotalCoverage*10000);	
    		if (tempValue!=0){
    			laterInsuranceType.setValue(insurancetype.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
    		}
		}
		
		put("laterInsuranceType", new GeneralDatasetProducer("test", laterInsuranceType));			
		/**按每个人保险类型统计*/
		Map<String,Double> laterMemberTotalAmountMap=new HashMap();
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			laterMemberTotalAmountMap.put(member.getName(), sumcoverage.get(member.getName()));
		}
		put("laterMemberTotalAmountMap",laterMemberTotalAmountMap);		

		
		
		for ( int j=0;j<members.size();j++) {
			FamilyMember member= members.get(j);
			if((laterMemberTotalAmountMap.get(member.getName())==0d)||(laterMemberTotalAmountMap.get(member.getName())==null)){
			}else{	
				DefaultPieDataset laterMemberInsuranceType = new DefaultPieDataset();
				for(InsuranceType insurancetype : insurancetypes)	{
					double tempValue=coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
		    		double pertempValue = Math.rint(tempValue/laterTotalCoverage*10000);	
		    		if (tempValue!=0){
		    			laterMemberInsuranceType.setValue(insurancetype.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
		    		}
				}
				
			put("laterMemberInsuranceType"+member.getName(), new GeneralDatasetProducer("test", laterMemberInsuranceType));
			}
		}		
	
		
		
	/***	 按被保险人以及保险类型
		List notZeroItemsInsurantAndType = new ArrayList();
		EntityQuery nowInsurantAndTypeQuery = new EntityQuery(InsurancePolicyAnswer.class, "insurancePolicyAnswer");
        nowInsurantAndTypeQuery.add(new Condition("insurancePolicyAnswer.answer.caze.id=" + cazeid));
        nowInsurantAndTypeQuery.groupBy("insurancePolicyAnswer.policy.insurant,insurancePolicyAnswer.policy.type.name");
        nowInsurantAndTypeQuery.setSelect("select sum(insurancePolicyAnswer.policy.coverage), insurancePolicyAnswer.policy.insurant,insurancePolicyAnswer.policy.type.name ");
		List nowInsurantAndTypeItems = entityService.search(nowInsurantAndTypeQuery);
		DefaultPieDataset nowInsurantAndTypeDataSet = new DefaultPieDataset();
		if (!nowInsurantAndTypeItems.isEmpty()) {
	        for (Iterator iter = nowInsurantAndTypeItems.iterator(); iter.hasNext();) {
	            Object[] item = (Object[]) iter.next();
	            Double count = (Double)item[0];
	            if (count != 0) {
	            	double tempValue = Math.rint(count/nowTotalAmount*10000);
	            	nowInsurantAndTypeDataSet.setValue(item[1] + "  " + item[2] + "  ("+ tempValue/100 +"%)", count
	                        .intValue());
	                notZeroItemsInsurantAndType.add(item);
	            }
	        }
		}
		put("nowInsurantAndType", new GeneralDatasetProducer("test", nowInsurantAndTypeDataSet));
		put("countResultInsurantAndType", notZeroItemsInsurantAndType);
		*/
		

		return forward();
	}
	/**计算保险期限，缴费期限的年份*/	
	private Integer calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return 30;
		}
		else 
		{
			if(StringUtils.contains(script, "age"))
			{
				return Integer.parseInt(script.substring(script.indexOf("-")))-age+1;
			}
			else
			{
				return Integer.parseInt(script)-1;
			}
		}
	}
		
	public String financeAssetAnalysis() {
		Long cazeid = getLong("caze.id");
		Double nowTotalAmount = 0d;
		EntityQuery nowTotalQuery = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowTotalQuery.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowTotalQuery.setSelect("select sum(financeAssetAnswer.asset.amount)");
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			nowTotalAmount = (Double)nowTotalAmountList.get(0);
		}
		put("nowTotalAmount", nowTotalAmount);
		// 按资产类型
		List notZeroItemsFinanceType = new ArrayList();
		EntityQuery nowFinanceTypeQuery = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowFinanceTypeQuery.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowFinanceTypeQuery.groupBy("financeAssetAnswer.asset.financetype.parent");
		nowFinanceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetAnswer.asset.amount), financeAssetAnswer.asset.financetype.parent) ");
		//nowFinanceTypeQuery.add(new Condition("financeAssetAnswer.asset.financetype.parent is null"));
		List nowFinanceTypeItems = entityService.search(nowFinanceTypeQuery);
		DefaultPieDataset nowFinanceTypeDataSet = new DefaultPieDataset();
		if (!nowFinanceTypeItems.isEmpty()) {
			Collections.sort(nowFinanceTypeItems);
	        for (Iterator iter = nowFinanceTypeItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
	            	nowFinanceTypeDataSet.setValue(((FinanceType) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	            	notZeroItemsFinanceType.add(item);
	            }
	        }
		}
		put("nowFinanceType", new GeneralDatasetProducer("test", nowFinanceTypeDataSet));
		put("countResultFinanceType", notZeroItemsFinanceType);
		
				
		
		// 按风险等级
		List notZeroItemsRiskGrade = new ArrayList();
		EntityQuery nowRiskGradeQuery = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowRiskGradeQuery.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowRiskGradeQuery.groupBy("financeAssetAnswer.asset.riskgrade");
		nowRiskGradeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetAnswer.asset.amount), financeAssetAnswer.asset.riskgrade) ");
		List nowRiskGradeItems = entityService.search(nowRiskGradeQuery);
		DefaultPieDataset nowRiskGradeDataSet = new DefaultPieDataset();
		if (!nowRiskGradeItems.isEmpty()) {
			Collections.sort(nowRiskGradeItems);
	        for (Iterator iter = nowRiskGradeItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
	            	nowRiskGradeDataSet.setValue(((RiskGrade) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	            	notZeroItemsRiskGrade.add(item);
	            	
	            }
	        }
		}
		PiePlot pie;
		
		put("nowRiskGrade", new GeneralDatasetProducer("test", nowRiskGradeDataSet));
		put("countResultRiskGrade", notZeroItemsRiskGrade);
		
		// 按流动性
		List notZeroItemsMobility = new ArrayList();
		EntityQuery nowMobilityQuery = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowMobilityQuery.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowMobilityQuery.groupBy("financeAssetAnswer.asset.mobility");
		nowMobilityQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetAnswer.asset.amount), financeAssetAnswer.asset.mobility) ");
		List nowMobilityItems = entityService.search(nowMobilityQuery);
		DefaultPieDataset nowMobilityDataSet = new DefaultPieDataset();
		if (!nowMobilityItems.isEmpty()) {
			Collections.sort(nowMobilityItems);
	        for (Iterator iter = nowMobilityItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (item.getCount().intValue() != 0) {
	            	double tempValue = Math.rint(Double.parseDouble(item.getCount().toString())/nowTotalAmount*10000);
	            	nowMobilityDataSet.setValue(((Mobility) item.getWhat()).getName() + "  ("+ tempValue/100 +"%)", item.getCount()
	                        .intValue());
	            	notZeroItemsMobility.add(item);
	            	
	            }
	        }
		}
		put("nowMobility", new GeneralDatasetProducer("test", nowMobilityDataSet));
		put("countResultMobility", notZeroItemsMobility);
		
		// 按收益性分析对比
		EntityQuery nowRate20Query = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowRate20Query.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowRate20Query.add(new Condition("financeAssetAnswer.asset.rate>20"));
		List nowRate20Items = entityService.search(nowRate20Query);
		DefaultPieDataset nowRateDataSet = new DefaultPieDataset();
		if (!nowRate20Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate20Items.iterator(); iter.hasNext();) {
	        	FinanceAssetAnswer item = (FinanceAssetAnswer) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("大于百分之二十" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate10Query = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowRate10Query.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowRate10Query.add(new Condition("financeAssetAnswer.asset.rate>10 and financeAssetAnswer.asset.rate<=20"));
		List nowRate10Items = entityService.search(nowRate10Query);
		if (!nowRate10Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate10Items.iterator(); iter.hasNext();) {
	        	FinanceAssetAnswer item = (FinanceAssetAnswer) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之十与百分之二十之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate5Query = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowRate5Query.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowRate5Query.add(new Condition("financeAssetAnswer.asset.rate>5 and financeAssetAnswer.asset.rate<=10"));
		List nowRate5Items = entityService.search(nowRate5Query);
		if (!nowRate5Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate5Items.iterator(); iter.hasNext();) {
	        	FinanceAssetAnswer item = (FinanceAssetAnswer) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之五与百分之十之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate0Query = new EntityQuery(FinanceAssetAnswer.class, "financeAssetAnswer");
		nowRate0Query.add(new Condition("financeAssetAnswer.answer.caze.id=" + cazeid));
		nowRate0Query.add(new Condition("financeAssetAnswer.asset.rate<=5"));
		List nowRate0Items = entityService.search(nowRate0Query);
		if (!nowRate0Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate0Items.iterator(); iter.hasNext();) {
	        	FinanceAssetAnswer item = (FinanceAssetAnswer) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之零与百分之五之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		put("nowRate", new GeneralDatasetProducer("test", nowRateDataSet));
		
		String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.parseInt(year);
		put("defaultYear",year);
		
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));		
		FinanceAssetPlanAnswer planAnswer=getFinanceAssetPlanAnswer(caze);
		EntityQuery query = new EntityQuery(FinancePlanAnswer.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.answer.caze.id=:cazeid", caze.getId()));
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanAnswer> financeanswers=entityService.search(query);
		
		double firstbalance=getFirstBalance(caze);
	
		Map<String,Map<Integer,Double>> capitals=new HashMap();
		Map<String,Map<Integer,Double>> expenses=new HashMap();/**追加*/
		Map<String,Map<Integer,Double>> incomes=new HashMap();/**收益*/
		
		 Map<Integer,Double>[] expensearray=new Map[financeanswers.size()];
		 Map<Integer,Double>[] capitalarray=new Map[financeanswers.size()];
		 Map<Integer,Double>[] incomearray=new Map[financeanswers.size()];
			for(int i=0;i<financeanswers.size();i++){
				expensearray[i]=new HashMap<Integer, Double>();
				capitalarray[i]=new HashMap<Integer, Double>();
				incomearray[i]=new HashMap<Integer, Double>();	
			}
			for(int i=1;i<=getPlanYears();i++)
			{
				double expense=0d;
				double capital=0d;/**期初资产*/
				double income=0d;
				if(i==1){
					for(int j=0;j<financeanswers.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;
						FinancePlanAnswer plananswer=financeanswers.get(j);
						if(plananswer.getStartYear()==1)
						{
							expense=plananswer.getAppend().doubleValue()*firstbalance/100d;
							capital=plananswer.getAmount();
							income=(capital+expense)*plananswer.getRate()/100d;
						}
						expensearray[j].put(i, expense);
						capitalarray[j].put(i,capital);
						incomearray[j].put(i,income);
					}
				}else
				{/**计算上一年收益和支出*/
					double lastexpense=0d;
					double lastincome=0d;
					double lastbalance=0d;
					for(int p=0;p<financeanswers.size();p++){
						if((i>financeanswers.get(p).getStartYear())&&(i<=financeanswers.get(p).getEndYear()+1))
						{
							lastexpense=expensearray[p].get(i-1)+lastexpense;
							lastincome=incomearray[p].get(i-1)+lastincome;
						}
					}
					lastbalance=getYearCashes(caze,i-1)+getYearBonuses(caze,i-1)+getYearOtherIncomes(caze,i-1)+lastincome-getYearConsumes(caze,i-1)
					-lastexpense-getYearEducations(caze,i-1)-getYearTrips(caze,i-1)-getYearMedicals(caze,i-1)-getYearDeposits(caze,i-1)
					-getYearInsurances(caze,i-1)-getYearOtherExpenses(caze,i-1);
					
					for(int j=0;j<financeanswers.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;			
						FinancePlanAnswer plananswer=financeanswers.get(j);
						if((plananswer.getStartYear()<=i)&&(plananswer.getEndYear()>=i)){
						if(plananswer.getStartYear()==i)
						{
							expense=plananswer.getAppend().doubleValue()*lastbalance/100d;
							capital=plananswer.getAmount();
							income=(expense+capital)*plananswer.getRate()/100d;
						}else
						{
							expense=plananswer.getAppend().doubleValue()*lastbalance/100d;
							capital=expensearray[j].get(i-1)+incomearray[j].get(i-1)+capitalarray[j].get(i-1);
							income=(expense+capital)*plananswer.getRate()/100d;							
						}
						}
						expensearray[j].put(i, expense);
						capitalarray[j].put(i,capital);
						incomearray[j].put(i,income);
					}
				}
			}
			for(int i=0;i<financeanswers.size();i++){
				capitals.put(financeanswers.get(i).getFinancetype().getName(), capitalarray[i]);
				expenses.put(financeanswers.get(i).getFinancetype().getName(), expensearray[i]);
				incomes.put(financeanswers.get(i).getFinancetype().getName(), incomearray[i]);				
			}	
			/**第n年金融收入、支出、资本*/
			Map<Integer,Double> yearincomes=new HashMap();
			Map<Integer,Double> yearexpenses=new HashMap();	
			Map<Integer,Double> yearcapitals=new HashMap();
			for(int i=1;i<=getPlanYears();i++){
				double tempincome=0d;
				double tempexpense=0d;
				double tempcapital=0d;
				for(int j=0;j<financeanswers.size();j++)
				{
					FinancePlanAnswer plan=financeanswers.get(j);
					tempincome=incomes.get(plan.getFinancetype().getName()).get(i)+tempincome;
					tempexpense=expenses.get(plan.getFinancetype().getName()).get(i)+tempexpense;
					tempcapital=capitals.get(plan.getFinancetype().getName()).get(i)+tempcapital;
				}
				yearincomes.put(i, tempincome);
				yearexpenses.put(i,tempexpense);
				yearcapitals.put(i, tempcapital);
			}		
		
			double totalcapitals=yearcapitals.get(intyear)+yearexpenses.get(intyear)+yearincomes.get(intyear);
			// 按风险等级
			List laterRiskGrades= entityService.loadAll(RiskGrade.class);
			DefaultPieDataset laterRiskGradeDataSet = new DefaultPieDataset();
			if (!laterRiskGrades.isEmpty()) {
				Collections.sort(laterRiskGrades);
				for(Iterator riskiter=laterRiskGrades.iterator();riskiter.hasNext();)
				{
					RiskGrade riskgrade = (RiskGrade) riskiter.next();
					double tempValue=0d;
					double pertempValue=0d;
		        for (Iterator iter = financeanswers.iterator(); iter.hasNext();) {
		        	FinancePlanAnswer plan = (FinancePlanAnswer) iter.next();
		        	if(plan.getRiskgrade()==riskgrade){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}		            	
		        }
        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
        		if (tempValue!=0){
        			laterRiskGradeDataSet.setValue(riskgrade.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
        		}
        		}
			}
			
			put("laterRiskGrade", new GeneralDatasetProducer("test", laterRiskGradeDataSet));	
			put("totalcapitals",totalcapitals);
		
		

			// 按资产类型
			List laterFinanceTypes= getTopFinanceTypes();
			DefaultPieDataset laterFinanceTypeDataSet = new DefaultPieDataset();
			if (!laterFinanceTypes.isEmpty()) {
				Collections.sort(laterFinanceTypes);
				for(Iterator typeiter=laterFinanceTypes.iterator();typeiter.hasNext();)
				{
					FinanceType financeType = (FinanceType) typeiter.next();
					double tempValue=0d;
					double pertempValue=0d;
		        for (Iterator iter = financeanswers.iterator(); iter.hasNext();) {
		        	FinancePlanAnswer plan = (FinancePlanAnswer) iter.next();
		        	if(plan.getFinancetype().getParent()==financeType){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}		            	
		        }
        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
        		if (tempValue!=0){
        			laterFinanceTypeDataSet.setValue(financeType.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
        		}
        		}
			}
			
			put("laterFinanceType", new GeneralDatasetProducer("test", laterFinanceTypeDataSet));	

		
			// 按流动性
			List laterMobilities= entityService.loadAll(Mobility.class);
			DefaultPieDataset laterMobilityDataSet = new DefaultPieDataset();
			if (!laterMobilities.isEmpty()) {
				Collections.sort(laterMobilities);
				for(Iterator mobilityiter=laterMobilities.iterator();mobilityiter.hasNext();)
				{
					Mobility mobility = (Mobility) mobilityiter.next();
					double tempValue=0d;
					double pertempValue=0d;
		        for (Iterator iter = financeanswers.iterator(); iter.hasNext();) {
		        	FinancePlanAnswer plan = (FinancePlanAnswer) iter.next();
		        	if(plan.getMobility()==mobility){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}		            	
		        }
        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
        		if (tempValue!=0){
        			laterMobilityDataSet.setValue(mobility.getName() + "  ("+ pertempValue/100 +"%)", tempValue);
        		}
        		}
			}
			
			put("laterMobility", new GeneralDatasetProducer("test", laterMobilityDataSet));			
		
		
		
			// 按投资收益
			DefaultPieDataset laterBenefitDataSet = new DefaultPieDataset();
			List<String> laterBenefits=new ArrayList();
			laterBenefits.add("大于百分之二十");
			laterBenefits.add("介于百分之十与百分之二十之间");
			laterBenefits.add("介于百分之五与百分之十之间");
			laterBenefits.add("介于百分之零与百分之五之间");
			if (!laterBenefits.isEmpty()) {
				Collections.sort(laterBenefits);
				for(Iterator benefititer=laterBenefits.iterator();benefititer.hasNext();)
				{
					String benefit = (String) benefititer.next();
					double tempValue=0d;
					double pertempValue=0d;
		        for (Iterator iter = financeanswers.iterator(); iter.hasNext();) {
		        	FinancePlanAnswer plan = (FinancePlanAnswer) iter.next();
		        	if((plan.getRate()>20)&&(benefit.equals("大于百分之二十"))){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}
		        	else if((plan.getRate()>10)&&(plan.getRate()<=20)&&(benefit.equals("介于百分之十与百分之二十之间"))){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}
		        	else if((plan.getRate()>5)&&(plan.getRate()<=10)&&(benefit.equals("介于百分之五与百分之十之间"))){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}
		        	else if((plan.getRate()>=0)&&(plan.getRate()<=5)&&(benefit.equals("介于百分之零与百分之五之间"))){
		            	tempValue=tempValue+(capitals.get(plan.getFinancetype().getName()).get(intyear))+(expenses.get(plan.getFinancetype().getName()).get(intyear))+(incomes.get(plan.getFinancetype().getName()).get(intyear));
		        	}
		        }
        		pertempValue = Math.rint(tempValue/totalcapitals*10000);
        		if (tempValue!=0){
        			laterBenefitDataSet.setValue(benefit + "  ("+ pertempValue/100 +"%)", tempValue);
        		}
        		}
			}
			
			put("laterBenefit", new GeneralDatasetProducer("test", laterBenefitDataSet));				
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		return forward();
	}

}