package org.expr.model.analysis;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

public class AbstractResult extends LongIdObject {
	
	protected Experiment experiment;

	protected Student student;

	protected String remark;

	protected Float score;

	public Experiment getExperiment() {
		return experiment;
	}

	public void setExperiment(Experiment experiment) {
		this.experiment = experiment;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

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

}
