package org.expr.web.action.plan.answer;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.struts2.route.Action;
import org.expr.model.Caze;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.plan.answer.InsurancePlanAnswer;
import org.expr.model.plan.answer.InsurancePlanPolicyAnswer;

public class InsurancePlanAction extends AbstractPlanAnswerAction {
	/**
	 * 保险规划
	 * 
	 * @return
	 */
	public String index() {
		Long cazeId = getLong("caze.id");
		InsurancePlanAnswer answer = null;
		List<InsurancePlanAnswer> answers = entityService.load(InsurancePlanAnswer.class,
				"caze.id", cazeId);
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new InsurancePlanAnswer();
		}
		put("answer", answer);
		EntityQuery query = new EntityQuery(InsurancePlanPolicyAnswer.class, "pa");
		if (answer.isSaved()) {
			query.add(new Condition("pa.answer=:answer", answer));
			query.addOrder(Order.parse(get("orderBy")));
			if(null==get("nopage")){
				query.setLimit(getPageLimit());
			}
			List<InsurancePlanPolicyAnswer> policies = entityService.search(query);
			put("policies", policies);
		}
		/** 取人员 */
		query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		/** 人员保单 */
		Map<String, List<InsurancePlanPolicyAnswer>> memberpolicies = new HashMap();
		EntityQuery productquery = new EntityQuery();
		for (int i = 0; i < members.size(); i++) {
			FamilyMember member = members.get(i);
			productquery = new EntityQuery(InsurancePlanPolicyAnswer.class, "policyanswer");
			productquery.add(new Condition("policyanswer.answer.caze.id=:cazeId", cazeId));
			productquery.add(new Condition("policyanswer.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyAnswer> memberpolicy = entityService.search(productquery);
			memberpolicies.put(member.getName(), memberpolicy);
		}
		put("memberpolicies", memberpolicies);
		/** 保单保额保费 */
		Map<String, Map<String, Map<Integer, Double>>> coverages = new HashMap();
		Map<String, Map<String, Map<Integer, Double>>> expenses = new HashMap();
		for (int j = 0; j < members.size(); j++) {
			FamilyMember member = members.get(j);
			Map<String, Map<Integer, Double>> membercoverages = new HashMap();
			Map<String, Map<Integer, Double>> memberexpenses = new HashMap();
			productquery = new EntityQuery(InsurancePlanPolicyAnswer.class, "policyanswer");
			productquery.add(new Condition("policyanswer.answer.caze.id=:cazeId", cazeId));
			productquery.add(new Condition("policyanswer.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyAnswer> memberpolicy = entityService.search(productquery);

			for (InsurancePlanPolicyAnswer policyAnswer : memberpolicy) {
				Map<Integer, Double> coverage = new HashMap();
				Map<Integer, Double> expense = new HashMap();
				for (int i = 0; i <= getPlanYears(); i++) {
					coverage.put(i, 0d);
					expense.put(i, 0d);
				}
				int paytime = calcYears(member.getAge(), policyAnswer.getPayTime().getDuration());
				for (int i = policyAnswer.getApplyOn(); i <= paytime + policyAnswer.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					expense.put(i, policyAnswer.getExpense().doubleValue());
					/** 保费 */
				}
				int insurancetime = calcYears(member.getAge() + policyAnswer.getApplyOn(),
						policyAnswer.getTime().getDuration());
				for (int i = policyAnswer.getApplyOn(); i <= insurancetime
						+ policyAnswer.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					coverage.put(i, policyAnswer.getCoverage().doubleValue());
					/** 保额 */
				}
				memberexpenses.put(policyAnswer.getProduct().getName(), expense);
				membercoverages.put(policyAnswer.getProduct().getName(), coverage);
			}
			expenses.put(member.getName(), memberexpenses);
			coverages.put(member.getName(), membercoverages);
		}
		put("expenses", expenses);
		put("coverages", coverages);
		return forward();
	}

	/** 计算保险期限，缴费期限的年份 */
	private Integer calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return 30;
		} else {
			if (StringUtils.contains(script, "age")) {
				return Integer.parseInt(script.substring(0,script.indexOf("-"))) - age + 1;
			} else {
				return Integer.parseInt(script) - 1;
			}
		}
	}

	// 保险规划删除
	public String remove() {
		Long[] policyAnswerIds = SeqStringUtil.transformToLong(get("policyAnswerIds"));
		if (null != policyAnswerIds) {
			List policyAnswers = entityService.load(InsurancePlanPolicyAnswer.class, "id",
					policyAnswerIds);
			entityService.remove(policyAnswers);
		}
		return redirect("index", "info.action.success", "&caze.id=" + get("caze.id"));
	}

	// 保险规划添加
	public String edit() {
		put("products", entityService.loadAll(InsuranceProduct.class));
		Long policyAnswerId = getLong("policyAnswerId");
		InsurancePlanPolicyAnswer answer = null;
		if (null != policyAnswerId) {
			answer = (InsurancePlanPolicyAnswer) entityService.load(
					InsurancePlanPolicyAnswer.class, policyAnswerId);
		} else {
			answer = new InsurancePlanPolicyAnswer();
		}
		Long cazeId = getLong("caze.id");
		EntityQuery query = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		query.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		query.setSelect("memberAnswer.member");
		put("members", entityService.search(query));
		put("policyAnswer", answer);
		put("times", entityService.search(new EntityQuery(InsuranceTime.class, "time1")));
		put("payTimes", entityService.search(new EntityQuery(InsurancePayTime.class, "time1")));
		put("payTypes", entityService.search(new EntityQuery(InsurancePayType.class, "time1")));
		return forward();
	}

	public String save() {
		Long cazeId = getLong("caze.id");
		// Integer applyOn=getLong("policyAnswer.applyOn").intValue();
		InsurancePlanPolicyAnswer policyAnswer = (InsurancePlanPolicyAnswer) populateEntity(
				InsurancePlanPolicyAnswer.class, "policyAnswer");
		Long productId = getLong("product.id");
		if (null != productId) {
			InsuranceProduct product = (InsuranceProduct) entityService.get(InsuranceProduct.class,
					productId);
			if (product.getAdditional()) {
				EntityQuery masterQuery = new EntityQuery(InsurancePlanPolicyAnswer.class, "ppa");
				masterQuery.add(new Condition("ppa.answer=:answer", policyAnswer.getAnswer()));
				masterQuery.add(new Condition("ppa.product.id = :masterId", product
						.getMasterProduct().getId()));
				List<InsurancePlanPolicyAnswer> masters = entityService.search(masterQuery);
				if (masters.size() != 1) {
					addActionError("没有购买" + product.getName() + "的主险");
					return forward(new Action(this, "edit"));
				}
				policyAnswer.setMaster(masters.get(0));
			}
			policyAnswer.setProduct(product);
			// policyAnswer.setApplyOn(applyOn);
		}
		EntityQuery query = new EntityQuery(InsurancePlanAnswer.class, "answer");
		query.add(new Condition("answer.caze.id=:cazeId", getLong("caze.id")));
		List answers = entityService.search(query);
		InsurancePlanAnswer answer = null;
		if (answers.isEmpty()) {
			answer = new InsurancePlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
		} else {
			answer = (InsurancePlanAnswer) answers.get(0);
		}
		answer.getPolicies().add(policyAnswer);
		policyAnswer.setAnswer(answer);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.action.success", "&caze.id=" + cazeId);
	}

	private InsurancePlanAnswer InsurancePlanAnswer(Long cazeId) {
		EntityQuery query = new EntityQuery(InsurancePlanAnswer.class, "insurancePlan");
		query.add(new Condition("insurancePlan.caze.id=:cazeId", cazeId));
		List<InsurancePlanAnswer> answers = entityService.search(query);
		InsurancePlanAnswer answer = null;
		if (!answers.isEmpty()) {
			answer = answers.get(0);
		} else {
			answer = new InsurancePlanAnswer();
			answer.setCaze((Caze) entityService.get(Caze.class, cazeId));
			entityService.saveOrUpdate(answer);
		}
		return answer;
	}

	public String saveRemark() {
		Long cazeId = getLong("caze.id");
		String remark = get("remark");
		InsurancePlanAnswer answer = InsurancePlanAnswer(cazeId);
		answer.setRemark(remark);
		entityService.saveOrUpdate(answer);
		return redirect("index", "info.save.success", "&caze.id=" + cazeId);
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
