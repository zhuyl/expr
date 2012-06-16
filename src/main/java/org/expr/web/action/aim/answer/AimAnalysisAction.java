package org.expr.web.action.aim.answer;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.aim.AimItem;
import org.expr.model.aim.answer.AimAnswer;
import org.expr.model.aim.answer.AimItemAnswer;
import org.expr.model.basecode.AimType;

public class AimAnalysisAction extends AbstractAimAnswerAction {
	public String search() {
		Long cazeid = getLong("caze.id");
		EntityQuery query = new EntityQuery(AimItemAnswer.class, "m");
		query.add(new Condition("m.answer.caze.id=:cazeId",cazeid));
		query.setLimit(getPageLimit());
		AimAnswer analysisAnswer=getAimAnalysisAnswer();
		put("analysisAnswer",analysisAnswer);
		put("answers", entityService.search(query));
		return forward();
	}
	
	public void editSetting(Entity entity) {
		put("aimTypes", entityService.search(new EntityQuery(AimType.class, "AimType")));
	}
	
	protected String saveAndForward(Entity entity) {
		AimItemAnswer itemAnswer = (AimItemAnswer) entity;
		if (itemAnswer.isVO()) {
			Long cazeid = getLong("caze.id");
			List answers = entityService.load(AimAnswer.class, "caze.id", cazeid);
			AimAnswer answer = null;
			if (answers.isEmpty()) {
				answer = new AimAnswer();
				answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
				//answer.setForm(new Aim());
			} else {
				answer = (AimAnswer) answers.get(0);
			}
			itemAnswer.setAnswer(answer);
			if (answer.getItems()==null){
				Set<AimItem> items=new HashSet();
				items.add(itemAnswer);
				answer.setItems(items);
			}
			else
			{
				answer.getItems().add(itemAnswer);
			}
			entityService.saveOrUpdate(answer);
		} else {
			entityService.saveOrUpdate(itemAnswer);
		}
		return redirect("search", "info.save.success");
	}
	
	private AimAnswer getAimAnalysisAnswer() {
		
		Long cazeid = getLong("caze.id");
		List answers = entityService.load(AimAnswer.class, "caze.id", cazeid);
		AimAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new AimAnswer();
			answer.setCaze((Caze) entityService.load(Caze.class, cazeid));
		} else {
			answer = (AimAnswer) answers.get(0);
		}
		return answer;
	}
	public String saveRemark(){
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		AimAnswer answer = getAimAnalysisAnswer();		
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("search", "info.save.success", "&caze.id=" + cazeId);
	}	
	
	public String info(){
		search();
		return forward();
	}	
}