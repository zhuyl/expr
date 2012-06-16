package org.expr.web.action.analysis.answer;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.BalanceOfPayment;
import org.expr.model.analysis.Expend;
import org.expr.model.analysis.Income;
import org.expr.model.analysis.answer.BalanceOfPaymentAnswer;
import org.expr.model.analysis.answer.ExpendAnswer;
import org.expr.model.analysis.answer.IncomeAnswer;
import org.expr.model.basecode.ExpendProject;
import org.expr.model.basecode.IncomeProject;

/**
 * 月度收支表
 * 
 * @return
 */
public class IncomeExpenseAction extends AbstractAnalysisAnswerAction {
	public String index() {
		BalanceOfPaymentAnswer answer = getIncomeExpenseAnswer();
		put("answer", answer);
		addBaseCode("incomeProjects", IncomeProject.class);
		addBaseCode("expendProjects", ExpendProject.class);

		Map incomeMap = new HashMap();
		Map expendMap = new HashMap();
		if (null != answer.getForm()) {
			for (Iterator iterator = answer.getForm().getIncomes().iterator(); iterator.hasNext();) {
				IncomeAnswer incomeAnswer = (IncomeAnswer) iterator.next();
				incomeMap.put(incomeAnswer.getIncome().getIncomeProject().getId().toString(),
						incomeAnswer.getIncome().getAmount());
			}
			for (Iterator iterator = answer.getForm().getExpends().iterator(); iterator.hasNext();) {
				ExpendAnswer expendAnswer = (ExpendAnswer) iterator.next();
				expendMap.put(expendAnswer.getExpend().getExpendProject().getId().toString(),
						expendAnswer.getExpend().getAmount());
			}
		}
		
		put("incomeMap", incomeMap);
		put("expendMap", expendMap);
		put("analysisAnswer", answer);
		return forward();
	}

	/** 将数据库对象和页面上以'answer'开头的数据合并到answer对象中 */
	public String saveIncomeExpense() {
		BalanceOfPaymentAnswer answer = (BalanceOfPaymentAnswer) populateEntity(BalanceOfPaymentAnswer.class, "answer");
		//BalanceOfPaymentAnswer answer=getIncomeExpenseAnswer();
		if (null == answer.getForm()) {
			answer.setForm(new BalanceOfPayment());
		}
		List incomes = baseCodeService.getCodes(IncomeProject.class);
		answer.getForm().getIncomes().clear();
		for (Iterator iterator = incomes.iterator(); iterator.hasNext();) {
			IncomeProject project = (IncomeProject) iterator.next();
			IncomeAnswer incomeAnswer = new IncomeAnswer();
			incomeAnswer.setAnswer(answer);
			incomeAnswer.setIncome(new Income());
			incomeAnswer.getIncome().setIncomeProject(project);
			incomeAnswer.getIncome().setAmount(getFloat("incomeProject" + project.getId()));
			answer.getForm().getIncomes().add(incomeAnswer);
		}
		List expends = baseCodeService.getCodes(ExpendProject.class);
		answer.getForm().getExpends().clear();
		for (Iterator iterator = expends.iterator(); iterator.hasNext();) {
			ExpendProject project = (ExpendProject) iterator.next();
			ExpendAnswer expendAnswer = new ExpendAnswer();
			expendAnswer.setExpend(new Expend());
			expendAnswer.setAnswer(answer);
			expendAnswer.getExpend().setExpendProject(project);
			expendAnswer.getExpend().setAmount(getFloat("expendProject" + project.getId()));
			answer.getForm().getExpends().add(expendAnswer);
		}
		Long cazeId = getLong("caze.id");
		answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success");
	}

	protected BalanceOfPaymentAnswer getIncomeExpenseAnswer() {
		EntityQuery query = new EntityQuery(BalanceOfPaymentAnswer.class, "answer");
		Long cazeId = getLong("caze.id");
		query.add(new Condition("answer.caze.id=:cazeId", cazeId));
		List answers = entityService.search(query);
		BalanceOfPaymentAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new BalanceOfPaymentAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			answer.setForm(new BalanceOfPayment());
			entityService.saveOrUpdate(answer);
		} else {
			answer = (BalanceOfPaymentAnswer) answers.get(0);
		}
		return answer;
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		BalanceOfPaymentAnswer answer = getIncomeExpenseAnswer();
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
	}

}