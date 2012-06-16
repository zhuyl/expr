package org.expr.web.action;

import org.apache.commons.lang.StringUtils;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.beanfuse.security.User;
import org.expr.model.lesson.Lesson;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.web.action.BaseAction;

public class TeacherLessonAction extends BaseAction {

	public String index() {
		User user = getUser();
		EntityQuery query = new EntityQuery(Lesson.class, "lesson");
		query.join("lesson.teachers", "teacher");
		query.add(new Condition("teacher.code=:teachercode", user.getName()));
		query.add(new Condition("lesson.endAt>=current_date()"));
		put("curLessons", entityService.search(query));

		query = new EntityQuery(Lesson.class, "lesson");
		query.join("lesson.teachers", "teacher");
		query.add(new Condition("teacher.code=:teachercode", user.getName()));
		query.add(new Condition("lesson.endAt<current_date()"));
		put("hisLessons", entityService.search(query));
		return forward();
	}

	public String stdList() {
		Long lesson_id = getLong("lesson.id");
		put("lesson", entityService.get(Lesson.class, lesson_id));
		return forward();
	}

	/**
	 * 添加学生
	 * @return
	 */
	public String addStd() {
		Long lesson_id = getLong("lesson.id");
		String stdNos = get("stdNos");
		if (StringUtils.isEmpty(stdNos)) {
			return null;
		}
		Lesson lesson = (Lesson) entityService.get(Lesson.class, lesson_id);
		lesson.getStudents().addAll(
				entityService.load(Student.class, "code", StringUtils.split(stdNos, ",")));
		saveOrUpdate(lesson);
		return redirect("stdList", "info.save.success");
	}
}
