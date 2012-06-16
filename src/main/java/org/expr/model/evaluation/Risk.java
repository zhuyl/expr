package org.expr.model.evaluation;

import java.util.Set;

public interface Risk {

	public Set<RiskItem> getItems();

	public void setItems(Set<RiskItem> items);
}