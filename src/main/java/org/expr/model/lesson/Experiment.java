package org.expr.model.lesson;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.Caze;
import org.expr.model.assessment.Assessment;
import org.expr.model.basecode.Analysis;
import org.expr.model.basecode.ExperimentType;

/**
 * 实验
 * 
 * @author Administrator
 * 
 */
public class Experiment extends LongIdObject {

	/** 教学任务 */
	private Lesson lesson;

	/** 实验编号 */
	private String code;

	/** 实验名称 */
	private String name;

	/** 实验目标 */
	private String aim;

	/** 实验指导 */
	private String coach;

	/** 实验类型 */
	private ExperimentType type;

	/** 案例 */
	private Caze caze;
	
	/**实验评估标准*/
	private Assessment assessment;

	/** 实验开始时间 */
	private Date beginAt;

	/** 实验结束时间 */
	private Date endAt;

	/** 是否发布答案 */
	private boolean publish;
	
	/** 是否发布成绩 */
	private Boolean publishScore;

	/** 是否必选 */
	private boolean compulsory;

	/** 学生集合 */
	private Set students;

	/** 分析表得分集合 */
	private Set<ExperimentMark> marks=new HashSet();

	public ExperimentMark getMark(Analysis analysis) {
		for (Iterator iterator = marks.iterator(); iterator.hasNext();) {
			ExperimentMark mark = (ExperimentMark) iterator.next();
			if (mark.getAnalysis().equals(analysis)) {
				return mark;
			}
		}
		return null;
	}

	public Set getMarks() {
		return marks;
	}

	public void setMarks(Set<ExperimentMark> marks) {
		this.marks = marks;
	}

	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAim() {
		return aim;
	}

	public void setAim(String aim) {
		this.aim = aim;
	}

	public String getCoach() {
		return coach;
	}

	public void setCoach(String coach) {
		this.coach = coach;
	}

	public ExperimentType getType() {
		return type;
	}

	public void setType(ExperimentType type) {
		this.type = type;
	}

	public Caze getCaze() {
		return caze;
	}

	public void setCaze(Caze caze) {
		this.caze = caze;
	}

	public Date getBeginAt() {
		return beginAt;
	}

	public void setBeginAt(Date beginAt) {
		this.beginAt = beginAt;
	}

	public Date getEndAt() {
		return endAt;
	}

	public void setEndAt(Date endAt) {
		this.endAt = endAt;
	}

	public boolean isPublish() {
		return publish;
	}

	public void setPublish(boolean publish) {
		this.publish = publish;
	}

	public boolean isCompulsory() {
		return compulsory;
	}

	public void setCompulsory(boolean compulsory) {
		this.compulsory = compulsory;
	}

	public Set getStudents() {
		return students;
	}

	public void setStudents(Set students) {
		this.students = students;
	}

	public Assessment getAssessment() {
		return assessment;
	}

	public void setAssessment(Assessment assessment) {
		this.assessment = assessment;
	}

	public Boolean getPublishScore() {
		return publishScore;
	}

	public void setPublishScore(Boolean publishScore) {
		this.publishScore = publishScore;
	}

}