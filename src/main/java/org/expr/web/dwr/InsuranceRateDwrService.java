package org.expr.web.dwr;

import java.util.List;

import org.beanfuse.persist.impl.BaseServiceImpl;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.Authentication;
import org.beanfuse.security.AuthenticationException;
import org.expr.model.analysis.FamilyMember;
import org.expr.model.analysis.answer.FamilyMemberAnswer;
import org.expr.model.analysis.result.FamilyMemberResult;
import org.expr.model.basecode.InsurancePayType;
import org.expr.model.insurance.Career;
import org.expr.model.insurance.CareerRate;
import org.expr.model.insurance.InsuranceProduct;
import org.expr.model.insurance.PayTimeRate;

import com.opensymphony.xwork2.ActionContext;

public class InsuranceRateDwrService extends BaseServiceImpl  {
	
	

	public Float calc(Long cazeId, Long productId, Long payTimeId, Long payTypeId, Long timeId,
			String name, Float coverage,Integer age) {

		EntityQuery productquery = new EntityQuery(InsuranceProduct.class, "product");
		productquery.add(new Condition("product.id=:productId", productId));
		List<InsuranceProduct> products = entityService.search(productquery);		
		if(products.isEmpty()){
			return null;
		}
		InsuranceProduct product=products.get(0);
		if(product.getRegistry().getName().equals("缴费期限"))
		{
			return periodcalc( cazeId,  productId,  payTimeId,  payTypeId,  timeId, name,  coverage,age);
		}
		else if(product.getRegistry().getName().equals("职业等级"))
		{
			return careerCalc( cazeId,  productId,  name,  coverage);
		}
		else
		{
			return null;
		}
			
	}

	
	public Float Expcalc(String studentcode,Long experimentId, Long productId, Long payTimeId, Long payTypeId, Long timeId,
			String name, Float coverage,Integer age) {

		EntityQuery productquery = new EntityQuery(InsuranceProduct.class, "product");
		productquery.add(new Condition("product.id=:productId", productId));
		List<InsuranceProduct> products = entityService.search(productquery);		
		if(products.isEmpty()){
			return null;
		}
		InsuranceProduct product=products.get(0);
		if(product.getRegistry().getName().equals("缴费期限"))
		{
			return Expperiodcalc( studentcode,experimentId,  productId,  payTimeId,  payTypeId,  timeId, name,  coverage,age);
		}
		else if(product.getRegistry().getName().equals("职业等级"))
		{
			return ExpcareerCalc( studentcode,experimentId,  productId,  name,  coverage);
		}
		else
		{
			return null;
		}
			
	}
	
	/**
	 * 根据保险期限计算保费
	 * @param cazeId
	 * @param productId
	 * @param payTimeId
	 * @param payTypeId
	 * @param timeId
	 * @param name
	 * @param coverage 保额
	 * @param age
	 * @return
	 */
	public Float periodcalc(Long cazeId, Long productId, Long payTimeId, Long payTypeId, Long timeId,
			String name, Float coverage,Integer age) {
		EntityQuery memquery = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		memquery.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		memquery.add(new Condition("memberAnswer.member.name=:name", name));
		memquery.setSelect("memberAnswer.member");
		List members = entityService.search(memquery);
		if (members.isEmpty()) {
			return null;
		}
		FamilyMember member = (FamilyMember) members.get(0);

		EntityQuery query = new EntityQuery(PayTimeRate.class, "rate");
		query.add(new Condition("rate.product.id=:productId and rate.paytime.id=:paytimeId",
				productId, payTimeId));
		query.add(new Condition("rate.paytype.id=:paytypeId and rate.time.id=:timeId", payTypeId,
				timeId));
		query.add(new Condition("rate.gender=:gender", member.getGender()));
		List rates = entityService.search(query);
		if (rates.isEmpty()) {
			return null;
		}
		List<InsurancePayType> payTypes = entityService.load(InsurancePayType.class, "id", payTypeId);
		if(payTypes.isEmpty())
		{
			return null;
		}
		PayTimeRate rate = (PayTimeRate) rates.get(0);
		Float frate = rate.getAgerates().get(member.getAge()+age-1);
		if (null != frate) {
			return Math.round(frate * coverage*payTypes.get(0).getCountPerYear()*100)/100f;
		} else {
			return null;
		}
	}
	protected String getLoginName() {
		String loginName = (String) ActionContext.getContext().getSession().get(
				Authentication.LOGINNAME);
		if (null == loginName)
			throw new AuthenticationException();
		else
			return loginName;
	}
/**根据实验计算保险期限*/
	public Float Expperiodcalc(String studentcode,Long experimentId, Long productId, Long payTimeId, Long payTypeId, Long timeId,
			String name, Float coverage,Integer age) {
		EntityQuery memquery = new EntityQuery(FamilyMemberResult.class, "memberResult");
		memquery.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		memquery.add(new Condition("memberResult.result.student.code=:stdCode", studentcode));		
		memquery.add(new Condition("memberResult.member.name=:name", name));
		memquery.setSelect("memberResult.member");
		List members = entityService.search(memquery);
		if (members.isEmpty()) {
			return null;
		}
		FamilyMember member = (FamilyMember) members.get(0);

		EntityQuery query = new EntityQuery(PayTimeRate.class, "rate");
		query.add(new Condition("rate.product.id=:productId and rate.paytime.id=:paytimeId",
				productId, payTimeId));
		query.add(new Condition("rate.paytype.id=:paytypeId and rate.time.id=:timeId", payTypeId,
				timeId));
		query.add(new Condition("rate.gender=:gender", member.getGender()));
		List rates = entityService.search(query);
		if (rates.isEmpty()) {
			return null;
		}
		List<InsurancePayType> payTypes = entityService.load(InsurancePayType.class, "id", payTypeId);
		if(payTypes.isEmpty())
		{
			return null;
		}
		PayTimeRate rate = (PayTimeRate) rates.get(0);
		Float frate = rate.getAgerates().get(member.getAge()+age-1);
		if (null != frate) {
			return Math.round(frate * coverage*payTypes.get(0).getCountPerYear()*100)/100f;
		} else {
			return null;
		}
	}
	
	
	
	
	
