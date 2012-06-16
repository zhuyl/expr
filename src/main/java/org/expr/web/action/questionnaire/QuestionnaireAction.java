package org.expr.web.action.questionnaire;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.model.Entity;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.analysis.ScoreRank;
import org.expr.model.basecode.QuestionnaireType;

import com.ekingstar.eams.web.action.BaseAction;

public class QuestionnaireAction extends BaseAction {

	public String index() {
		return forward();
	}

	protected void editSetting(Entity entity) {
		put("questionnaireTypes", entityService.loadAll(QuestionnaireType.class));
	}

	public String rankList() {
		Long questionnaireId = getLong("questionnaire.id");
		Questionnaire questionnaire = (Questionnaire) entityService.get(Questionnaire.class,
				questionnaireId);
		put("questionnaire", questionnaire);
		return forward();
	}

	public String saveRank() {
		Long questionnaireid = getLong("questionnaire.id");
		Questionnaire questionnaire = (Questionnaire) entityService.get(Questionnaire.class,
				questionnaireid);
		int count = getInteger("rankCount");
		Map<Long, ScoreRank> existed = new HashMap();

		for (ScoreRank rank : questionnaire.getRanks()) {
			existed.put(rank.getId(), rank);
		}
		for (int i = 0; i < count; i++) {
			String rankPrefix = "rank" + i + ".";
			Long rankId = getLong(rankPrefix + "id");
			String name=get(rankPrefix + "name");
			if(StringUtils.isBlank(name)){
				continue;
			}
			ScoreRank rank = null;
			if (null != rankId && existed.containsKey(rankId)) {
				rank = existed.remove(rankId);
			} else {
				rank = new ScoreRank();
				rank.setQuestionnaire(questionnaire);
				questionnaire.getRanks().add(rank);
			}
			
			rank.setName(name);
			rank.setLower(getFloat(rankPrefix + "lower"));
			rank.setUpper(getFloat(rankPrefix + "upper"));
		}
		questionnaire.getRanks().removeAll(existed.values());
		entityService.saveOrUpdate(questionnaire);
		return redirect("rankList", "info.save.success", "&questionnaire.id=" + questionnaireid);
	}

}
