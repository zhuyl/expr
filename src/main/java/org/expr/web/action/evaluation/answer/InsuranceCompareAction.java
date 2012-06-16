package org.expr.web.action.evaluation.answer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.analysis.answer.InsurancePolicyAnswer;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.FinanceType;
import org.expr.model.basecode.IncomeProject;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.evaluation.answer.InsuranceCompareAnswer;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;
import org.jfree.data.general.DefaultPieDataset;

import com.ekingstar.eams.util.stat.CountItem;
import com.ekingstar.eams.util.stat.GeneralDatasetProducer;
public class InsuranceCompareAction extends AbstractEvaluationAnswerAction {
	public String index() {
		Long cazeid = getLong("caze.id");
		Caze caze = (Caze) entityService.load(Caze.class, getLong("caze.id"));
		InsuranceCompareAnswer insurancecompareanswer=getInsuranceCompareAnswer();
		put("analysisAnswer",insurancecompareanswer);
		
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
					String year = (get("year")==null)?"1":get("year");
		int intyear=Integer.parseInt(year);
		 */

		
		int intyear=1;
		if(get("faceyear")==null){
		 intyear=1;
		if (insurancecompareanswer.getYear()!=null)
		{
		 intyear=Integer.valueOf(insurancecompareanswer.getYear());
		}}
		else
		{
			 intyear=Integer.valueOf(get("faceyear"));
		}
		put("defaultYear",String.valueOf(intyear));	

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
				Double laterMemberTotalCoverage=laterMemberTotalAmountMap.get(member.getName());
				for(InsuranceType insurancetype : insurancetypes)	{
					double tempValue=coverages.get(member.getName()).get(insurancetype.getName()).get(intyear);
		    		double pertempValue = Math.rint(tempValue/laterMemberTotalCoverage*10000);	
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
		
	private List getTopInsuranceTypes() {
		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
		query.add(new Condition("insuranceType.parent is null"));
		List insuranceTypes = entityService.search(query);
		return insuranceTypes;
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
	private InsuranceCompareAnswer getInsuranceCompareAnswer() {
		
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(InsuranceCompareAnswer.class, "caze.id", cazeid);
		InsuranceCompareAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new InsuranceCompareAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
		} else {
			answer = (InsuranceCompareAnswer) answers.get(0);
		}
		return answer;
	}
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		String year=get("year");
		InsuranceCompareAnswer answer = getInsuranceCompareAnswer();		
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