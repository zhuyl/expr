package org.expr.model.analysis;

import java.util.Date;

import org.beanfuse.model.Component;
import org.expr.model.basecode.BenefitRelation;
import org.expr.model.insurance.Career;

import com.ekingstar.eams.basecode.nation.Gender;

/**
 * 家庭成员表
 * 
 * @author Administrator
 * 
 */
public class FamilyMember implements Component {

	/** 姓名 */
	private String name;

	/** 性别 */
	private Gender gender;

	/** 年龄 */
	private Integer age;
	
	/** 生日 */
	private Date birthday;

	/** 职业分类 */
	private Career career;

	/** 角色 **/
	private BenefitRelation relation;

	/** 收入 **/
	private Float salary;
	
	/** 工作单位 **/
	private String department;

	public BenefitRelation getRelation() {
		return relation;
	}

	public void setRelation(BenefitRelation relation) {
		this.relation = relation;
	}

	public Float getSalary() {
		return salary;
	}

	public void setSalary(Float salary) {
		this.salary = salary;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public Career getCareer() {
		return career;
	}

	public void setCareer(Career career) {
		this.career = career;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

}