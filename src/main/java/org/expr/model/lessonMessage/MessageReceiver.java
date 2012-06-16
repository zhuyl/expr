package org.expr.model.lessonMessage;
import org.beanfuse.model.pojo.LongIdObject;
import org.beanfuse.security.User;
import org.expr.model.basecode.MessageStatus;

public class MessageReceiver extends LongIdObject {

	/**消息*/
	private LessonMessage message ;
	
	   /** 接受者 */
    private User recipient;
    
    /** 消息状态 */
    private MessageStatus status;

	public LessonMessage getMessage() {
		return message;
	}

	public void setMessage(LessonMessage message) {
		this.message = message;
	}

	public User getRecipient() {
		return recipient;
	}

	public void setRecipient(User recipient) {
		this.recipient = recipient;
	}

	public MessageStatus getStatus() {
		return status;
	}

	public void setStatus(MessageStatus status) {
		this.status = status;
	}
    
}