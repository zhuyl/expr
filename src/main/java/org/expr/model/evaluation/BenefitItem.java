package org.expr.model.evaluation;


import org.expr.model.basecode.FinanceType;

/** 单个产品收益分析项目 */
public interface BenefitItem {

	public FinanceType getFinancetype();

	public void setFinancetype(FinanceType financetype);

	public String getContent();

	public void setContent(String content);

}