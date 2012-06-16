package org.expr.model.aim.result;

import java.util.Set;

import org.expr.model.aim.Aim;
import org.expr.model.aim.AimItem;
import org.expr.model.analysis.AbstractResult;

public class AimResult extends AbstractResult implements Aim {

	protected Set<AimItem> items;

	public Set<AimItem> getItems() {
		return items;
	}

	public void setItems(Set<AimItem> items) {
		this.items = items;
	}
	


}