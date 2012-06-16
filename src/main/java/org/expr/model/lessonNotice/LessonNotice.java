package org.expr.model.lessonNotice;
import java.sql.Date;

import org.beanfuse.model.pojo.LongIdObject;
import org.beanfuse.security.User;
import org.expr.model.lesson.Lesson;


/**
 * 系统公告
 * 
 * @author chaostone
 */
public class LessonNotice extends LongIdObject {
   
    
    /** 标题 */
    private String title;
    /**教学任务*/
    private Lesson lesson;
    
    /** 公告内容 */
    private String content;
    
    /** 修改时间 */
    private Date updatedAt;
    
    /** 发布人 */
    private User publisher;
    
    
    public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}



	public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public User getPublisher() {
        return publisher;
    }
    
    public void setPublisher(User publisher) {
        this.publisher = publisher;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
}