package org.expr.web.action.plan.result;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.struts2.route.Action;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.lesson.Experiment;
import org.expr.model.plan.result.InsurancePlanPolicyResult;
import org.expr.model.plan.result.InsurancePlanResult;

import com.ekingstar.eams.student.Student;

public class InsurancePlanAction extends AbstractPlanResultAction {
	/**
	 * 保险规划
	 * 
	 * @return
	 */
	public String index() {
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(InsurancePlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", experimentId));
		Student std = getLoginStudent();
		addStdCondition(query, "result", std);
		List<InsurancePlanResult> results = entityService.search(query);
		InsurancePlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new InsurancePlanResult();
		}
		put("result", result);
		if (result.isSaved()) {
			query = new EntityQuery(InsurancePlanPolicyResult.class, "pa");
			query.add(new Condition("pa.result=:result", result));
			query.addOrder(Order.parse(get("orderBy")));
			if (null == get("nopage")) {
				query.setLimit(getPageLimit());
			}
			List<InsurancePlanPolicyResult> policies = entityService.search(query);
			put("policies", policies);
		}
		/** 取人员 */
		query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		addStdCondition(query, "memberResult.result", std);
		query.setSelect("memberResult.member");
		List<FamilyMember> members = entityService.search(query);
		put("members", members);
		/** 人员保单 */
		Map<String, List<InsurancePlanPolicyResult>> memberpolicies = new HashMap();
		EntityQuery productquery = new EntityQuery();
		for (int i = 0; i < members.size(); i++) {
			FamilyMember member = members.get(i);
			productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
			productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
					experimentId));
			addStdCondition(query, "policyresult.result", std);
			productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyResult> memberpolicy = entityService.search(productquery);
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
			productquery = new EntityQuery(InsurancePlanPolicyResult.class, "policyresult");
			productquery.add(new Condition("policyresult.result.experiment.id=:experimentId",
					experimentId));
			addStdCondition(query, "policyresult.result", std);
			productquery.add(new Condition("policyresult.insurant=:insurant", member.getName()));
			List<InsurancePlanPolicyResult> memberpolicy = entityService.search(productquery);

			for (InsurancePlanPolicyResult policyResult : memberpolicy) {
				Map<Integer, Double> coverage = new HashMap();
				Map<Integer, Double> expense = new HashMap();
				for (int i = 0; i <= getPlanYears(); i++) {
					coverage.put(i, 0d);
					expense.put(i, 0d);
				}
				int paytime = calcYears(member.getAge(), policyResult.getPayTime().getDuration());
				for (int i = policyResult.getApplyOn(); i <= paytime + policyResult.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					expense.put(i, policyResult.getExpense().doubleValue());
					/** 保费 */
				}
				int insurancetime = calcYears(member.getAge() + policyResult.getApplyOn(),
						policyResult.getTime().getDuration());
				for (int i = policyResult.getApplyOn(); i <= insurancetime
						+ policyResult.getApplyOn(); i++) {
					if (i > 30) {
						break;
					}
					coverage.put(i, policyResult.getCoverage().doubleValue());
					/** 保额 */
				}
				memberexpenses.put(policyResult.getProduct().getName(), expense);
				membercoverages.put(policyResult.getProduct().getName(), coverage);
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
		Long[] policyResultIds = SeqStringUtil.transformToLong(get("policyResultIds"));
		if (null != policyResultIds) {
			List policyResults = entityService.load(InsurancePlanPolicyResult.class, "id",
					policyResultIds);
			entityService.remove(policyResults);
		}
		return redirect("index", "info.action.success", "&experiment.id=" + get("experiment.id"));
	}

