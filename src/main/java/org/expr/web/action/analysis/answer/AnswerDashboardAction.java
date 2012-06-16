package org.expr.web.action.analysis.answer;

import com.ekingstar.eams.web.action.BaseAction;
/**
 * 答案管理界面
 * @author Administrator
 *
 */
public class AnswerDashboardAction extends BaseAction {

	public String index() {
		put("cazeId", get("cazeId"));
		return forward();
	}
	public String analysisTree() {
		return forward();
	}
}
