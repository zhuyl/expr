package org.expr.web.action.analysis.answer;

import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.model.LongIdTimeEntity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.answer.AnalysisSummaryAnswer;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.FundsAnalysisAnswer;
import org.expr.model.analysis.answer.FundsAssetAnswer;
import org.expr.model.analysis.answer.FundsLiabilityAnswer;
import org.expr.model.analysis.answer.IncomeAnswer;

/**
 * 客户分析综述
 * 
 * @return
 */
public class AnalysisSummaryAction extends AbstractAnalysisAnswerAction {

	private <T> T getAnswer(Class<T> clazz, Caze caze) {
		EntityQuery query = new EntityQuery(clazz, "answer");
		query.add(new Condition("answer.caze=:caze", caze));
		List answers = entityService.search(query);
		if (!answers.isEmpty()) {
			return (T) answers.get(0);
		} else {
			return null;
		}
	}

	/**
	 * 1)资产负债比率=总负债/总资产 2)流动比率=流动性资产/流动负债 3)储蓄比率=每月的盈余/税后收入 4)流动资产比率=流动资产/总资产
	 * 4)财务自由度=年理财收入/年支出 5)平均投资报酬率=年理财收入/生息资产 6)自由储蓄率=自由储蓄额/总资产
	 */
	public String index() {
		Caze caze = (Caze) entityService.get(Caze.class, getLong("caze.id"));
		List summaryAnswers = entityService.load(AnalysisSummaryAnswer.class, "caze", caze);
		AnalysisSummaryAnswer asAnswer = null;
		if (summaryAnswers.isEmpty()) {
			asAnswer = new AnalysisSummaryAnswer();
			asAnswer.setCaze(caze);
			entityService.saveOrUpdate(asAnswer);
		} else {
			asAnswer = (AnalysisSummaryAnswer) summaryAnswers.get(0);
		}
		put("answer", asAnswer);
		// 资产负债比率=总负债/总资产
		FundsAnalysisAnswer answer = getAnswer(FundsAnalysisAnswer.class, caze);
		Float liabilityRatio = null;
		if (null != answer) {
			if (null != answer.getForm() && null != answer.getForm().getTotalLiabilities()
					&& null != answer.getForm().getTotalAssets())
				liabilityRatio = answer.getForm().getTotalLiabilities()
						/ answer.getForm().getTotalAssets();
		}
		put("liabilityRatio", liabilityRatio);

		// 流动比率=流动性资产/流动负债
		// 流动资产比率=流动资产/总资产
		Float currentRatio = null;
		Float currentAssetRatio = null;
		if (null != answer && null != answer.getForm()) {
			Float currentAsset = null;
			Float currentLiability = null;
			for (Iterator iter = answer.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetAnswer faa = (FundsAssetAnswer) iter.next();
				if (null == faa.getAsset().getAssetProject().getParent()
						&& faa.getAsset().getAssetProject().getName().equals("流动性资产")) {
					currentAsset = faa.getAsset().getAmount();
				}
			}
			for (Iterator iter = answer.getForm().getLiabilities().iterator(); iter.hasNext();) {
				FundsLiabilityAnswer faa = (FundsLiabilityAnswer) iter.next();
				if (null == faa.getLiability().getLiabilityProject().getParent()
						&& faa.getLiability().getLiabilityProject().getName().equals("流动性负债")) {
					currentLiability = faa.getLiability().getAmount();
				}
			}
			if (null != currentAsset && null != currentLiability) {
				currentRatio = currentAsset / currentLiability;
			}
			if (null != currentAsset && null != answer.getForm().getTotalAssets()) {
				currentAssetRatio = currentAsset / answer.getForm().getTotalAssets();
			}
		}

		put("currentRatio", currentRatio);
		put("currentAssetRatio", currentAssetRatio);

		// 储蓄比率=每月的盈余/税后收入
		BalanceOfPaymentAnswer answer2 = getAnswer(BalanceOfPaymentAnswer.class, caze);
		Float saveRatio = null;
		if (null != answer2 & null != answer2.getForm()) {
			if (null != answer2.getForm().getTotalBalance()
					&& null != answer2.getForm().getTotalIncome()) {
				saveRatio = answer2.getForm().getTotalBalance()
						/ answer2.getForm().getTotalIncome();
			}
		}
		put("saveRatio", saveRatio);

		// 财务自由度=年理财收入/年支出
		Float financialFreeDegree = null;
		Float yearIncome = null;
		if (null != answer2 & null != answer2.getForm()
				&& null != answer2.getForm().getTotalExpend()) {
			for (Iterator<IncomeAnswer> iter = answer2.getForm().getIncomes().iterator(); iter
					.hasNext();) {
				IncomeAnswer income = iter.next();
				if (null == income.getIncome().getIncomeProject().getParent()
						&& income.getIncome().getIncomeProject().getName().equals("理财性收入")) {
					if (null != income.getIncome().getAmount()) {
						yearIncome = 12 * income.getIncome().getAmount();
						financialFreeDegree = income.getIncome().getAmount()
								/ answer2.getForm().getTotalExpend();
					}
				}
			}
		}
		put("financialFreeDegree", financialFreeDegree);

		// 平均投资报酬率=年理财收入/生息资产
		Float returnRatio = null;
		if (null != yearIncome && null != answer.getForm()) {
			for (Iterator iter = answer.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetAnswer faa = (FundsAssetAnswer) iter.next();
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
		if (null != answer.getForm()) {
			for (Iterator iter = answer.getForm().getAssets().iterator(); iter.hasNext();) {
				FundsAssetAnswer faa = (FundsAssetAnswer) iter.next();
				if (null != faa.getAsset().getAssetProject().getParent()
						&& faa.getAsset().getAssetProject().getName().endsWith("存款")) {
					if (null != faa.getAsset().getAmount()) {
						saved += faa.getAsset().getAmount();
					}
				}
			}
		}
		if (null != answer.getForm().getTotalAssets()) {
			savedRatio = saved / answer.getForm().getTotalAssets();
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

	public String info() {
		index();
		return forward();
	}

	@Override
	public String infolet() {
		index();
		return forward("../../infolet/info");
	}

}