package org.expr.web.action.analysis.result;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.FundsAnalysis;
import org.expr.model.analysis.result.FundsAnalysisResult;
import org.expr.model.analysis.result.FundsAssetResult;
import org.expr.model.analysis.result.FundsLiabilityResult;
import org.expr.model.basecode.AssetProject;
import org.expr.model.basecode.LiabilityProject;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

	/**
	 * 资产负债表
	 * 
	 * @return
	 */
public class BalanceSheetAction extends AbstractAnalysisResultAction {
	
	public String index() {
		Long experimentId=getLong("experiment.id");
		FundsAnalysisResult result=getBalanceSheetResult();
		put("result", result);
		addBaseCode("assetProjects", AssetProject.class);
		addBaseCode("liabilityProjects", LiabilityProject.class);

		Map assetMap = new HashMap();
		Map liabilityMap = new HashMap();
		if (null != result.getForm()) {
			for (Iterator iterator = result.getForm().getAssets().iterator(); iterator.hasNext();) {
				FundsAssetResult assetResult = (FundsAssetResult) iterator.next();
				assetMap.put(assetResult.getAsset().getAssetProject().getId().toString(),
						assetResult.getAsset().getAmount());
			}
			for (Iterator iterator = result.getForm().getLiabilities().iterator(); iterator
					.hasNext();) {
				FundsLiabilityResult liabilityResult = (FundsLiabilityResult) iterator.next();
				liabilityMap.put(liabilityResult.getLiability().getLiabilityProject().getId()
						.toString(), liabilityResult.getLiability().getAmount());
			}
		}
		
		put("assetMap", assetMap);
		put("liabilityMap", liabilityMap);
		put("analysisResult",result);
		return forward();
	}
	/**将数据库对象和页面上以'result'开头的数据合并到result对象中*/
	public String saveBalanceSheet() {	
		FundsAnalysisResult result = (FundsAnalysisResult) populateEntity(
				FundsAnalysisResult.class, "result");
		if (null == result.getForm()) {
			result.setForm(new FundsAnalysis());
		}
		List assets = baseCodeService.getCodes(AssetProject.class);
		result.getForm().getAssets().clear();
		for (Iterator iterator = assets.iterator(); iterator.hasNext();) {
			AssetProject project = (AssetProject) iterator.next();
			FundsAssetResult assetResult = new FundsAssetResult();
			assetResult.setResult(result);
			assetResult.getAsset().setAssetProject(project);
			assetResult.getAsset().setAmount(getFloat("assetProject" + project.getId()));
			result.getForm().getAssets().add(assetResult);
		}
		List liabilities=baseCodeService.getCodes(LiabilityProject.class);
	    result.getForm().getLiabilities().clear();
	    for(Iterator iterator = liabilities.iterator(); iterator.hasNext(); ){
	    	LiabilityProject project=(LiabilityProject)iterator.next();
	    	FundsLiabilityResult liabilityResult=new FundsLiabilityResult();
	    	liabilityResult.setResult(result);
	    	liabilityResult.getLiability().setLiabilityProject(project);
	    	liabilityResult.getLiability().setAmount(getFloat("liabilityProject" + project.getId()));
	    	result.getForm().getLiabilities().add(liabilityResult);
	    }
		saveOrUpdate(result);
		return redirect("index", "info.save.success");
	}
	
	
	protected FundsAnalysisResult getBalanceSheetResult() {
		EntityQuery query = new EntityQuery(FundsAnalysisResult.class, "result");
		Long experimentId = getLong("experiment.id");
		query.add(new Condition("result.experiment.id=:experimentId" ,experimentId));
		query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		List results = entityService.search(query);
		FundsAnalysisResult result = null;
		if (results.isEmpty()) {
			result = new FundsAnalysisResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
			List studentList = (List)entityService.load(Student.class,"code",getLoginName());
			if (null != studentList && studentList.size()!=0){
				result.setStudent((Student)studentList.get(0));
			}	
			result.setForm(new FundsAnalysis());
			entityService.saveOrUpdate(result);
		} else {
			result = (FundsAnalysisResult) results.get(0);
		}
		return result;
	}
	
	public String saveRemark(){
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		FundsAnalysisResult result = getBalanceSheetResult();
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}
}