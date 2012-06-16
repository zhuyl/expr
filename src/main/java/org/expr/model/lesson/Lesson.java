package org.expr.model.lesson;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;

import com.ekingstar.eams.student.Student;

/**
 * 教学任务
 * 
 * @author Administrator
 * 
 */
public class Lesson extends LongIdObject {
    
    /** 课程 名称*/
    private String coursename;
    
    /** 课程序号 */
    private String seqNo;

    /** 教师集合 */
    private List teachers = new ArrayList();
    
    /** 学生集合 */
    private Set<Student> students;
    
    /** 实验集合 */
    private Set experiments;
    

    /**有效期开始时间*/
    private Date beginAt;
    /**有效期结束时间*/
    private Date endAt;
    
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


	public String getCoursename() {
		return coursename;
	}

	public void setCoursename(String coursename) {
		this.coursename = coursename;
	}

	public String getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}


	public List getTeachers() {
		return teachers;
	}

	public void setTeachers(List teachers) {
		this.teachers = teachers;
	}

	public Set<Student> getStudents() {
		return students;
	}

	public void setStudents(Set<Student> students) {
		this.students = students;
	}

	public Set getExperiments() {
		return experiments;
	}

	public void setExperiments(Set experiments) {
		this.experiments = experiments;
	}
    

}