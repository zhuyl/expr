package org.expr.web.action.evaluation.answer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.ExpendAnswer;
import org.expr.model.analysis.answer.IncomeAnswer;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.evaluation.answer.BalanceCompareAnswer;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;

public class BalanceCompareAction extends AbstractEvaluationAnswerAction {
	public String index() {
		/**理财前*/
		Long cazeid = getLong("caze.id");
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));
		BalanceCompareAnswer balancecompareanswer=getBalanceCompareAnswer();
		put("analysisAnswer",balancecompareanswer);
		
		Double nowTotalIncomeAmount = 0d;
		Double nowTotalExpendAmount = 0d;
		EntityQuery nowTotalQuery = new EntityQuery(BalanceOfPaymentAnswer.class, "balanceOfPaymentAnswer");
		nowTotalQuery.add(new Condition("balanceOfPaymentAnswer.caze.id=" + cazeid));
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			BalanceOfPaymentAnswer balanceOfPaymentAnswer = (BalanceOfPaymentAnswer)nowTotalAmountList.get(0);
			if (null != balanceOfPaymentAnswer && null != balanceOfPaymentAnswer.getForm()
					&& null != balanceOfPaymentAnswer.getForm().getTotalIncome()) {
				nowTotalIncomeAmount = balanceOfPaymentAnswer.getForm().getTotalIncome()
						.doubleValue();
			}
			if (null != balanceOfPaymentAnswer && null != balanceOfPaymentAnswer.getForm()
					&& null != balanceOfPaymentAnswer.getForm().getTotalExpend()) {
				nowTotalExpendAmount = balanceOfPaymentAnswer.getForm().getTotalExpend()
						.doubleValue();
			}
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
	        for (Iterator iter = nowIncomeItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (null == item.getCount()) {
	            	item.setCount(new Integer(0));
	            }
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
	        for (Iterator iter = nowExpenseItems.iterator(); iter.hasNext();) {
	            CountItem item = (CountItem) iter.next();
	            if (null == item.getCount()) {
	            	item.setCount(new Integer(0));
	            }
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

		
		
		
		
		/*String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.valueOf(year);*/
		int intyear=1;
		if(get("faceyear")==null){
		 intyear=1;
		if (balancecompareanswer.getYear()!=null)
		{
		 intyear=Integer.valueOf(balancecompareanswer.getYear());
		}}
		else
		{
			 intyear=Integer.valueOf(get("faceyear"));
		}
		put("defaultYear",String.valueOf(intyear));
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
	private BalanceCompareAnswer getBalanceCompareAnswer() {
		
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(BalanceCompareAnswer.class, "caze.id", cazeid);
		BalanceCompareAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new BalanceCompareAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
		} else {
			answer = (BalanceCompareAnswer) answers.get(0);
		}
		return answer;
	}
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		String year=get("year");
		BalanceCompareAnswer answer = getBalanceCompareAnswer();		
		answer.setRemark(remark);
		answer.setYear(Integer.parseInt(year));
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
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