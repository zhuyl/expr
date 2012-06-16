package org.expr.model.lessonMessage;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.beanfuse.model.pojo.LongIdObject;
import org.beanfuse.security.User;
import org.expr.model.lesson.Lesson;

public class LessonMessage extends LongIdObject {
	 /** 标题 */
    private String title;
    
    /** 内容 */
    private String content;
    
    /** 发送人 */
    private User sender;
    
    /** 消息创建日期 */
    private Date createdAt;
    

    /**教学任务*/
    private Lesson lesson;
    
    private Set<MessageReceiver> receivers = new HashSet();

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Lesson getLesson() {
		return lesson;
	}

	public void setLesson(Lesson lesson) {
		this.lesson = lesson;
	}

	public Set<MessageReceiver> getReceivers() {
		return receivers;
	}

	public void setReceivers(Set<MessageReceiver> receivers) {
		this.receivers = receivers;
	}
}