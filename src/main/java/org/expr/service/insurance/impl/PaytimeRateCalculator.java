package org.expr.service.insurance.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.persist.impl.BaseServiceImpl;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.insurance.PayTimeRate;
import org.expr.model.insurance.Policy;
import org.expr.service.insurance.RateCalculator;
import org.expr.service.insurance.RateResult;

import bsh.EvalError;
import bsh.Interpreter;

public class PaytimeRateCalculator extends BaseServiceImpl implements RateCalculator {

	public RateResult calculate(Policy policy) {
		RateResult result = new RateResult();
		EntityQuery query = new EntityQuery(PayTimeRate.class, "timerate");
		query.add(new Condition("timerate.product=:product and timerate.paytime=:paytime", policy
				.getProduct(), policy.getPaytime()));
		query.add(new Condition("timerate.time=:time and timerate.gender=:gender",
				policy.getTime(), policy.getGender()));
		query.add(new Condition("timerate.paytype=:paytype", policy.getPaytype()));
		List<PayTimeRate> rates = entityService.search(query);
		if (rates.isEmpty()) {
			return result;
		} else {
			PayTimeRate timeRate = rates.get(0);
			Float rate = timeRate.getAgerates().get(policy.getAge());
			result.setRate(rate);
			Number years = calcYears(policy.getAge(), policy.getPaytime().getDuration());
			int countPerYear = policy.getPaytype().getCountPerYear();
			if (years.equals(Double.NaN)) {
				result.setCount(Double.NaN);
			} else {
				result.setCount(years.intValue() * countPerYear);
			}
		}
		return result;
	}

	private Number calcYears(Integer age, String script) {
		if (StringUtils.isEmpty(script)) {
			return Double.NaN;
		}
		Interpreter interpreter = new Interpreter();
		try {
			interpreter.set("age", new Integer(30));
			Number years = (Number) interpreter.eval("41 - age");
			return years.intValue();
		} catch (EvalError e) {
			throw new RuntimeException(e);
		}
	}
}
