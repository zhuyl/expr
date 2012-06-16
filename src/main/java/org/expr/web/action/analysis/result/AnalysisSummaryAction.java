package org.expr.web.action.analysis.result;

import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.model.LongIdTimeEntity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.result.AnalysisSummaryResult;
import org.expr.model.analysis.result.BalanceOfPaymentResult;
import org.expr.model.analysis.result.FundsAnalysisResult;
import org.expr.model.analysis.result.FundsAssetResult;
import org.expr.model.analysis.result.FundsLiabilityResult;
import org.expr.model.analysis.result.IncomeResult;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

/**
 * 客户分析综述
 * 
 * @return
 */
public class AnalysisSummaryAction extends AbstractAnalysisResultAction {

	private <T> T getResult(Class<T> clazz, Experiment experiment) {
		EntityQuery query = new EntityQuery(clazz, "result");
		query.add(new Condition("result.experiment=:experiment", experiment));
		addStdCondition(query, "result", getLoginStudent());
		List results = entityService.search(query);
		if (!results.isEmpty()) {
			return (T) results.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 1)资产负债比率=总负债/总资产 2)流动比率=流动性资产/流动负债 3)储蓄比率=每月的盈余/税后收入 4)流动资产比率=流动资产/总资产
	 * 4)财务自由度=年理财收入/年支出 5)平均投资报酬率=年理财收入/生息资产 6)自由储蓄率=自由储蓄额/总资产
	 */
	public String index() {
		Experiment experiment = (Experiment) entityService.get(Experiment.class, getLong("experiment.id"));
		Long experimentId=getLong("experiment.id");
		EntityQuery query = new EntityQuery(AnalysisSummaryResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId" , experimentId));
		Student std=getLoginStudent();
		addStdCondition(query, "result", std);	
		List summaryResults = entityService.search(query);
		
		
		AnalysisSummaryResult asResult = null;
		if (summaryResults.isEmpty()) {
			asResult = new AnalysisSummaryResult();
			asResult.setExperiment(experiment);
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			asResult.setStudent(std);
			entityService.saveOrUpdate(asResult);
		} else {
			asResult = (AnalysisSummaryResult) summaryResults.get(0);
		}
		put("result", asResult);
		// 资产负债比率=总负债/总资产
		FundsAnalysisResult result = getResult(FundsAnalysisResult.class, experiment);
		Float liabilityRatio = null;
		if (null != result) {
			if (null != result.getForm() && null != result.getForm().getTotalLiabilities()
					&& null != result.getForm().getTotalAssets())
				liabilityRatio = result.getForm().getTotalLiabilities()
						/ result.getForm().getTotalAssets();
		}
		put("liabilityRatio", liabilityRatio);

		// 流动比率=流动性资产/流动负债
		// 流动资产比率=流动资产/总资产
		Float currentRatio = null;
		Float currentAssetRatio = null;
		if (null != result && null != result.getForm()) {
			Float currentAsset = null;
			Float currentLiability = null;
			for (Iterator iter = result.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetResult faa = (FundsAssetResult) iter.next();
				if (null == faa.getAsset().getAssetProject().getParent()
						&& faa.getAsset().getAssetProject().getName().equals("流动性资产")) {
					currentAsset = faa.getAsset().getAmount();
				}
			}
			for (Iterator iter = result.getForm().getLiabilities().iterator(); iter.hasNext();) {
				FundsLiabilityResult faa = (FundsLiabilityResult) iter.next();
				if (null == faa.getLiability().getLiabilityProject().getParent()
						&& faa.getLiability().getLiabilityProject().getName().equals("流动性负债")) {
					currentLiability = faa.getLiability().getAmount();
				}
			}
			if (null != currentAsset && null != currentLiability) {
				currentRatio = currentAsset / currentLiability;
			}
			if (null != currentAsset && null != result.getForm().getTotalAssets()) {
				currentAssetRatio = currentAsset / result.getForm().getTotalAssets();
			}
		}

		put("currentRatio", currentRatio);
		put("currentAssetRatio", currentAssetRatio);

		// 储蓄比率=每月的盈余/税后收入
		BalanceOfPaymentResult result2 = getResult(BalanceOfPaymentResult.class, experiment);
		Float saveRatio = null;
		if (null != result2 & null != result2.getForm()) {
			if (null != result2.getForm().getTotalBalance()
					&& null != result2.getForm().getTotalIncome()) {
				saveRatio = result2.getForm().getTotalBalance()
						/ result2.getForm().getTotalIncome();
			}
		}
		put("saveRatio", saveRatio);

		// 财务自由度=年理财收入/年支出
		Float financialFreeDegree = null;
		Float yearIncome = null;
		if (null != result2 & null != result2.getForm()
				&& null != result2.getForm().getTotalExpend()) {
			for (Iterator<IncomeResult> iter = result2.getForm().getIncomes().iterator(); iter
					.hasNext();) {
				IncomeResult income = iter.next();
				if (null == income.getIncome().getIncomeProject().getParent()
						&& income.getIncome().getIncomeProject().getName().equals("理财性收入")) {
					if (null != income.getIncome().getAmount()) {
						yearIncome = 12 * income.getIncome().getAmount();
						financialFreeDegree = income.getIncome().getAmount()
								/ result2.getForm().getTotalExpend();
					}
				}
			}
		}
		put("financialFreeDegree", financialFreeDegree);

		// 平均投资报酬率=年理财收入/生息资产
		Float returnRatio = null;
		if (null != yearIncome && null != result.getForm()) {
			for (Iterator iter = result.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetResult faa = (FundsAssetResult) iter.next();
				if (null == faa.getAsset().getAssetProject().getParent()
						&& faa.getAsset().getAssetProject().getName().equals("投资性资产")) {
					if (null != faa.getAsset().getAmount()) {
						returnRatio = yearIncome / faa.getAsset().getAmount();
					}
				}
			}
		}
		put("returnRatio", returnRatio);
		// 自由储蓄率=自由储蓄额/总资产
		Float saved = 0f;
		Float savedRatio = null;
		if (null != result.getForm()) {
			for (Iterator iter = result.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetResult faa = (FundsAssetResult) iter.next();
				if (null != faa.getAsset().getAssetProject().getParent()
						&& faa.getAsset().getAssetProject().getName().endsWith("存款")) {
					if (null != faa.getAsset().getAmount()) {
						saved += faa.getAsset().getAmount();
					}
				}
			}
		}
		if (null != result.getForm().getTotalAssets()) {
			savedRatio = saved / result.getForm().getTotalAssets();
		}
		put("savedRatio", savedRatio);
		return forward();
	}

	@Override
	protected String saveAndForward(Entity entity) {
		try {
			if (entity instanceof LongIdTimeEntity) {
				LongIdTimeEntity timeEntity = (LongIdTimeEntity) entity;
				if (timeEntity.isVO()) {
					timeEntity.setCreatedAt(new Date());
				}
				timeEntity.setUpdatedAt(new Date());
			}
			saveOrUpdate(Collections.singletonList(entity));
			return redirect("index", "info.save.success");
		} catch (Exception e) {
			logger.info("saveAndForwad failure", e);
			return redirect("search", "info.save.failure");
		}
	}
	
	@Override
	public String infolet() {
		index();
		return forward("../../infolet/info");
	}
}