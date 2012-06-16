package org.expr.web.action;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.entity.Model;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.User;
import org.beanfuse.security.UserCategory;
import org.beanfuse.security.codec.EncryptUtil;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.system.security.EamsUserCategory;
import com.ekingstar.eams.web.action.BaseAction;

public class StudentAction extends BaseAction {

	@Override
	protected String saveAndForward(Entity entity) {
		Student std = (Student) entity;
		if (std.isVO())
			std.setCreatedAt(new Date());
		std.setUpdatedAt(new Date());
		saveOrUpdate(std);
		createStdUser(getUser(), std);
		return redirect("search", "info.save.success");
	}

	private User getUser(String name) {
		EntityQuery query = new EntityQuery(User.class, "user");
		query.add(new Condition("user.name=:name", name));
		List<User> users = entityService.search(query);
		if (users.isEmpty()) {
			return null;
		} else {
			return users.get(0);
		}
	}

	public User createStdUser(User creator, Student std) {
		User user = getUser(std.getCode());
		if (null != user) {
			return user;
		}
		User stdUser = (User) Model.newInstance(User.class);
		stdUser.setName(std.getCode());
		stdUser.setPassword(EncryptUtil.encode(User.DEFAULT_PASSWORD));
		UserCategory category = new org.beanfuse.security.model.UserCategory(
				EamsUserCategory.STD_USER);
		stdUser.setDefaultCategory(category);
		stdUser.getCategories().add(category);
		stdUser.setStatus(User.ACTIVE);
		stdUser.setCreator(creator);
		stdUser.setCreatedAt(new Date());
		stdUser.setUpdatedAt(new Date());
		stdUser.setFullname(std.getName());
		String email = null;// std.getBasicInfo().getMail();
		if (StringUtils.isEmpty(email))
			email = "default@unknown.com";
		stdUser.setMail(email);
		saveOrUpdate(stdUser);
		return stdUser;
	}
}
