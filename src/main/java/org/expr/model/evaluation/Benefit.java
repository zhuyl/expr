package org.expr.model.evaluation;

import java.util.Set;

public interface Benefit {

	public Set<BenefitItem> getItems();

	public void setItems(Set<BenefitItem> items);
}