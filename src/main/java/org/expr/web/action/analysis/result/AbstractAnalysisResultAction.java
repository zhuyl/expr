package org.expr.web.action.analysis.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.analysis.AbstractResult;
import org.expr.model.analysis.AnalysisForm;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class AbstractAnalysisResultAction extends BaseAction {

	protected void addStdCondition(EntityQuery query,String prefix,Student std){
		if (null == std) {
			query.add(new Condition(prefix+".student.id=:stdId", getLong("std.id")));
		} else {
			query.add(new Condition(prefix+".student=:std", std));
		}
	}
	public String infolet() {
		Long stdId = getLong("std.id");
		Long expId = getEntityId("experiment");
		String type = get("type");
		if (StringUtils.isNotEmpty(type)) {
			EntityQuery query = new EntityQuery(getTypeName(type), "r");
			query.add(new Condition("r.student.id=:stdId and r.experiment.id=:expId", stdId, expId));
			List<AnalysisForm> results = entityService.search(query);
			if (results.size() > 0) {
				put("result", results.get(0));
			}
			String needMembers = get("members");
			if (StringUtils.isNotBlank(needMembers)) {
				query = new EntityQuery(FamilyMemberResult.class, "m");
				query.add(new Condition(
						"m.result.student.id=:stdId and m.result.experiment.id=:expId", stdId,
						expId));
				query.setSelect("m.member");
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

	private String getTypeName(String type) {
		return "org.expr.model.analysis.result." + type + "Result";
	}
}
