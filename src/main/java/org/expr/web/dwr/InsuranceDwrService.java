package org.expr.web.dwr;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.beanfuse.persist.impl.BaseServiceImpl;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.InsurancePayTime;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.basecode.InsuranceTime;
import org.expr.model.basecode.InsuranceType;
import org.expr.model.insurance.InsuranceProduct;

public class InsuranceDwrService extends BaseServiceImpl {

	public List<InsuranceType> getInsuranceTypes(Long parentId) {
		if (null == parentId) {
			return Collections.EMPTY_LIST;
		}
		EntityQuery query = new EntityQuery(InsuranceType.class, "insuranceType");
		query.add(new Condition("insuranceType.parent.id=:parentId", parentId));
		return entityService.search(query);
	}

	public List<InsurancePayType> getInsuranctPayTypes(Long productId) {
		if (null == productId) {
			return Collections.EMPTY_LIST;
		}
		InsuranceProduct insuranceProduct = (InsuranceProduct) entityService.get(
				InsuranceProduct.class, productId);
		return new ArrayList<InsurancePayType>(insuranceProduct.getPaytypes());
	}

	public List<InsurancePayTime> getInsuranctPayTimes(Long productId) {
		if (null == productId) {
			return Collections.EMPTY_LIST;
		}
		InsuranceProduct insuranceProduct = (InsuranceProduct) entityService.get(
				InsuranceProduct.class, productId);
		return new ArrayList<InsurancePayTime>(insuranceProduct.getPaytimes());
	}

	public List<InsuranceTime> getInsuranctTimes(Long productId) {
		if (null == productId) {
			return Collections.EMPTY_LIST;
		}
		InsuranceProduct insuranceProduct = (InsuranceProduct) entityService.get(
				InsuranceProduct.class, productId);
		return new ArrayList<InsuranceTime>(insuranceProduct.getTimes());
	}
}
