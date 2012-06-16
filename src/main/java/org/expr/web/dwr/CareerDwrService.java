package org.expr.web.dwr;

import java.util.List;

import org.beanfuse.persist.impl.BaseServiceImpl;

public class CareerDwrService extends BaseServiceImpl {

	public List getChildren(Long parentId) {
		String hql = "select c.id,c.name from Career c where c.parent.id=" + parentId;
		return entityService.searchHQLQuery(hql);
	}
}
