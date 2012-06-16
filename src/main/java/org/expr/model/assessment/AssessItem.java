package org.expr.model.assessment;


import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.Analysis;

public class AssessItem extends LongIdObject {
	/** 问卷 */
	private Assessment assessment;
	/**分析表*/
	private Analysis phase;
	/**优*/
	private String excellent;
	/**良*/
	private String good;
	/**中*/
	private String middle;
	/**及格*/
	private String pass;
	/**不及格*/
	private String nopass;
	public Analysis getPhase() {
		return phase;
	}
	public void setPhase(Analysis phase) {
		this.phase = phase;
	}
	public String getExcellent() {
		return excellent;
	}
	public void setExcellent(String excellent) {
		this.excellent = excellent;
	}
	public String getGood() {
		return good;
	}
	public void setGood(String good) {
		this.good = good;
	}
	public String getMiddle() {
		return middle;
	}
	public void setMiddle(String middle) {
		this.middle = middle;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNopass() {
		return nopass;
	}
	public void setNopass(String nopass) {
		this.nopass = nopass;
	}
	public Assessment getAssessment() {
		return assessment;
	}
	public void setAssessment(Assessment assessment) {
		this.assessment = assessment;
	}
	
	
}