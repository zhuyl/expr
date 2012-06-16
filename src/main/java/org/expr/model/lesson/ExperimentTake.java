package org.expr.model.lesson;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;

import com.ekingstar.eams.student.Student;

/**
 * 实验
 * 
 * @author Administrator
 * 
 */
public class ExperimentTake extends LongIdObject {

	private Student student;

	private Experiment experiment;

	private Caze caze;

	private Float score;

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

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

}