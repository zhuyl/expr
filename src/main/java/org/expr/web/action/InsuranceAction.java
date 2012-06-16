package org.expr.web.action;

import java.util.List;

import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.insurance.CareerProfile;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.insurance.RateRegistry;

import com.ekingstar.eams.web.action.BaseAction;

public class InsuranceAction extends BaseAction {

	public String index() {
		put("InsuranceTypes", getTopInsuranceTypes());
		return forward();
	}
	
	public String userindex() {
		put("InsuranceTypes", getTopInsuranceTypes());
		return forward();
	}

	private List getTopInsuranceTypes() {
		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
		query.add(new Condition("insuranceType.parent is null"));
		List insuranceTypes = entityService.search(query);
		return insuranceTypes;
	}

	protected String saveAndForward(Entity entity) {
		InsuranceProduct product = (InsuranceProduct) entity;
		product.getTimes().clear();
		product.getTimes().addAll(
				entityService.load(InsuranceTime.class, "id", SeqStringUtil
						.transformToLong(get("selectedInsuranceTimeIds"))));

		product.getPaytimes().clear();
		product.getPaytimes().addAll(
				entityService.load(InsurancePayTime.class, "id", SeqStringUtil
						.transformToLong(get("selectedInsurancePayTimeIds"))));

		product.getPaytypes().clear();
		product.getPaytypes().addAll(
				entityService.load(InsurancePayType.class, "id", SeqStringUtil
						.transformToLong(get("selectedInsurancePayTypeIds"))));
		
		product.getAdditionalProducts().clear();
		product.getAdditionalProducts().addAll(entityService.load(InsuranceProduct.class, "id",SeqStringUtil.transformToLong(get("selectedAdditionalProductsIds"))));
		
		return super.saveAndForward(product);
	}

	protected void editSetting(Entity entity) {
		InsuranceProduct product = (InsuranceProduct) entity;
		put("InsuranceTypes", getTopInsuranceTypes());

		List insurancePayTimes = entityService.loadAll(InsurancePayTime.class);
		insurancePayTimes.removeAll(product.getPaytimes());
		put("insurancePayTimes", insurancePayTimes);

		List insurancePayTypes = entityService.loadAll(InsurancePayType.class);
		insurancePayTypes.removeAll(product.getPaytypes());
		put("insurancePayTypes", insurancePayTypes);

		List insuranceTimes = entityService.loadAll(InsuranceTime.class);
		insuranceTimes.removeAll(product.getTimes());
		put("insuranceTimes", insuranceTimes);

		put("RateRegistries", entityService.loadAll(RateRegistry.class));
		put("CareerProfiles", entityService.loadAll(CareerProfile.class));

		//if (product.isVO() || Boolean.FALSE.equals(product.getAdditional())) {
			EntityQuery query = new EntityQuery(InsuranceProduct.class, "product");
			query.add(new Condition("product.additional=true"));
			List additionalProducts = entityService.search(query);	
			additionalProducts.removeAll(product.getAdditionalProducts());
			put("additionalProducts", additionalProducts);
		//}
	}
	protected void infoSetting(Entity entity) {
		InsuranceProduct product = (InsuranceProduct) entity;
		List insurancePayTypes = entityService.loadAll(InsurancePayType.class);
		put("insurancePayTypes", insurancePayTypes);

		//put("insurancePayTypes",product.getPaytypes());
		put("insurancePayTimes",product.getPaytimes());
		put("insuranceTimes",product.getTimes());
		put("additionalProducts",product.getAdditionalProducts());
	
	}
	public String insuranceQuery() {
		put("InsuranceTypes", getTopInsuranceTypes());
		return forward();
	}

	public String insuranceQueryList() {
		EntityQuery q=new EntityQuery(InsuranceProduct.class,
		"insuranceProduct");
		this.populateConditions(q);
		put("insuranceProducts", entityService.search(q));
		return forward();
	}
	
	public String userlist() throws Exception{
		super.search();
		return forward();
	}
	

}