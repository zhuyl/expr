package org.expr.web.action.analysis.answer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.FundsAnalysis;
import org.expr.model.analysis.answer.FundsAnalysisAnswer;
import org.expr.model.analysis.answer.FundsAssetAnswer;
import org.expr.model.analysis.answer.FundsLiabilityAnswer;
import org.expr.model.basecode.AssetProject;
import org.expr.model.basecode.LiabilityProject;

	/**
	 * 资产负债表
	 * 
	 * @return
	 */
public class BalanceSheetAction extends AbstractAnalysisAnswerAction {
	public String index() {
		FundsAnalysisAnswer answer=getBalanceSheetAnswer();
		put("answer",answer);
		addBaseCode("assetProjects", AssetProject.class);
		addBaseCode("liabilityProjects", LiabilityProject.class);
		Map assetMap = new HashMap();
		Map liabilityMap = new HashMap();
		if (null != answer.getForm()) {
			for (Iterator iterator = answer.getForm().getAssets().iterator(); iterator.hasNext();) {
				FundsAssetAnswer assetAnswer = (FundsAssetAnswer) iterator.next();
				assetMap.put(assetAnswer.getAsset().getAssetProject().getId().toString(),
						assetAnswer.getAsset().getAmount());
			}
			for (Iterator iterator = answer.getForm().getLiabilities().iterator(); iterator
					.hasNext();) {
				FundsLiabilityAnswer liabilityAnswer = (FundsLiabilityAnswer) iterator.next();
				liabilityMap.put(liabilityAnswer.getLiability().getLiabilityProject().getId()
						.toString(), liabilityAnswer.getLiability().getAmount());
			}
		}
		put("assetMap", assetMap);
		put("liabilityMap", liabilityMap);
		put("analysisAnswer",answer);
		return forward();
	}
	/**将数据库对象和页面上以'answer'开头的数据合并到answer对象中*/
	public String saveBalanceSheet() {	
		FundsAnalysisAnswer answer = (FundsAnalysisAnswer) populateEntity(
				FundsAnalysisAnswer.class, "answer");
		if (null == answer.getForm()) {
			answer.setForm(new FundsAnalysis());
		}
		List assets = baseCodeService.getCodes(AssetProject.class);
		answer.getForm().getAssets().clear();
		for (Iterator iterator = assets.iterator(); iterator.hasNext();) {
			AssetProject project = (AssetProject) iterator.next();
			FundsAssetAnswer assetAnswer = new FundsAssetAnswer();
			assetAnswer.setAnswer(answer);
			assetAnswer.getAsset().setAssetProject(project);
			assetAnswer.getAsset().setAmount(getFloat("assetProject" + project.getId()));
			answer.getForm().getAssets().add(assetAnswer);
		}
		List liabilities=baseCodeService.getCodes(LiabilityProject.class);
	    answer.getForm().getLiabilities().clear();
	    for(Iterator iterator = liabilities.iterator(); iterator.hasNext(); ){
	    	LiabilityProject project=(LiabilityProject)iterator.next();
	    	FundsLiabilityAnswer liabilityAnswer=new FundsLiabilityAnswer();
	    	liabilityAnswer.setAnswer(answer);
	    	liabilityAnswer.getLiability().setLiabilityProject(project);
	    	liabilityAnswer.getLiability().setAmount(getFloat("liabilityProject" + project.getId()));
	    	answer.getForm().getLiabilities().add(liabilityAnswer);
	    }
		Long cazeId = getLong("caze.id");
		answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success","&caze.id=" + cazeId);
	}
	
	
	protected FundsAnalysisAnswer getBalanceSheetAnswer() {
		EntityQuery query = new EntityQuery(FundsAnalysisAnswer.class, "answer");
		Long cazeId = getLong("caze.id");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List answers = entityService.search(query);
		FundsAnalysisAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new FundsAnalysisAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			answer.setForm(new FundsAnalysis());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (FundsAnalysisAnswer) answers.get(0);
		}
		return answer;
	}
	
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		FundsAnalysisAnswer answer = getBalanceSheetAnswer();
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}
	
	// 查看答案
	public String info() {
		index();
		return forward();
	}
}