	// 保险规划添加
	public String edit() {
		put("studentCode", getLoginName());
		put("products", entityService.loadAll(InsuranceProduct.class));
		Long policyResultId = getLong("policyResultId");
		InsurancePlanPolicyResult result = null;
		if (null != policyResultId) {
			result = (InsurancePlanPolicyResult) entityService.load(
					InsurancePlanPolicyResult.class, policyResultId);
		} else {
			result = new InsurancePlanPolicyResult();
		}
		Long experimentId = getLong("experiment.id");
		EntityQuery query = new EntityQuery(FamilyMemberResult.class, "memberResult");
		query.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		query.add(new Condition("memberResult.result.student.code=:stdCode", getLoginName()));
		query.setSelect("memberResult.member");
		put("members", entityService.search(query));
		put("policyResult", result);
		put("times", entityService.search(new EntityQuery(InsuranceTime.class, "time1")));
		put("payTimes", entityService.search(new EntityQuery(InsurancePayTime.class, "time1")));
		put("payTypes", entityService.search(new EntityQuery(InsurancePayType.class, "time1")));
		return forward();
	}

	public String save() {
		Long experimentId = getLong("experiment.id");
		// Integer applyOn=getLong("policyResult.applyOn").intValue();
		InsurancePlanPolicyResult policyResult = (InsurancePlanPolicyResult) populateEntity(
				InsurancePlanPolicyResult.class, "policyResult");
		Long productId = getLong("product.id");
		if (null != productId) {
			InsuranceProduct product = (InsuranceProduct) entityService.get(InsuranceProduct.class,
					productId);
			if (product.getAdditional()) {
				EntityQuery masterQuery = new EntityQuery(InsurancePlanPolicyResult.class, "ppa");
				masterQuery.add(new Condition("ppa.result=:result", policyResult.getResult()));
				masterQuery.add(new Condition("ppa.product.id = :masterId", product
						.getMasterProduct().getId()));
				List<InsurancePlanPolicyResult> masters = entityService.search(masterQuery);
				if (masters.size() != 1) {
					addActionError("没有购买" + product.getName() + "的主险");
					return forward(new Action(this, "edit"));
				}
				policyResult.setMaster(masters.get(0));
			}
			policyResult.setProduct(product);
			// policyResult.setApplyOn(applyOn);
		}
		EntityQuery query = new EntityQuery(InsurancePlanResult.class, "result");
		query.add(new Condition("result.experiment.id=:experimentId", getLong("experiment.id")));
		query.add(new Condition("result.student.code=:stdCode", getLoginName()));
		List results = entityService.search(query);
		InsurancePlanResult result = null;
		if (results.isEmpty()) {
			result = new InsurancePlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
			List studentList = (List) entityService.load(Student.class, "code", getLoginName());
			if (null != studentList && studentList.size() != 0) {
				result.setStudent((Student) studentList.get(0));
			}
		} else {
			result = (InsurancePlanResult) results.get(0);
		}
		result.getPolicies().add(policyResult);
		policyResult.setResult(result);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.action.success", "&experiment.id=" + experimentId);
	}

	private InsurancePlanResult getInsurancePlanResult(Long experimentId) {
		EntityQuery query = new EntityQuery(InsurancePlanResult.class, "insurancePlan");
		query.add(new Condition("insurancePlan.experiment.id=:experimentId", experimentId));
		//query.add(new Condition("insurancePlan.student.code=:stdCode", getLoginName()));
		Student std=getLoginStudent();
		addStdCondition(query,"insurancePlan",std);
		List<InsurancePlanResult> results = entityService.search(query);
		InsurancePlanResult result = null;
		if (!results.isEmpty()) {
			result = results.get(0);
		} else {
			result = new InsurancePlanResult();
			result.setExperiment((Experiment) entityService.get(Experiment.class, experimentId));
//			List studentList = (List) entityService.load(Student.class, "code", getLoginName());
//			if (null != studentList && studentList.size() != 0) {
//				result.setStudent((Student) studentList.get(0));
//			}
			if (std==null)
			{
				std=(Student)entityService.load(Student.class,getLong("std.id"));
			}
			result.setStudent(std);
			entityService.saveOrUpdate(result);
		}
		return result;
	}

	public String saveRemark() {
		Long experimentId = getLong("experiment.id");
		String remark = get("remark");
		InsurancePlanResult result = getInsurancePlanResult(experimentId);
		result.setRemark(remark);
		entityService.saveOrUpdate(result);
		return redirect("index", "info.save.success", "&experiment.id=" + experimentId);
	}

	@Override
	public String infolet() {
		index();
		return forward("../../infolet/info");
	}

}
