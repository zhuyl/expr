package org.expr.model.lesson;

import java.util.Date;

import org.beanfuse.model.pojo.LongIdObject;

import com.ekingstar.eams.student.Student;

public class StudyLog extends LongIdObject {

	private Student std;
	
	private String ip;
	
	private Experiment experiment;
	
	private Date startAt;
	
	private Date finishAt;

	private Long time;
	
	public Student getStd() {
		return std;
	}

	public void setStd(Student std) {
		this.std = std;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Experiment getExperiment() {
		return experiment;
	}

	public void setExperiment(Experiment experiment) {
		this.experiment = experiment;
	}

	public Date getStartAt() {
		return startAt;
	}

	public void setStartAt(Date startAt) {
		this.startAt = startAt;
	}

	public Date getFinishAt() {
		return finishAt;
	}

	public void setFinishAt(Date finishAt) {
		this.finishAt = finishAt;
	}

	public Long getTime() {
		return time;
	}

	public void setTime(Long time) {
		this.time = time;
	}
	
}
