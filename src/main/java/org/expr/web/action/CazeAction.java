package org.expr.web.action;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;

import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.Caze;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.basecode.LifeCycleType;
import org.expr.model.basecode.RiskBearAttitude;

import com.ekingstar.eams.web.action.BaseAction;

public class CazeAction extends BaseAction {

	public String index() {
		addBaseCode("lifeCycleTypes", LifeCycleType.class);
		return forward();
	}
	public String cazeQuery() {
		addBaseCode("lifeCycleTypes", LifeCycleType.class);
		return forward();
	}
	
	public String cazeQueryList() {
		EntityQuery query=new EntityQuery(Caze.class, "caze");
		query.setLimit(getPageLimit());
		put("cazes", entityService.search(query));
		return forward();
	}
	
	protected void editSetting(Entity entity) {
		addBaseCode("lifeCycleTypes", LifeCycleType.class);
		addBaseCode("riskBearAttitudes", RiskBearAttitude.class);
		//put("questionnaires", entityService.search(new EntityQuery(Questionnaire.class, "questionnaire")));		
		EntityQuery query = new EntityQuery(Questionnaire.class,"questionnaire");
		query.add(new Condition("questionnaire.type.code=:code", "02"));
		put("questionnaires", entityService.search(query));
	
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
           /***String[] analysisIds=getValues("analysisId");
            caze.getAnalysis().clear();
          for (int i = 0; i < analysisIds.length; i++) {
				String analysisId = analysisIds[i];
				caze.getAnalysis().add(entityService.get(Analysis.class, Long.valueOf(analysisId)));
			}
           System.out.println(analysisIds[0]+"====================");
           System.out.println(caze.getAnalysis().size()+"====================");*/
            saveOrUpdate(caze);
            return redirect("search", "info.save.success");
        }
        catch(Exception e)
        {
            logger.info("saveAndForwad failure for:" ,e);
        }
        return redirect("search", "info.save.failure");
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
    
    protected String removeAndForward(Collection entities)
    {
        try
        {
            remove(entities);
        }
        catch(Exception e)
        {
            logger.info("removeAndForwad failure for:" + e.getMessage());
            return redirect("search", "info.delete.failure");
        }
        return redirect("search", "info.delete.success");
    }

    public String cazeDetail(){ 
 	   Long cazeId = getLong("cazeId");
	   put("caze",(Caze)entityService.load(Caze.class, cazeId));
 	   return forward();
    } 

	public String familyAnalysis(){

	    return forward();
	}

	public String familyInfo(){

	    return forward();
	}	


	

	
	
	
	public String insuranceDetail(){

	    return forward();
	}	

	public String riskCapacity(){

	    return forward();
	}
	public String clientAnalysis(){

	    return forward();
	}
	public String aimAnalysis(){

	    return forward();
	}
	public String cashPlan(){

	    return forward();
	}
	public String expensePlan(){

	    return forward();
	}
	public String educationPlan(){

	    return forward();
	}
	public String insurancePlan(){

	    return forward();
	}
	public String taxPlan(){

	    return forward();
	}
	public String retirementPlan(){

	    return forward();
	}
	public String investmentPlan(){

	    return forward();
	}
	public String inheritancePlan(){

	    return forward();
	}
	public String housePlan(){

	    return forward();
	}
	public String comprehensivePlan(){

	    return forward();
	}
	public String dynamicBalance(){

	    return forward();
	}
	public String schemeEvaluation(){

	    return forward();
	}
}
