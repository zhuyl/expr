package org.expr.web.action;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.User;
import org.expr.model.basecode.MessageStatus;
import org.expr.model.lesson.Lesson;
import org.expr.model.lessonMessage.LessonMessage;
import org.expr.model.lessonMessage.MessageReceiver;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class LessonMessageAction extends BaseAction {
	public String index() {
		put("MessageStatus", entityService.loadAll(MessageStatus.class));
		put("lesson",getLesson());
		return forward();
	}
	
	public String stdindex() {
		put("MessageStatus", entityService.loadAll(MessageStatus.class));
		put("lesson",getLesson());
		return forward();
	}


	public Lesson getLesson() {
		Long lessonid = getLong("lesson.id");
		if (null != lessonid) {
			return (Lesson) entityService.get(Lesson.class, lessonid);
		}
		return null;
	}

	public String newMessage() {
		put("me", getUser());
		return forward();
	}

	public String newStudentMessage() {
		put("me", getUser());
		Long[] studentIds = SeqStringUtil.transformToLong(get("studentId"));
		String studentCodes="";
		if (null != studentIds) {
			for (int i = 0; i < studentIds.length; i++) {
				 Student student=(Student)entityService.load(Student.class, studentIds[i]);
				 studentCodes=studentCodes+student.getCode()+",";
			}
			}
		put("studentNames",studentCodes);
		return forward();
	}
	
	public String userList() {
		return forward();
	}

	protected EntityQuery buildQuery() {
		EntityQuery query = new EntityQuery(getEntityName(), getShortName());
		query.add(Condition.eq("messageReceiver.message.lesson.id", getLong("lesson.id")));
		populateConditions(query, "messageReceiver.message.createdAt");
		Date sendOn = getDate("messageReceiver.message.createdAt");
		if (null != sendOn) {
			query.add(new Condition("messageReceiver.message.createdAt>=:startDate", sendOn));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(sendOn);
			calendar.roll(Calendar.DAY_OF_WEEK, 1);
			query.add(new Condition("messageReceiver.message.createdAt<:endDate", calendar
					.getTime()));
		}
		query.addOrder(Order.parse(get("orderBy")));

		query.setLimit(getPageLimit());
		return query;
	}

	public String newly() {
		EntityQuery query = buildQuery();
		query.add(Condition.eq("messageReceiver.status.id", MessageStatus.NEWLY));
		query.add(Condition.eq("messageReceiver.recipient.id", getUserId()));
		put("messageReceivers", entityService.search(query));
		return forward();
	}

	public String readed() {
		EntityQuery query = buildQuery();
		query.add(Condition.eq("messageReceiver.status.id", MessageStatus.READED)).add(
				Condition.eq("messageReceiver.recipient.id", getUserId()));
		put("messageReceivers", entityService.search(query));
		return forward();
	}

	public String sendbox() {
		EntityQuery query = buildQuery();
		query.add(Condition.eq("messageReceiver.message.sender.id", getUserId()));
		put("messageReceivers", entityService.search(query));
		return forward();
	}

	public String sendTo() {
		String receiptorIds = get("receiptorIds");
		if (StringUtils.isEmpty(receiptorIds))
			return forwardError("error.parameters.needed");
		List recipients = entityService.load(User.class, "name", StringUtils.split(receiptorIds,
				","));
		LessonMessage message = (LessonMessage) populate(LessonMessage.class, "message");
		message.setCreatedAt(new Date(System.currentTimeMillis()));
		message.setSender(getUser());
		Long lessonId = getLong("lesson.id");
		message.setLesson((Lesson) entityService.get(Lesson.class, lessonId));
		sendMessage(message, recipients);
		if (StringUtils.isNotEmpty(get("quickSend"))) {
			// 提示成功信息
			addActionMessage(getText("info.send.success"));
			return ("actionResult");
		} else {
			return redirect("sendbox", "info.send.success");
		}
	}

	public String sendToStudent() {
		String receiptorIds = get("receiptorNames");
		if (StringUtils.isEmpty(receiptorIds))
			return forwardError("error.parameters.needed");
		List recipients = entityService.load(User.class, "name", StringUtils.split(receiptorIds,
				","));
		LessonMessage message = (LessonMessage) populate(LessonMessage.class, "message");
		message.setCreatedAt(new Date(System.currentTimeMillis()));
		message.setSender(getUser());
		Long lessonId = getLong("lesson.id");
		message.setLesson((Lesson) entityService.get(Lesson.class, lessonId));
		sendMessage(message, recipients);
		if (StringUtils.isNotEmpty(get("quickSend"))) {
			// 提示成功信息
			addActionMessage(getText("info.send.success"));
			return ("actionResult");
		} else {
			return redirect("sendbox", "info.send.success");
		}
	}
	/**
	 * 消息详细信息
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return @
	 */
	public String info() {
		Long entityId = getEntityId(getShortName());
		if (null == entityId) {
			logger.warn("cannot get paremeter {}Id or {}.id", getShortName(), getShortName());
		}
		MessageReceiver receiver = (MessageReceiver) getModel(getEntityName(), entityId);
		put(getShortName(), receiver);
		if (receiver.getRecipient().equals(getUser())) {
			receiver.setStatus(new MessageStatus(MessageStatus.READED));
			entityService.saveOrUpdate(receiver);
		}
		return forward();
	}

	public void sendMessage(LessonMessage message, List<User> receiptors) {
		entityService.saveOrUpdate(message);
		for (User user : receiptors) {
			MessageReceiver receiver = new MessageReceiver();
			receiver.setRecipient(user);
			receiver.setStatus(new MessageStatus(MessageStatus.NEWLY));
			receiver.setMessage(message);
			entityService.saveOrUpdate(receiver);
		}
	}

}