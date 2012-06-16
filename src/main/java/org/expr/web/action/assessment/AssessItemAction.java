package org.expr.web.action.assessment;

import java.util.List;

import org.beanfuse.model.Entity;
import org.beanfuse.query.EntityQuery;
import org.expr.model.assessment.AssessItem;
import org.expr.model.assessment.Assessment;
import org.expr.model.basecode.Analysis;

import com.ekingstar.eams.web.action.BaseAction;


public class AssessItemAction extends BaseAction {

	public String index() {
		return forward();
	}
	
	public String search() throws Exception {
		String assessmentId = get("assessment.id");
		Assessment assessment = (Assessment) entityService.load(Assessment.class, Long.valueOf(assessmentId));
		put("assessment",assessment);
		put("assessItems",assessment.getItems());
		return forward();
	}
	
	protected void editSetting(Entity entity) {
		put("analysisTables", (List) entityService.search(new EntityQuery(Analysis.class,
				"analysistable")));
	}
	
	protected String saveAndForward(Entity entity) {
		AssessItem  assessItem= (AssessItem) populateEntity(AssessItem.class, "assessItem");
		Long assessmentId = getLong("assessment.id");
		Assessment assessment = (Assessment) entityService.get(Assessment.class,
				assessmentId);
		assessItem.setAssessment(assessment);
		entityService.saveOrUpdate(assessItem);
		return redirect("search", "info.save.success", "&assessment.id=" + assessmentId);
	}
	
    public String remove() {
		Long assessmentId = getLong("assessment.id");
		try {
			super.remove();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return redirect("search", "info.delete.success", "&assessment.id=" + assessmentId);
        
    }
}