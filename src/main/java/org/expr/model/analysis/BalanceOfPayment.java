package org.expr.model.analysis;

import java.util.HashSet;
import java.util.Set;

/**
 * 月度收支分析表
 * 
 * @author Administrator
 * 
 */
public class BalanceOfPayment implements AnalysisForm {

	/** 总收入 */
	private Float totalIncome;

	/** 总支出 */
	private Float totalExpend;

	/** 总结余 */
	private Float totalBalance;

	/** 得分 */
	//private Float score;

	/** 收入集合 */
	private Set incomes=new HashSet();

	/** 支出集合 */
	private Set expends=new HashSet();

	public Set getExpends() {
		return expends;
	}

	public void setExpends(Set expends) {
		this.expends = expends;
	}

	public Set getIncomes() {
		return incomes;
	}

	public void setIncomes(Set incomes) {
		this.incomes = incomes;
	}

//	public Float getScore() {
//		return score;
//	}
//
//	public void setScore(Float score) {
//		this.score = score;
//	}

	public Float getTotalBalance() {
		return totalBalance;
	}

	public void setTotalBalance(Float totalBalance) {
		this.totalBalance = totalBalance;
	}

	public Float getTotalExpend() {
		return totalExpend;
	}

	public void setTotalExpend(Float totalExpend) {
		this.totalExpend = totalExpend;
	}

	public Float getTotalIncome() {
		return totalIncome;
	}

	public void setTotalIncome(Float totalIncome) {
		this.totalIncome = totalIncome;
	}

}