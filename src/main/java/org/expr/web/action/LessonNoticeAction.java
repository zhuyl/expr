package org.expr.web.action;


import java.sql.Date;
import java.util.Iterator;
import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.predicates.ValidEntityKeyPredicate;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Lesson;
import org.expr.model.lessonNotice.LessonNotice;

import com.ekingstar.eams.web.action.BaseAction;

public class LessonNoticeAction extends BaseAction {

	public String list()
	{
		Long lessonid = getLong("lesson.id");
		put("lesson", entityService.get(Lesson.class, lessonid));
		
		EntityQuery query = new EntityQuery(LessonNotice.class, "m");
		query.add(new Condition("m.lesson.id=:lessonid", lessonid));		
        query.setLimit(getPageLimit());
        query.addOrder(Order.parse(get("orderBy")));
        put("lessonNotices", entityService.search(query));		
		return forward();
	}

	
    public String edit() {
    	Long lessonid = getLong("lesson.id"); 
		put("lesson", entityService.get(Lesson.class, lessonid));
        Long noticeId = getLong("lessonNoticeId");
       LessonNotice notice = null;
        if (!ValidEntityKeyPredicate.INSTANCE.evaluate(noticeId)) {
        	notice=new LessonNotice();
        }
        else
        {
            notice = (LessonNotice) entityService.get(LessonNotice.class, noticeId);

        }
        put("notice", notice);
        return forward();
    }
    
    
    public String save() {
        LessonNotice notice = (LessonNotice) this.populateEntity(LessonNotice.class,"lessonNotice");
		Long lessonid = getLong("lesson.id");
        Lesson lesson=(Lesson)entityService.get(Lesson.class, lessonid);
        if (notice.isPO()) {
            LessonNotice saved = (LessonNotice) entityService.get(LessonNotice.class, notice.getId());
            saved.setContent(notice.getContent());
            saved.setTitle(notice.getTitle());
            saved.setUpdatedAt(new Date(System.currentTimeMillis()));           
            saved.setPublisher(getUser());
            saved.setLesson(lesson);
            notice = saved;
        } else {
            LessonNotice newNotice = new LessonNotice();
            newNotice.setContent(notice.getContent());
            newNotice.setTitle(notice.getTitle());
            newNotice.setUpdatedAt(new Date(System.currentTimeMillis()));
            newNotice.setPublisher(getUser());
            newNotice.setLesson(lesson);
            notice = newNotice;
            
        }
        entityService.saveOrUpdate(notice);

        return redirect("search", "info.save.success","&lesson.id="+lessonid);
    }
    
    public String info() {
        Long noticeId = getLong("notice.id");
        if (!ValidEntityKeyPredicate.INSTANCE.evaluate(noticeId)) {
            return forwardError("error.parameters.illegal");
        } else {
            LessonNotice notice = (LessonNotice) entityService.get(LessonNotice.class, noticeId);
            put("notice", notice);
            return forward();
        }
    }
    
    public String remove() {
		Long lessonid = getLong("lesson.id");
        String noticeIds = get("lessonNoticeIds");
        List notices = entityService.load(LessonNotice.class, "id", SeqStringUtil
                .transformToLong(noticeIds));
        for (Iterator iter = notices.iterator(); iter.hasNext();) {
            LessonNotice notice = (LessonNotice) iter.next();
            entityService.remove(notice);
        }
        return redirect("search", "info.delete.success", "&lesson.id=" + lessonid);
        
    }
    
	public String stdNoticeList()
	{
		Long lessonid = getLong("lesson.id");
		put("lesson", entityService.get(Lesson.class, lessonid));
		
		EntityQuery query = new EntityQuery(LessonNotice.class, "m");
		query.add(new Condition("m.lesson.id=:lessonid", lessonid));		
        query.setLimit(getPageLimit());
        query.addOrder(Order.parse(get("orderBy")));
        put("lessonNotices", entityService.search(query));		
		return forward();
	}
}
