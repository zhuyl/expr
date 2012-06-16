package org.expr.web.action.analysis.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;

import com.ekingstar.eams.web.action.BaseAction;

public class AbstractAnalysisAnswerAction extends BaseAction {

	public String infolet() {
		Long cazeId = getEntityId("caze");
		String type = get("type");
		if (StringUtils.isNotEmpty(type)) {
			EntityQuery query = new EntityQuery(getAnswerTypeName(type), "a");
			query.add(new Condition("a.caze.id=:cazeId ", cazeId));
			List<AnalysisForm> answers = entityService.search(query);
			if (answers.size() > 0) {
				put("result", answers.get(0));
			}
			String needMembers = get("members");
			if (StringUtils.isNotBlank(needMembers)) {
				query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
				query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
				query.setSelect("memberAnswer.member");
				List<FamilyMember> members = entityService.search(query);
				Map membersMap = new HashMap();
				for (FamilyMember member : members) {
					membersMap.put(member.getName(), member);
				}
				put("membersMap", membersMap);
				put("members", members);
			}
		}
		return forward("../../infolet/info");
	}

	private String getAnswerTypeName(String type) {
		return "org.expr.model.analysis.answer." + type + "Answer";
	}
}
