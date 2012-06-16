package org.expr.web.action.evaluation.result;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.result.FinanceAssetResult;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.basecode.Mobility;
import org.expr.model.basecode.RiskGrade;
import org.expr.model.evaluation.result.FinanceCompareResult;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;
public class FinanceCompareAction extends AbstractEvaluationResultAction {
	public String index() {
		Long experimentid = getLong("experiment.id");
		FinanceCompareResult financeCompareResult=getFinanceCompareResult();
		put("analysisResult",financeCompareResult);
		Double nowTotalAmount = 0d;
		EntityQuery nowTotalQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowTotalQuery.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		Student std=getLoginStudent();
		addStdCondition(nowTotalQuery, "financeAssetResult.result", std);
		nowTotalQuery.setSelect("select sum(financeAssetResult.asset.amount)");
		List nowTotalAmountList = entityService.search(nowTotalQuery);
		if (!nowTotalAmountList.isEmpty()) {
			nowTotalAmount = (Double)nowTotalAmountList.get(0);
		}
		put("nowTotalAmount", nowTotalAmount);
		// 按资产类型
		List notZeroItemsFinanceType = new ArrayList();
		EntityQuery nowFinanceTypeQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowFinanceTypeQuery.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowFinanceTypeQuery, "financeAssetResult.result", std);
		nowFinanceTypeQuery.groupBy("financeAssetResult.asset.financetype.parent");
		nowFinanceTypeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.financetype.parent) ");
		//nowFinanceTypeQuery.add(new Condition("financeAssetResult.asset.financetype.parent is null"));
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
		EntityQuery nowRiskGradeQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowRiskGradeQuery.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowRiskGradeQuery, "financeAssetResult.result", std);		
		nowRiskGradeQuery.groupBy("financeAssetResult.asset.riskgrade");
		nowRiskGradeQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.riskgrade) ");
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
		EntityQuery nowMobilityQuery = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowMobilityQuery.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowMobilityQuery, "financeAssetResult.result", std);
		nowMobilityQuery.groupBy("financeAssetResult.asset.mobility");
		nowMobilityQuery.setSelect("select new com.ekingstar.eams.util.stat.CountItem(sum(financeAssetResult.asset.amount), financeAssetResult.asset.mobility) ");
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
		EntityQuery nowRate20Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowRate20Query.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowRate20Query, "financeAssetResult.result", std);
		nowRate20Query.add(new Condition("financeAssetResult.asset.rate>20"));
		List nowRate20Items = entityService.search(nowRate20Query);
		DefaultPieDataset nowRateDataSet = new DefaultPieDataset();
		if (!nowRate20Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate20Items.iterator(); iter.hasNext();) {
	        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("大于百分之二十" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate10Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowRate10Query.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowRate10Query, "financeAssetResult.result", std);
		nowRate10Query.add(new Condition("financeAssetResult.asset.rate>10 and financeAssetResult.asset.rate<=20"));
		List nowRate10Items = entityService.search(nowRate10Query);
		if (!nowRate10Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate10Items.iterator(); iter.hasNext();) {
	        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之十与百分之二十之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate5Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowRate5Query.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowRate5Query, "financeAssetResult.result", std);
		nowRate5Query.add(new Condition("financeAssetResult.asset.rate>5 and financeAssetResult.asset.rate<=10"));
		List nowRate5Items = entityService.search(nowRate5Query);
		if (!nowRate5Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate5Items.iterator(); iter.hasNext();) {
	        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之五与百分之十之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		// 按收益性分析对比
		EntityQuery nowRate0Query = new EntityQuery(FinanceAssetResult.class, "financeAssetResult");
		nowRate0Query.add(new Condition("financeAssetResult.result.experiment.id=" + experimentid));
		addStdCondition(nowRate0Query, "financeAssetResult.result", std);
		nowRate0Query.add(new Condition("financeAssetResult.asset.rate<=5"));
		List nowRate0Items = entityService.search(nowRate0Query);
		if (!nowRate0Items.isEmpty()) {
			Double count = 0d;
	        for (Iterator iter = nowRate0Items.iterator(); iter.hasNext();) {
	        	FinanceAssetResult item = (FinanceAssetResult) iter.next();
	        	count += item.getAsset().getAmount();
	        }
	        if (count != 0) {
	        	double tempValue = Math.rint(count/nowTotalAmount*10000);
	        	nowRateDataSet.setValue("介于百分之零与百分之五之间" + "  ("+ tempValue/100 +"%)", count
	        			.intValue());
	        	
	        }
		}
		
		put("nowRate", new GeneralDatasetProducer("test", nowRateDataSet));
		
		/*String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.parseInt(year);
		put("defaultYear",year);*/
		int intyear=1;
		if(get("faceyear")==null){
		 intyear=1;
		if (financeCompareResult.getYear()!=null)
		{
		 intyear=Integer.valueOf(financeCompareResult.getYear());
		}}
		else
		{
			 intyear=Integer.valueOf(get("faceyear"));
		}
		put("defaultYear",String.valueOf(intyear));
		
		Experiment experiment = (Experiment) entityService.load(Experiment.class, getLong("experiment.id"));
		FinanceAssetPlanResult planResult=getFinanceAssetPlanResult(experiment);
		EntityQuery query = new EntityQuery(FinancePlanResult.class, "asset");
		query.addOrder(Order.parse(get("orderBy")));
		query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
		addStdCondition(query, "asset.result", std);
		query.setLimit(getPageLimit());// 加分页，否则删除会有误
		List<FinancePlanResult> financeresults=entityService.search(query);
		
		double firstbalance=getFirstBalance(experiment);
	
		Map<String,Map<Integer,Double>> capitals=new HashMap();
		Map<String,Map<Integer,Double>> expenses=new HashMap();/**追加*/
		Map<String,Map<Integer,Double>> incomes=new HashMap();/**收益*/
		
		 Map<Integer,Double>[] expensearray=new Map[financeresults.size()];
		 Map<Integer,Double>[] capitalarray=new Map[financeresults.size()];
		 Map<Integer,Double>[] incomearray=new Map[financeresults.size()];
			for(int i=0;i<financeresults.size();i++){
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
					for(int j=0;j<financeresults.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;
						FinancePlanResult planresult=financeresults.get(j);
						if(planresult.getStartYear()==1)
						{
							expense=planresult.getAppend().doubleValue()*firstbalance/100d;
							capital=planresult.getAmount();
							income=(capital+expense)*planresult.getRate()/100d;
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
					for(int p=0;p<financeresults.size();p++){
						if((i>financeresults.get(p).getStartYear())&&(i<=financeresults.get(p).getEndYear()+1))
						{
							lastexpense=expensearray[p].get(i-1)+lastexpense;
							lastincome=incomearray[p].get(i-1)+lastincome;
						}
					}
					lastbalance=getYearCashes(experiment,i-1)+getYearBonuses(experiment,i-1)+getYearOtherIncomes(experiment,i-1)+lastincome-getYearConsumes(experiment,i-1)
					-lastexpense-getYearEducations(experiment,i-1)-getYearTrips(experiment,i-1)-getYearMedicals(experiment,i-1)-getYearDeposits(experiment,i-1)
					-getYearInsurances(experiment,i-1)-getYearOtherExpenses(experiment,i-1);
					
					for(int j=0;j<financeresults.size();j++)
					{expense=0d;
					capital=0d;
					income=0d;			
						FinancePlanResult planresult=financeresults.get(j);
						if((planresult.getStartYear()<=i)&&(planresult.getEndYear()>=i)){
						if(planresult.getStartYear()==i)
						{
							expense=planresult.getAppend().doubleValue()*lastbalance/100d;
							capital=planresult.getAmount();
							income=(expense+capital)*planresult.getRate()/100d;
						}else
						{
							expense=planresult.getAppend().doubleValue()*lastbalance/100d;
							capital=expensearray[j].get(i-1)+incomearray[j].get(i-1)+capitalarray[j].get(i-1);
							income=(expense+capital)*planresult.getRate()/100d;							
						}
						}
						expensearray[j].put(i, expense);
						capitalarray[j].put(i,capital);
						incomearray[j].put(i,income);
					}
				}
			}
			for(int i=0;i<financeresults.size();i++){
				capitals.put(financeresults.get(i).getFinancetype().getName(), capitalarray[i]);
				expenses.put(financeresults.get(i).getFinancetype().getName(), expensearray[i]);
				incomes.put(financeresults.get(i).getFinancetype().getName(), incomearray[i]);				
			}	
			/**第n年金融收入、支出、资本*/
			Map<Integer,Double> yearincomes=new HashMap();
			Map<Integer,Double> yearexpenses=new HashMap();	
			Map<Integer,Double> yearcapitals=new HashMap();
			for(int i=1;i<=getPlanYears();i++){
				double tempincome=0d;
				double tempexpense=0d;
				double tempcapital=0d;
				for(int j=0;j<financeresults.size();j++)
				{
					FinancePlanResult plan=financeresults.get(j);
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
		        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
		        	FinancePlanResult plan = (FinancePlanResult) iter.next();
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
		        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
		        	FinancePlanResult plan = (FinancePlanResult) iter.next();
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
		        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
		        	FinancePlanResult plan = (FinancePlanResult) iter.next();
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
		        for (Iterator iter = financeresults.iterator(); iter.hasNext();) {
		        	FinancePlanResult plan = (FinancePlanResult) iter.next();
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
	private FinanceCompareResult getFinanceCompareResult() {
		Long experimentid = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FinanceCompareResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId",experimentid));
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List results = entityService.search(query);
		FinanceCompareResult result = null;
		if (results.isEmpty()) {
			result = new FinanceCompareResult();
			result.setExperiment((Experiment) entityService.load(Experiment.class, experimentid));
//			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
//			if (null != studentList && studentList.size()!=0){
//				result.setStudent((Student)studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);	
		} else {
			result = (FinanceCompareResult) results.get(0);
		}
		return result;
	}
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		String year=get("year");
		FinanceCompareResult result = getFinanceCompareResult();		
		result.setRemark(remark);
		result.setYear(Integer.parseInt(year));
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
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