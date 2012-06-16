package org.expr.model.analysis.result;

import java.util.Date;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.lesson.Experiment;

import com.ekingstar.eams.student.Student;

/**
 *  案例答题结果
 * @author Administrator
 *
 */
public class CazeResult extends LongIdObject {
	
	private Student student;
	
	private Experiment experiment;
	
	private Float score;

	private Date submitAt;	
	
	private Boolean isSubmit;	
	
	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}

	public Experiment getExperiment() {
		return experiment;
	}

	public void setExperiment(Experiment experiment) {
		this.experiment = experiment;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public Date getSubmitAt() {
		return submitAt;
	}

	public void setSubmitAt(Date submitAt) {
		this.submitAt = submitAt;
	}

	public Boolean getIsSubmit() {
		return isSubmit;
	}

	public void setIsSubmit(Boolean isSubmit) {
		this.isSubmit = isSubmit;
	}

}
