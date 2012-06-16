package org.expr.web.action.insurance;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.insurance.PayTimeRate;
import org.expr.model.insurance.Policy;
import org.expr.service.insurance.RateCalculator;
import org.expr.service.insurance.RateResult;

import com.ekingstar.eams.basecode.nation.Gender;
import com.ekingstar.eams.web.action.BaseAction;

public class PayTimeRateAction extends BaseAction {

	RateCalculator rateCalculator;
	public String search(){
		Long productId=Long.valueOf(get("product.id"));
		EntityQuery query = buildQuery();
		query.join("payTimeRate.product", "product");
		query.add(new Condition("product.id=:productId", productId));
		/*排序*/
		String orderBy=get(Order.ORDER_STR);
		if(null==orderBy){
			orderBy="payTimeRate.paytime.name asc";
		}
		query.addOrder(Order.parse(orderBy));
		
		
		put("payTimeRates", entityService.search(query));
		return forward();
	}

	public String calc() {
		Policy policy = new Policy();
		RateResult rates = rateCalculator.calculate(policy);
		put("rates", rates);
		return forward();
	}

	@Override
	protected void editSetting(Entity entity) {
		put("products", entityService.loadAll(InsuranceProduct.class));
		put("payTimes", baseCodeService.getCodes(InsurancePayTime.class));
		put("payTypes", baseCodeService.getCodes(InsurancePayType.class));
		put("times", baseCodeService.getCodes(InsuranceTime.class));
		put("genders", baseCodeService.getCodes(Gender.class));
	}

	@Override
	protected String saveAndForward(Entity entity) {
		PayTimeRate payTimeRate = (PayTimeRate) entity;
		for (int i = 0; i < 66; i++) {
			Float rate = getFloat("rate" + i);
			if (null == rate) {
				payTimeRate.getAgerates().remove(i);
			} else if (null != rate) {
				payTimeRate.getAgerates().put(i, rate/1000);
			}
		}
		return super.saveAndForward(entity);
	}

	public void setRateCalculator(RateCalculator rateCalculator) {
		this.rateCalculator = rateCalculator;
	}

}
