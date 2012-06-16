package org.expr.web.action.insurance;

import org.beanfuse.collection.Order;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.basecode.CareerGrade;
import org.expr.model.insurance.CareerProfile;
import org.expr.model.insurance.InsuranceProduct;

import com.ekingstar.eams.web.action.BaseAction;

public class CareerAction extends BaseAction {
	public String listinfo(){
		Long productId=Long.valueOf(get("product.id"));
		InsuranceProduct product = (InsuranceProduct) entityService.load(InsuranceProduct.class, productId);
		CareerProfile profile=product.getCareerprofile();
		if(null!=profile)
		{
		EntityQuery query = buildQuery();
		query.join("career.profile", "profile");
		query.add(new Condition("profile.id=:profileId", profile.getId()));
		/*排序*/
		String orderBy=get(Order.ORDER_STR);
		if(null==orderBy){
			orderBy="career.code asc";
		}
		query.addOrder(Order.parse(orderBy));
		put("careers", entityService.search(query));
		put("careerProfile",profile);
		return forward();
		}
		else
		{
			return redirect("listnone", "info.save.success","&product.id="+productId);
		}
	}
	
	public String listnone(){
		return forward();
	}
	public String search(){
		Long profileId=Long.valueOf(get("profile.id"));
		CareerProfile careerProfile = (CareerProfile) entityService.load(CareerProfile.class, profileId);
		EntityQuery query = buildQuery();
		query.join("career.profile", "profile");
		query.add(new Condition("profile.id=:profileId", profileId));
		/*排序*/
		String orderBy=get(Order.ORDER_STR);
		if(null==orderBy){
			orderBy="career.code asc";
		}
		query.addOrder(Order.parse(orderBy));
		put("careers", entityService.search(query));
		put("careerProfile",careerProfile);
		return forward();
	}
	protected void editSetting(Entity entity) {
		put("grades", baseCodeService.getCodes(CareerGrade.class));
		Long profileId=Long.valueOf(get("profile.id"));
		EntityQuery query = buildQuery();
		query.add(new Condition("career.profile.id=:profileId", profileId));
		//query.add(new Condition("size(career.children)!=0"));// 取没有下级节点的职业
		query.add(new Condition("career.grade is null"));// 取没有下级节点的职业
		query.setLimit(null);
		put("careers", entityService.search(query));
		
	}
}
