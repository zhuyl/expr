package org.expr.web.action;

import java.util.List;

import org.beanfuse.lang.SeqStringUtil;
import org.beanfuse.model.Entity;
import org.beanfuse.query.Condition;
import org.beanfuse.query.EntityQuery;
import org.expr.model.lesson.Lesson;
import org.expr.util.StringUtil;

import com.ekingstar.eams.student.Student;
import com.ekingstar.eams.teacher.model.Teacher;
import com.ekingstar.eams.web.action.BaseAction;

public class LessonAction extends BaseAction {

	public String index() {
		put("teachers", (List) entityService.search(new EntityQuery(Teacher.class, "teacher")));
		return forward();
	}

	public String search() throws Exception {
		EntityQuery query = buildQuery();
		String teacherId = get("teacher.id");
		if (null != teacherId && !"".equals(teacherId)) {
			query.join("lesson.teachers", "teacher");
			query.add(new Condition("teacher.id=:teacherId", Long.valueOf(teacherId)));
		}
		put("lessons", entityService.search(query));
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
		put("teachers", (List) entityService.search(new EntityQuery(Teacher.class, "teacher")));
		put(getShortName(), entity);
		return forward();
	}

	protected String saveAndForward(Entity entity) {
		try {
			Lesson lesson = (Lesson) entity;
			String teacherIdString = get("teacher.id");
			lesson.getTeachers().clear();
			saveOrUpdate(lesson);
			Long[] teacherIds = SeqStringUtil.transformToLong(teacherIdString);
			for (int i = 0; i < teacherIds.length; i++) {
				Teacher teacher = (Teacher) entityService.load(Teacher.class, teacherIds[i]);
				if (!lesson.getTeachers().contains(teacher)) {
					lesson.getTeachers().add(teacher);
				}
			}
			saveOrUpdate(lesson);
			return redirect("search", "info.save.success");
		} catch (Exception e) {
			logger.info("saveAndForwad failure for:", e);
		}
		return redirect("search", "info.save.failure");
	}

	public String stdList() {
		Long lessonId=getEntityId("lesson");
		Lesson lesson=(Lesson)entityService.get(Lesson.class,lessonId);
		put("students",lesson.getStudents());
		put("lesson",lesson);
		return forward();
	}
	
	/**
	 * 导入学生表单
	 * FIXME lesson
	 * @return
	 */
	public String importStdForm() {
		Long lessonId=getEntityId("lesson");
		Lesson lesson=(Lesson)entityService.get(Lesson.class,lessonId);
		put("lesson",lesson);
		return forward();
	}
	
	public String importStd() {
		String[]  stdCodes= StringUtil.replaceToComma(get("stdCodes"));
		List<Student> stds=entityService.load(Student.class, "code", stdCodes);
		Lesson lesson=(Lesson)entityService.get(Lesson.class, getLong("lesson.id"));
		lesson.getStudents().addAll(stds);
		entityService.saveOrUpdate(lesson);
		return redirect("stdList","info.action.success");
	}
	
	
	/*
	 * 删除学生
	 */
	
	public String removeStd(){
		Long lessonId=getLong("lesson.id");
		Long[] studentId=SeqStringUtil.transformToLong(get("studentIds"));		
		Lesson lesson=(Lesson)entityService.get(Lesson.class,lessonId);
		List<Student> students=entityService.load(Student.class,"id",studentId);
		lesson.getStudents().removeAll(students);
		entityService.saveOrUpdate(lesson);		
		return redirect("stdList","info.action.success");
	}
}
