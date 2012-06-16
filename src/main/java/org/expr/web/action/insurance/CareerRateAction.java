package org.expr.web.action.insurance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.CareerGrade;
import org.expr.model.insurance.CareerRate;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.insurance.Policy;
import org.expr.service.insurance.RateCalculator;
import org.expr.service.insurance.RateResult;

import com.ekingstar.eams.web.action.BaseAction;

public class CareerRateAction extends BaseAction{

	RateCalculator rateCalculator;
	
	public String calc(){
		Policy policy =new Policy();
		RateResult rates=rateCalculator.calculate(policy);
		put("rates",rates);
		return forward();
	}

	public void setRateCalculator(RateCalculator rateCalculator) {
		this.rateCalculator = rateCalculator;
	}

	public String search(){
		Long productId=Long.valueOf(get("product.id"));
		EntityQuery query = buildQuery();
		query.join("careerRate.product", "product");
		query.add(new Condition("product.id=:productId", productId));
		List rs=entityService.search(query);
		if(rs.size()>0){
		put("careerRate",rs.get(0) );
		}
		put("grades", baseCodeService.getCodes(CareerGrade.class));
		return forward();
	}
	
	
	protected String saveAndForward(Entity entity) {
		CareerRate careerRate = (CareerRate) populateEntity(CareerRate.class, "careerRate");
		Long productId = Long.valueOf(get("product.id"));
		InsuranceProduct insuranceProduct = (InsuranceProduct) entityService.get(InsuranceProduct.class,
				productId);
		careerRate.setProduct(insuranceProduct);

		EntityQuery query = new EntityQuery(CareerGrade.class, "grade");
		List grades = entityService.search(query);	
		Map<Long, Float> rates = new HashMap();
		
        for(int i=0;i<grades.size();i++)
        {
        	String ratePrefix="rates"+i+".rate";
        	Float rate=Float.valueOf(get(ratePrefix));
        	rates.put(((CareerGrade)(grades.get(i))).getId(), rate/1000);
        }
        careerRate.setRates(rates);
		entityService.saveOrUpdate(careerRate);
		return redirect("search", "info.save.success", "&product.id=" + productId);
	}

}
