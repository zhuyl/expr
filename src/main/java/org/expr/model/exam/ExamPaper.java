package org.expr.model.exam;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.lesson.Lesson;

/**
 * 试卷 试卷名称、开始时间、结束时间、导语、备注
 * 
 * @author Administrator
 * 
 */
public class ExamPaper extends LongIdObject {
	/**课程*/
	private Lesson lesson;
	/**序号*/
	private String code;
	/** 试卷名称 */
	private String name;

	/** 开始时间 */
	private Date beginAt;
	/** 结束时间 */
	private Date endAt;

	/** 导语 */
	private String description;
	/** 备注 */
	private String memo;
	/**考试时间*/
	private Integer period;

	/** 试题 */
	private Set<ExamQuestionMark> questionMarks = new HashSet();

	public Integer getPeriod() {
		return period;
	}

	public void setPeriod(Integer period) {
		this.period = period;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Set<ExamQuestionMark> getQuestionMarks() {
		return questionMarks;
	}

	public void setQuestionMarks(Set<ExamQuestionMark> questions) {
		this.questionMarks = questions;
	}

}