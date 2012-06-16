package org.expr.web.action.analysis.answer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.BalanceOfPayment;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.ExpendHolder;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.IncomeHolder;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.ChangeAnswer;
import org.expr.model.analysis.answer.ChangeExpendAnswer;
import org.expr.model.analysis.answer.ChangeIncomeAnswer;
import org.expr.model.basecode.ChangeType;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.plan.answer.FinanceAssetPlanAnswer;
import org.expr.model.plan.answer.FinancePlanAnswer;
import org.expr.web.action.plan.answer.AbstractPlanAnswerAction;

public class ChangeAnalysisAction extends AbstractPlanAnswerAction {

	public String index() {
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));
		addBaseCode("incomeProjects", IncomeProject.class);
		addBaseCode("expendProjects", ExpendProject.class);
		List<IncomeProject> incomeProjects=entityService.loadAll(IncomeProject.class);
		List<IncomeProject> expendProjects=entityService.loadAll(ExpendProject.class);		
		int changeYear=0;
		if (caze.getChangeYear()!=null)
		{
			changeYear=caze.getChangeYear();
		}
		put ("changeYear",changeYear);

		ChangeAnswer changeAnswer = getChangeAnalysisAnswer(caze);
		put("result",changeAnswer);
		double totalincome=0d;
		double totalexpend=0d;
		double totalchangeincome=0d;
		double totalchangeexpend=0d;
		double totalbalance=0d;
		double totalchangebalance=0d;
		Map incomeMap = new HashMap();
		Map expendMap = new HashMap();
		BalanceOfPaymentAnswer balanceanswer = getIncomeExpenseAnswer(caze);
		/**如果动态平衡年度没有填，则显示第0年，否则显示第n年的收支情况*/
		if(changeYear==0){
		totalincome=(balanceanswer.getForm().getTotalIncome()==null?0:balanceanswer.getForm().getTotalIncome());
	    totalexpend=(balanceanswer.getForm().getTotalExpend()==null?0:balanceanswer.getForm().getTotalExpend());
		totalbalance=totalincome-totalexpend;
		
		if (null != balanceanswer.getForm()) {
			populateIncomeExpend(balanceanswer.getForm(), incomeMap, expendMap);
		}}
		else{
			
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
				
				Map<String,Double> typeincome=new HashMap();/**不同类型金融资产收入*/
				Map<String,Double> typeexpense=new HashMap();/**不同类型金融资产支出*/

				List<FinanceType> financetypes = getTopFinanceTypes();	

				for(FinanceType financetype : financetypes){
					double perincome=0d;
					double perexpense=0d;
					for(FinancePlanAnswer plananswer:financeanswers)
					{
						if(plananswer.getFinancetype().getParent().getName()==financetype.getName()){
							perincome=perincome+incomes.get(plananswer.getFinancetype().getName()).get(changeYear);
							perexpense=perexpense+expenses.get(plananswer.getFinancetype().getName()).get(changeYear);
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
						 t_income=getYearCashes(caze,changeYear);
						incomeMap.put(holder.getId().toString(),t_income);					
						totalincome=totalincome+t_income;
					}else if(holder.getName().equals("奖金收入"))
					{
						 t_income=getYearBonuses(caze,changeYear);
						incomeMap.put(holder.getId().toString(), t_income);					
						
					}else if(holder.getName().equals("工资性收入"))
					{
						t_income=getYearCashes(caze,changeYear)+getYearBonuses(caze,changeYear);
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
						t_income=getYearOtherIncomes(caze,changeYear);
						totalincome=totalincome+t_income;
						incomeMap.put(holder.getId().toString(), t_income);
					}
				}
				for (Iterator iterator = expendProjects.iterator(); iterator.hasNext();) {
					ExpendProject holder = (ExpendProject) iterator.next();
					if(holder.getName().equals("消费支出"))
					{
						t_expend=getYearConsumes(caze,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(),t_expend );
						
					}
					else if(holder.getName().equals("教育支出"))
					{
						t_expend=getYearEducations(caze,changeYear);
						totalexpend=totalexpend+t_expend;						
						 expendMap.put(holder.getId().toString(),t_expend );
					}
					else if(holder.getName().equals("医疗支出"))
					{
						t_expend=getYearMedicals(caze,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(), t_expend);
					}					
					else if(holder.getName().equals("房屋贷款支出"))
					{
						t_expend=getYearHouseDeposits(caze,changeYear);
						 expendMap.put(holder.getId().toString(),t_expend );
					}		
					else if(holder.getName().equals("汽车贷款支出"))
					{
						t_expend=getYearCarDeposits(caze,changeYear);
						 expendMap.put(holder.getId().toString(),t_expend );
					}
					else if(holder.getName().equals("贷款支出"))
					{
						t_expend=getYearCarDeposits(caze,changeYear)+getYearHouseDeposits(caze,changeYear);
						totalexpend=totalexpend+t_expend;
						 expendMap.put(holder.getId().toString(),t_expend );
					}					
					else if(holder.getName().equals("保费支出"))
					{
						t_expend=getYearInsurances(caze,changeYear);
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
						t_expend=getYearTrips(caze,changeYear);
						totalexpend=totalexpend+t_expend;	
						 expendMap.put(holder.getId().toString(),t_expend );
					}	
					else if(holder.getName().equals("其他支出"))
					{
						t_expend=getYearOtherExpenses(caze,changeYear);
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
		if (null != changeAnswer.getForm()) {
			populateIncomeExpend(changeAnswer.getForm(), changeIncomeMap, changeExpendMap);
			put("changeIncomeMap", changeIncomeMap);
			put("changeExpendMap", changeExpendMap);
			totalchangeincome=(changeAnswer.getForm().getTotalIncome()==null?0:changeAnswer.getForm().getTotalIncome());
			totalchangeexpend=(changeAnswer.getForm().getTotalExpend()==null?0:changeAnswer.getForm().getTotalExpend());
			totalchangebalance=totalchangeincome-totalchangeexpend;
		}else
		{
//			put("changeIncomeMap", incomeMap);
//			put("changeExpendMap", expendMap);
//			totalchangeincome=totalincome;
//			totalchangeexpend=totalexpend;
//			totalchangebalance=totalbalance;			
		}
		put("totalchangeincome",totalchangeincome);
		put("totalchangeexpend",totalchangeexpend);
		put("totalchangebalance",totalchangeincome-totalchangeexpend);
		put("answer",changeAnswer);
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
	
	
	/** 将数据库对象和页面上以'answer'开头的数据合并到answer对象中 */
	public String saveIncomeExpense() {
		ChangeAnswer answer = (ChangeAnswer) populateEntity(ChangeAnswer.class, "answer");
		if (null == answer.getForm()) {
			answer.setForm(new BalanceOfPayment());
		}
		List incomes = baseCodeService.getCodes(IncomeProject.class);
		answer.getForm().getIncomes().clear();
		for (Iterator iterator = incomes.iterator(); iterator.hasNext();) {
			IncomeProject project = (IncomeProject) iterator.next();
			ChangeIncomeAnswer incomeAnswer = new ChangeIncomeAnswer();
			incomeAnswer.setAnswer(answer);
			incomeAnswer.setIncome(new Income());
			incomeAnswer.getIncome().setIncomeProject(project);
			incomeAnswer.getIncome().setAmount(getFloat("incomeProject" + project.getId()));
			answer.getForm().getIncomes().add(incomeAnswer);
		}
		List expends = baseCodeService.getCodes(ExpendProject.class);
		answer.getForm().getExpends().clear();
		for (Iterator iterator = expends.iterator(); iterator.hasNext();) {
			ExpendProject project = (ExpendProject) iterator.next();
			ChangeExpendAnswer expendAnswer = new ChangeExpendAnswer();
			expendAnswer.setExpend(new Expend());
			expendAnswer.setAnswer(answer);
			expendAnswer.getExpend().setExpendProject(project);
			expendAnswer.getExpend().setAmount(getFloat("expendProject" + project.getId()));
			answer.getForm().getExpends().add(expendAnswer);
		}
		saveOrUpdate(answer);
		return redirect("index", "info.save.success");
	}


	protected BalanceOfPaymentAnswer getIncomeExpenseAnswer(Caze caze) {
		EntityQuery query = new EntityQuery(BalanceOfPaymentAnswer.class, "answer");
		query.add(new Condition("answer.caze=:caze", caze));
		List answers = entityService.search(query);
		BalanceOfPaymentAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new BalanceOfPaymentAnswer();
			answer.setCaze(caze);
			answer.setForm(new BalanceOfPayment());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (BalanceOfPaymentAnswer) answers.get(0);
		}
		return answer;
	}

	private ChangeAnswer getChangeAnalysisAnswer(Caze caze) {
		List answers = entityService.load(ChangeAnswer.class, "caze", caze);
		ChangeAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new ChangeAnswer();
			answer.setCaze(caze);
		} else {
			answer = (ChangeAnswer) answers.get(0);
		}
		return answer;
	}

	public String saveRemark() {
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));
		String remark = get("remark");
		ChangeAnswer answer = getChangeAnalysisAnswer(caze);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + caze.getId());
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