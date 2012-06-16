package org.expr.web.action.analysis.result;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.BalanceOfPayment;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.ChangeExpendResult;
import org.expr.model.analysis.result.ChangeIncomeResult;
import org.expr.model.analysis.result.ChangeResult;
import org.expr.model.basecode.ChangeType;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.FinanceAssetPlanResult;
import org.expr.model.plan.result.FinancePlanResult;
import org.expr.web.action.plan.result.AbstractPlanResultAction;

import com.ekingstar.eams.student.Student;

public class ChangeAnalysisAction extends AbstractPlanResultAction {

	public String index() {
		Experiment experiment = (Experiment) entityService.load(Experiment.class, getLong("experiment.id"));
		addBaseCode("incomeProjects", IncomeProject.class);
		addBaseCode("expendProjects", ExpendProject.class);
		List<IncomeProject> incomeProjects=entityService.loadAll(IncomeProject.class);
		List<IncomeProject> expendProjects=entityService.loadAll(ExpendProject.class);		
		int changeYear=0;
		if (experiment.getCaze().getChangeYear()!=null)
		{
			changeYear=experiment.getCaze().getChangeYear();
		}
		put ("changeYear",changeYear);

		ChangeResult changeResult = getChangeAnalysisResult(experiment);
		put("result",changeResult);
		double totalincome=0d;
		double totalexpend=0d;
		double totalchangeincome=0d;
		double totalchangeexpend=0d;
		double totalbalance=0d;
		double totalchangebalance=0d;
		Map incomeMap = new HashMap();
		Map expendMap = new HashMap();
		BalanceOfPaymentResult balanceresult = getIncomeExpenseResult(experiment);
		/**如果动态平衡年度没有填，则显示第0年，否则显示第n年的收支情况*/
		if(changeYear==0){
			totalincome=(balanceresult.getForm().getTotalIncome()==null?0:balanceresult.getForm().getTotalIncome());
		    totalexpend=(balanceresult.getForm().getTotalExpend()==null?0:balanceresult.getForm().getTotalExpend());
			totalbalance=totalincome-totalexpend;
		if (null != balanceresult.getForm()) {
			populateIncomeExpend(balanceresult.getForm(), incomeMap, expendMap);
		}}
		else{

			FinanceAssetPlanResult planResult=getFinanceAssetPlanResult(experiment);
			EntityQuery query = new EntityQuery(FinancePlanResult.class, "asset");
			query.addOrder(Order.parse(get("orderBy")));
			query.add(new Condition("asset.result.experiment.id=:experimentid", experiment.getId()));
			addStdCondition(query, "asset.result", getLoginStudent());
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
				
				Map<String,Double> typeincome=new HashMap();/**不同类型金融资产收入*/
				Map<String,Double> typeexpense=new HashMap();/**不同类型金融资产支出*/

				List<FinanceType> financetypes = getTopFinanceTypes();	

				for(FinanceType financetype : financetypes){
					double perincome=0d;
					double perexpense=0d;
					for(FinancePlanResult planresult:financeresults)
					{
						if(planresult.getFinancetype().getParent().getName()==financetype.getName()){
							perincome=perincome+incomes.get(planresult.getFinancetype().getName()).get(changeYear);
							perexpense=perexpense+expenses.get(planresult.getFinancetype().getName()).get(changeYear);
						}
						typeincome.put(financetype.getName(), perincome);
						typeexpense.put(financetype.getName(), perexpense);
					}
				}

				double t_income=0d;
				double t_expend=0d;
				double financeincome=0d;
				double financeexpend=0d;
				/**将值放到map中*/
				for (Iterator iterator = incomeProjects.iterator(); iterator.hasNext();) {
					IncomeProject holder = (IncomeProject) iterator.next();
					if(holder.getName().equals("工资收入"))
					{
						 t_income=getYearCashes(experiment,changeYear);
						incomeMap.put(holder.getId().toString(),t_income);					
						totalincome=totalincome+t_income;
					}else if(holder.getName().equals("奖金收入"))
					{
						 t_income=getYearBonuses(experiment,changeYear);
						incomeMap.put(holder.getId().toString(), t_income);					
						
					}else if(holder.getName().equals("工资性收入"))
					{
						t_income=getYearCashes(experiment,changeYear)+getYearBonuses(experiment,changeYear);
						totalincome=totalincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("储蓄收入"))
					{
						t_income=(typeincome.get("储蓄存款")==null?0:typeincome.get("储蓄存款"));
						financeincome=financeincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("债券收入"))
					{
						t_income=(typeincome.get("债券产品")==null?0:typeincome.get("债券产品"));
						financeincome=financeincome+t_income;						
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("股票收入"))
					{
						t_income=(typeincome.get("股票产品")==null?0:typeincome.get("股票产品"));
						financeincome=financeincome+t_income;						
						incomeMap.put(holder.getId().toString(),t_income );
					}else if(holder.getName().equals("基金收入"))
					{
						t_income=(typeincome.get("基金产品")==null?0:typeincome.get("基金产品"));
						financeincome=financeincome+t_income;						
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("银行理财产品收入"))
					{
						t_income=(typeincome.get("银行理财产品")==null?0:typeincome.get("银行理财产品"));
						financeincome=financeincome+t_income;
						incomeMap.put(holder.getId().toString(),t_income );
					}else if(holder.getName().equals("信托产品收入"))
					{
						t_income=(typeincome.get("信托产品")==null?0:typeincome.get("信托产品"));
						financeincome=financeincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("金融衍生产品收入"))
					{
						t_income=(typeincome.get("金融衍生产品")==null?0:typeincome.get("金融衍生产品"));
						financeincome=financeincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("其他理财收入"))
					{
						t_income=(typeincome.get("其他理财产品")==null?0:typeincome.get("其他理财产品"));
						financeincome=financeincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}else if(holder.getName().equals("理财性收入"))
					{	
						totalincome=totalincome+financeincome;
						incomeMap.put(holder.getId().toString(), financeincome);
					}else if(holder.getName().equals("其他收入"))
					{
						t_income=getYearOtherIncomes(experiment,changeYear);
						totalincome=totalincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}
				}
				for (Iterator iterator = expendProjects.iterator(); iterator.hasNext();) {
					ExpendProject holder = (ExpendProject) iterator.next();
					if(holder.getName().equals("消费支出"))
					{
						t_expend=getYearConsumes(experiment,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(),t_expend );
						
					}
					else if(holder.getName().equals("教育支出"))
					{
						t_expend=getYearEducations(experiment,changeYear);
						totalexpend=totalexpend+t_expend;						
						 expendMap.put(holder.getId().toString(),t_expend );
					}
					else if(holder.getName().equals("医疗支出"))
					{
						t_expend=getYearMedicals(experiment,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}					
					else if(holder.getName().equals("房屋贷款支出"))
					{
						t_expend=getYearHouseDeposits(experiment,changeYear);
						 expendMap.put(holder.getId().toString(),t_expend );
					}		
					else if(holder.getName().equals("汽车贷款支出"))
					{
						t_expend=getYearCarDeposits(experiment,changeYear);
						 expendMap.put(holder.getId().toString(),t_expend );
					}
					else if(holder.getName().equals("贷款支出"))
					{
						t_expend=getYearCarDeposits(experiment,changeYear)+getYearHouseDeposits(experiment,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(),t_expend );
					}					
					else if(holder.getName().equals("保费支出"))
					{
						t_expend=getYearInsurances(experiment,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("储蓄支出"))
					{
						t_expend=(typeexpense.get("储蓄存款")==null?0:typeexpense.get("储蓄存款"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("债券支出"))
					{
						t_expend=(typeexpense.get("债券产品")==null?0:typeexpense.get("债券产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("股票支出"))
					{
						t_expend=(typeexpense.get("股票产品")==null?0:typeexpense.get("股票产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("基金支出"))
					{
						t_expend=(typeexpense.get("基金产品")==null?0:typeexpense.get("基金产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("银行理财产品支出"))
					{
						t_expend=(typeexpense.get("银行理财产品")==null?0:typeexpense.get("银行理财产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("信托产品支出"))
					{
						t_expend=(typeexpense.get("信托产品")==null?0:typeexpense.get("信托产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("金融衍生产品支出"))
					{
						t_expend=(typeexpense.get("金融衍生产品")==null?0:typeexpense.get("金融衍生产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("其他理财支出"))
					{
						t_expend=(typeexpense.get("其他理财产品")==null?0:typeexpense.get("其他理财产品"));
						financeexpend=financeexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}else if(holder.getName().equals("投资支出"))
					{
						totalexpend=totalexpend+financeexpend;
						 expendMap.put(holder.getId().toString(), financeexpend);
					}											 
					else if(holder.getName().equals("旅游支出"))
					{
						t_expend=getYearTrips(experiment,changeYear);
						totalexpend=totalexpend+t_expend;	
						 expendMap.put(holder.getId().toString(),t_expend );
					}	
					else if(holder.getName().equals("其他支出"))
					{
						t_expend=getYearOtherExpenses(experiment,changeYear);
						totalexpend=totalexpend+t_expend;	
						 expendMap.put(holder.getId().toString(), t_expend);
					}	
				}
					
			
		}
		put("totalincome",totalincome);
		put("totalexpend",totalexpend);
		put("totalbalance",totalincome-totalexpend);			
		put("incomeMap", incomeMap);
		put("expendMap", expendMap);


		Map changeIncomeMap = new HashMap();
		Map changeExpendMap = new HashMap();
		put("changeIncomeMap", changeIncomeMap);
		put("changeExpendMap", changeExpendMap);

		if (null != changeResult.getForm()) {
			populateIncomeExpend(changeResult.getForm(), changeIncomeMap, changeExpendMap);
			totalchangeincome=(changeResult.getForm().getTotalIncome()==null?0:changeResult.getForm().getTotalIncome());
			totalchangeexpend=(changeResult.getForm().getTotalExpend()==null?0:changeResult.getForm().getTotalExpend());
			totalchangebalance=totalchangeincome-totalchangeexpend;
//			totalchangebalance=changeResult.getForm().getTotalBalance();
		}else
		{
			//put("changeIncomeMap", incomeMap);
			//put("changeExpendMap", expendMap);
			//totalchangeincome=totalincome;
			//totalchangeexpend=totalexpend;
			//totalchangebalance=totalincome-totalexpend;			
		}
		put("totalchangeincome",totalchangeincome);
		put("totalchangeexpend",totalchangeexpend);
		put("totalchangebalance",totalchangebalance);
		put("result",changeResult);
		return forward();
	}

	private void populateIncomeExpend(BalanceOfPayment balence, Map incomeMap, Map expendMap) {
		for (Iterator iterator = balence.getIncomes().iterator(); iterator.hasNext();) {
			IncomeHolder holder = (IncomeHolder) iterator.next();
			incomeMap.put(holder.getIncome().getIncomeProject().getId().toString(), holder
					.getIncome().getAmount());
		}
		for (Iterator iterator = balence.getExpends().iterator(); iterator.hasNext();) {
			ExpendHolder holder = (ExpendHolder) iterator.next();
			expendMap.put(holder.getExpend().getExpendProject().getId().toString(), holder
					.getExpend().getAmount());
		}
	}

	public void editSetting(Entity entity) {
		put("changeTypes", entityService.search(new EntityQuery(ChangeType.class, "ChangeType")));
	}
	private List getTopFinanceTypes() {
		EntityQuery query = new EntityQuery(FinanceType.class, "financeType");
		query.add(new Condition("financeType.parent is null"));
		List financeTypes = entityService.search(query);
		return financeTypes;
	}
	
	
	/** 将数据库对象和页面上以'result'开头的数据合并到result对象中 */
	public String saveIncomeExpense() {
		ChangeResult result = (ChangeResult) populateEntity(ChangeResult.class, "result");
		if (null == result.getForm()) {
			result.setForm(new BalanceOfPayment());
		}
		List incomes = baseCodeService.getCodes(IncomeProject.class);
		result.getForm().getIncomes().clear();
		for (Iterator iterator = incomes.iterator(); iterator.hasNext();) {
			IncomeProject project = (IncomeProject) iterator.next();
			ChangeIncomeResult incomeResult = new ChangeIncomeResult();
			incomeResult.setResult(result);
			incomeResult.setIncome(new Income());
			incomeResult.getIncome().setIncomeProject(project);
			incomeResult.getIncome().setAmount(getFloat("incomeProject" + project.getId()));
			result.getForm().getIncomes().add(incomeResult);
		}
		List expends = baseCodeService.getCodes(ExpendProject.class);
		result.getForm().getExpends().clear();
		for (Iterator iterator = expends.iterator(); iterator.hasNext();) {
			ExpendProject project = (ExpendProject) iterator.next();
			ChangeExpendResult expendResult = new ChangeExpendResult();
			expendResult.setExpend(new Expend());
			expendResult.setResult(result);
			expendResult.getExpend().setExpendProject(project);
			expendResult.getExpend().setAmount(getFloat("expendProject" + project.getId()));
			result.getForm().getExpends().add(expendResult);
		}
		saveOrUpdate(result);
		return redirect("index", "info.save.success");
	}


	protected BalanceOfPaymentResult getIncomeExpenseResult(Experiment experiment) {
		EntityQuery query = new EntityQuery(BalanceOfPaymentResult.class, "result");
		query.add(new Condition("result.experiment=:experiment", experiment));
		//query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query, "result",std);
		List results = entityService.search(query);
		BalanceOfPaymentResult result = null;
		if (results.isEmpty()) {
			result = new BalanceOfPaymentResult();
			result.setExperiment(experiment);
			result.setForm(new BalanceOfPayment());
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
		} else {
			result = (BalanceOfPaymentResult) results.get(0);
		}
		return result;
	}

	private ChangeResult getChangeAnalysisResult(Experiment experiment) {
		EntityQuery query = new EntityQuery(ChangeResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId",experiment.getId()));
		Student std=getLoginStudent();
		addStdCondition(query, "result", std);
		List<ChangeResult> results = entityService.search(query);
		
		ChangeResult result = null;
		if (results.isEmpty()) {
			result = new ChangeResult();
			result.setExperiment(experiment);
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
		} else {
			result = (ChangeResult) results.get(0);
		}
		return result;
	}

	public String saveRemark() {
		Experiment experiment = (Experiment) entityService.load(Experiment.class, getLong("experiment.id"));
		String remark = get("remark");
		ChangeResult result = getChangeAnalysisResult(experiment);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" +experiment.getId());
	}

	public String infolet() {
		index();
		return forward("../../infolet/info");
	}
}