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

import com.ekingstar.eams.system.security.EamsUserCategory;
import com.ekingstar.eams.teacher.Teacher;
import com.ekingstar.eams.web.action.BaseAction;

public class TeacherAction extends BaseAction{
	@Override
	protected String saveAndForward(Entity entity) {
		Teacher teacher = (Teacher) entity;
		createTeacherUser(getUser(),teacher);
		return super.saveAndForward(entity);
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
    public User createTeacherUser(final User creator, final Teacher teacher) {
        if (StringUtils.isEmpty(teacher.getCode())) {
            return null;
        }
        User user = getUser(teacher.getCode());
        if (null != user) {
            entityService.saveOrUpdate(teacher);
            return user;
        }
        User teacherUser = (User) Model.newInstance(User.class);
        teacherUser.setName(teacher.getCode());
        teacherUser.setPassword(EncryptUtil.encode(User.DEFAULT_PASSWORD));
        UserCategory category = new org.beanfuse.security.model.UserCategory(
                EamsUserCategory.TEACHER_USER);
        teacherUser.setDefaultCategory(category);
        teacherUser.getCategories().add(category);
        teacherUser.setCreatedAt(new Date());
        teacherUser.setUpdatedAt(new Date());
        teacherUser.setStatus(User.ACTIVE);
        teacherUser.setFullname(teacher.getName());
        teacherUser.setCreator(creator);
        String email = null;
        if (StringUtils.isEmpty(email))
            email = "default@unknown.com";
        teacherUser.setMail(email);
        saveOrUpdate(teacherUser);
        return teacherUser;
    }
}
