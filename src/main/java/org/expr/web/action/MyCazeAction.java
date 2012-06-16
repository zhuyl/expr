package org.expr.web.action;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.beanfuse.collection.Order;
import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.User;
import org.beanfuse.struts2.route.Action;
import org.expr.model.Caze;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.basecode.LifeCycleType;
import org.expr.model.basecode.RiskBearAttitude;
import org.expr.model.lesson.StudyLog;

public class MyCazeAction extends CazeAction {

	public String search() throws Exception {
		put("me", getUser());
		EntityQuery query=new EntityQuery(Caze.class,"caze");
		query.add(new Condition("caze.author=:tdName", getUser().getName()));
		populateConditions(query);
		query.addOrder(Order.asc("caze.seq"));
		query.setLimit(getPageLimit());
		List cazes=(List)entityService.search(query);
		put("cazes",cazes);
		addBaseCode("lifeCycleTypes", LifeCycleType.class);
		return forward();
	}

	public String edit() throws Exception {
		Long entityId = getEntityId(getShortName());
		Entity entity = null;
		if (null == entityId) {
			entity = populateEntity();
		} else {
			entity = getModel(getEntityName(), entityId);
		}

		Caze caze = (Caze) entity;

		User me = getUser();
		if (caze.isSaved()&&!caze.getAuthor().equals(me.getName())) {
			return redirect(new Action(MyCazeAction.class,"search"), "info.action.failure");
		} else {
			addBaseCode("lifeCycleTypes", LifeCycleType.class);
			addBaseCode("riskBearAttitudes", RiskBearAttitude.class);		
			EntityQuery query = new EntityQuery(Questionnaire.class,"questionnaire");
			query.add(new Condition("questionnaire.type.code=:code", "02"));
			put("questionnaires", entityService.search(query));
			put(getShortName(), entity);
			caze.setAuthor(me.getName());
			return forward();
		}
	}
    public String remove() throws Exception {
        Long entityId = getEntityId(getShortName());
        Collection entities = null;
        if (null == entityId) {
            String entityIdSeq = get(getShortName() + "Ids");
            entities = getModels(entityName, SeqStringUtil.transformToLong(entityIdSeq));
        } else {
            Entity entity = getModel(entityName, entityId);
            entities = Collections.singletonList(entity);
        }
        return removeAndForward(entities);
    }
    
	
	
    protected String saveAndForward(Entity entity)
    {
        try
        {
            Caze caze = (Caze)entity;
            if (null == entity.getEntityId()) {
                caze.setCreatedAt(new Date(System.currentTimeMillis()));
                caze.setUpdatedAt(new Date(System.currentTimeMillis()));
            } else {
                caze.setUpdatedAt(new Date(System.currentTimeMillis()));
            }
            saveOrUpdate(caze);
            return redirect("search", "info.save.success");
        }
        catch(Exception e)
        {
            logger.info("saveAndForwad failure for:" ,e);
        }
        return redirect("search", "info.save.failure");
    }

}
