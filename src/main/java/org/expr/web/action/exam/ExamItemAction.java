package org.expr.web.action.exam;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.model.Entity;
import org.expr.model.exam.ExamItem;
import org.expr.model.exam.ExamOption;
import org.expr.model.exam.ExamQuestion;


import com.ekingstar.eams.web.action.BaseAction;

public class ExamItemAction extends BaseAction {
	



	protected String saveAndForward(Entity entity) {
		String desc=this.get("examItem.description");
		ExamItem examItem = (ExamItem) populateEntity(ExamItem.class, "examItem");
		Long examQuestionId = getLong("examQuestion.id");
		ExamQuestion examQuestion = (ExamQuestion) entityService.get(ExamQuestion.class,
				examQuestionId);
		examItem.setQuestion(examQuestion);
		int count = getInteger("optionCount");
		Map<Long, ExamOption> existed = new HashMap();

		for (ExamOption option : examItem.getOptions()) {
			existed.put(option.getId(), option);
		}
		for (int i = 0; i < count; i++) {
			String optionPrefix = "option" + i + ".";
			Long optionId = getLong(optionPrefix + "id");
			String code=get(optionPrefix + "code");
			if(StringUtils.isEmpty(code)) continue;
			ExamOption option = null;
			if (null != optionId && existed.containsKey(optionId)) {
				option = existed.remove(optionId);
			} else {
				option = new ExamOption();
				option.setItem(examItem);
				examItem.getOptions().add(option);
			}
			option.setDescription(get(optionPrefix + "description"));
			option.setCode(code);
		}
		examItem.getOptions().removeAll(existed.values());
		entityService.saveOrUpdate(examItem);
		return redirect("search", "info.save.success", "&examQuestion.id=" + examQuestionId);
	}

}
