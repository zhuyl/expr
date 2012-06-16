package org.expr.model.analysis.answer;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;
import org.expr.model.analysis.AnalysisForm;

public class AbstractAnalysisAnswer extends LongIdObject implements AnalysisForm {
	/** 得分 */
	private Float score;

	/** 所属caze */
	private Caze caze;
	
	/**说明*/
	private String remark;
	

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}

}