	/**
	 * 根据职业等级计算保费
	 * */
	public Float careerCalc(Long cazeId, Long productId, String name, Float coverage) {
		/**取得成员*/
		EntityQuery memquery = new EntityQuery(FamilyMemberAnswer.class, "memberAnswer");
		memquery.add(new Condition("memberAnswer.answer.caze.id=:cazeId", cazeId));
		memquery.add(new Condition("memberAnswer.member.name=:name", name));
		memquery.setSelect("memberAnswer.member");
		List members = entityService.search(memquery);
		if (members.isEmpty()) {
			return null;
		}
		FamilyMember member = (FamilyMember) members.get(0);
		/**取得产品*/
		EntityQuery productquery = new EntityQuery(InsuranceProduct.class, "product");
		productquery.add(new Condition("product.id=:productId", productId));
		List<InsuranceProduct> products = entityService.search(productquery);
		if(products.isEmpty())
		{
			return null;
		}	
		/**取得产品的职业等级方案
		EntityQuery careerquery = new EntityQuery(CareerProfile.class, "careerprofile");	
		careerquery.add(new Condition("careerprofile.id=:profileId",products.get(0).getCareerprofile().getId()));
		List<CareerProfile> careerprofiles=entityService.search(careerquery);
		if (careerprofiles.isEmpty()) {
			return null;
		}	*/			
		/**取得职业等级*/
		EntityQuery careerquery = new EntityQuery(Career.class, "career");
		String careername=member.getCareer().getName();
		careerquery.add(new Condition("career.name=:name",careername.trim()));//*按名称取职业等级
		careerquery.add(new Condition("career.profile.id=:profileId",products.get(0).getCareerprofile().getId()));
		List<Career> careers=entityService.search(careerquery);
		Career career=new Career();
		if (!careers.isEmpty()){
			 career=careers.get(0);
		}
		/*返回一个Map*/
		EntityQuery query = new EntityQuery(CareerRate.class, "rate");				
		query.add(new Condition("rate.product.id=:productId",products.get(0).getId()));
		List<CareerRate> rates = entityService.search(query);
		if (rates.isEmpty()) {
			return null;
		}
		Float frate=rates.get(0).getRates().get(career.getGrade().getId());
		if (null != frate) {
			return Math.round(frate * coverage*100)/100f;
		} else {
			return null;
		}
	}	
	
	
	
	public Float ExpcareerCalc(String studentcode,Long experimentId, Long productId, String name, Float coverage) {
		/**取得成员*/
		EntityQuery memquery = new EntityQuery(FamilyMemberResult.class, "memberResult");
		memquery.add(new Condition("memberResult.result.experiment.id=:experimentId", experimentId));
		memquery.add(new Condition("memberResult.result.student.code=:stdCode", studentcode));			
		memquery.add(new Condition("memberResult.member.name=:name", name));
		memquery.setSelect("memberResult.member");
		List members = entityService.search(memquery);
		if (members.isEmpty()) {
			return null;
		}
		FamilyMember member = (FamilyMember) members.get(0);
		/**取得产品*/
		EntityQuery productquery = new EntityQuery(InsuranceProduct.class, "product");
		productquery.add(new Condition("product.id=:productId", productId));
		List<InsuranceProduct> products = entityService.search(productquery);
		if(products.isEmpty())
		{
			return null;
		}	
		/**取得产品的职业等级方案
		EntityQuery careerquery = new EntityQuery(CareerProfile.class, "careerprofile");	
		careerquery.add(new Condition("careerprofile.id=:profileId",products.get(0).getCareerprofile().getId()));
		List<CareerProfile> careerprofiles=entityService.search(careerquery);
		if (careerprofiles.isEmpty()) {
			return null;
		}	*/			
		/**取得职业等级*/
		EntityQuery careerquery = new EntityQuery(Career.class, "career");
		String careername=member.getCareer().getName();
		careerquery.add(new Condition("career.name=:name",careername.trim()));//*按名称取职业等级
		careerquery.add(new Condition("career.profile.id=:profileId",products.get(0).getCareerprofile().getId()));
		List<Career> careers=entityService.search(careerquery);
		Career career=new Career();
		if (!careers.isEmpty()){
			 career=careers.get(0);
		}
		/*返回一个Map*/
		EntityQuery query = new EntityQuery(CareerRate.class, "rate");				
		query.add(new Condition("rate.product.id=:productId",products.get(0).getId()));
		List<CareerRate> rates = entityService.search(query);
		if (rates.isEmpty()) {
			return null;
		}
		Float frate=rates.get(0).getRates().get(career.getGrade().getId());
		if (null != frate) {
			return Math.round(frate * coverage*100)/100f;
		} else {
			return null;
		}
	}	
}
