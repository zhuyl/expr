package org.expr.model.aim;

import org.expr.model.basecode.AimType;

/** 目标项目 */
public interface AimItem {

	public AimType getAimtype();

	public void setAimtype(AimType aimtype);

	public String getContent();

	public void setContent(String content);

}