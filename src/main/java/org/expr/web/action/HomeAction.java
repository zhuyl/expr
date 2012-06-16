package org.expr.web.action;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.beanfuse.collection.page.PageLimit;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.Authentication;
import org.beanfuse.security.User;
import org.beanfuse.security.UserCategory;
import org.beanfuse.security.menu.MenuProfile;
import org.beanfuse.security.menu.service.MenuAuthorityService;
import org.beanfuse.security.monitor.SecurityMonitor;
import org.beanfuse.text.Message;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.basecode.FinanceProductCategory;
import org.expr.model.basecode.FinanceToolCategory;
import org.expr.model.basecode.LifeCycleType;
import org.expr.model.lesson.Lesson;

import com.ekingstar.eams.system.security.EamsUserCategory;
import com.ekingstar.eams.web.action.BaseAction;
import com.opensymphony.xwork2.ActionContext;

public class HomeAction extends BaseAction {

	SecurityMonitor securityMonitor;
	MenuAuthorityService menuAuthorityService;

	public String index() throws Exception {
		
		addBaseCode("financeToolCategories", FinanceToolCategory.class);
		addBaseCode("financeProductCategories", FinanceProductCategory.class);
		//客户风险态度问卷
		EntityQuery query = new EntityQuery(Questionnaire.class,"questionnaire");
		query.add(new Condition("questionnaire.type.code=:code", "01"));
		query.setLimit(new PageLimit(1,3));//每页三条，取第一页。
		put("questionnaires", entityService.search(query));
		
		User user = getUser();
		put("user", user);
		if (getUserCategoryId().equals(EamsUserCategory.MANAGER_USER)) {
			Long categoryId = getLong(Authentication.USER_CATEGORYID);
			Long curCategoryId = (Long) ActionContext.getContext().getSession()
					.get(Authentication.USER_CATEGORYID);
			if (null == categoryId) {
				categoryId = curCategoryId;
			}
			if (!categoryId.equals(curCategoryId)) {
				UserCategory category = (UserCategory) entityService.get(
						UserCategory.class, categoryId);
				securityMonitor.getSessionController().changeCategory(
						ServletActionContext.getRequest().getSession().getId(),
						category);
				ActionContext.getContext().getSession().put(
						Authentication.USER_CATEGORYID, categoryId);
			}
			// List dd =
			// menuAuthorityService.getMenus(getMenuProfile(categoryId), user,
			// 1, "");
			put("menus", new ArrayList());
			put("user", user);
			put("categories", user.getCategories());
			return forward("adminindex");
		}
		if (getUserCategoryId().equals(EamsUserCategory.TEACHER_USER)) {
			addBaseCode("lifeCycleTypes", LifeCycleType.class);
			put("messages", (List) entityService.search(new EntityQuery(
					Message.class, "message")));
			put("curLessons", (List) entityService.search(new EntityQuery(
					Lesson.class, "lesson")));
			put("hisLessons", (List) entityService.search(new EntityQuery(
					Lesson.class, "lesson")));
			return forward("teacherindex");
		} else {
			addBaseCode("lifeCycleTypes", LifeCycleType.class);
			put("messages", (List) entityService.search(new EntityQuery(
					Message.class, "message")));
			put("curLessons", (List) entityService.search(new EntityQuery(
					Lesson.class, "lesson")));
			put("hisLessons", (List) entityService.search(new EntityQuery(
					Lesson.class, "lesson")));
		}

		return forward();
	}

	public String experiment() {
		addBaseCode("financeToolCategories", FinanceToolCategory.class);
		addBaseCode("financeProductCategories", FinanceProductCategory.class);
		User user = getUser();
		put("user", user);
		put("messages", (List) entityService.search(new EntityQuery(
				Message.class, "message")));
		put("curLessons", (List) entityService.search(new EntityQuery(
				Lesson.class, "lesson")));
		put("hisLessons", (List) entityService.search(new EntityQuery(
				Lesson.class, "lesson")));
		return forward();
	}

	public String moduleList() {
		Long curCategory = (Long) ActionContext.getContext().getSession().get(
				Authentication.USER_CATEGORYID);
		List modulesTree = menuAuthorityService.getMenus(
				getMenuProfile(curCategory), getUser(), -1, get("parentCode"));
		put("moduleTree", modulesTree);
		return forward();
	}

	public String welcome() {
		put("date", new Date(System.currentTimeMillis()));
		return forward();
	}

	protected MenuProfile getMenuProfile(Long categoryId) {
		EntityQuery query = new EntityQuery(MenuProfile.class, "mp");
		query.add(new Condition("category.id=:categoryId", categoryId));
		query.setCacheable(true);
		List mps = (List) entityService.search(query);
		if (mps.isEmpty()) {
			return null;
		} else {
			return (MenuProfile) mps.get(0);
		}
	}

	public void setSecurityMonitor(SecurityMonitor securityMonitor) {
		this.securityMonitor = securityMonitor;
	}

	public void setMenuAuthorityService(
			MenuAuthorityService menuAuthorityService) {
		this.menuAuthorityService = menuAuthorityService;
	}

	public String curriculumList() {
		put("messages", (List) entityService.search(new EntityQuery(Message.class, "message")));
		put("curLessons", (List) entityService.search(new EntityQuery(Lesson.class, "lesson")));
		put("hisLessons", (List) entityService.search(new EntityQuery(Lesson.class, "lesson")));
		
		User user = getUser();
		EntityQuery query = new EntityQuery(Lesson.class, "lesson");
		query.join("lesson.students", "student");
		query.add(new Condition("student.code=:studentcode", user.getName()));
		query.add(new Condition("lesson.endAt>=current_date()"));
		put("curLessons", entityService.search(query));

		EntityQuery hisquery = new EntityQuery(Lesson.class, "lesson");
		hisquery.join("lesson.students", "student");
		hisquery.add(new Condition("student.code=:studentcode", user.getName()));
		hisquery.add(new Condition("lesson.endAt<current_date()"));
		put("hisLessons", entityService.search(hisquery));
		return forward();
	}

}
