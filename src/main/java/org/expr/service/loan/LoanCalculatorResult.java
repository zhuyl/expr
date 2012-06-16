package org.expr.service.loan;

import java.math.BigDecimal;

import org.expr.model.plan.result.LoanPayed;

public final class LoanCalculatorResult {
	/**
	 * 等额本息(利随本清法)<br>
	 * Average Capital plus Interest Method
	 * 
	 * <pre>
	 * 每月还款额=贷款本金/贷款期月数+（本金-已归还本金累计额）×月利率
	 * </pre>
	 * 
	 * @param capital
	 * @param month
	 * @param rate
	 * @return
	 */
	public static final LoanPayed[] averageCapitalInterest(double capital, int month, double rate) {
		double a = Math.pow(1 + rate, month);
		double pay = capital * rate * a / (a - 1);

		BigDecimal payPerMonth = new BigDecimal(Math.round(pay * 100)).divide(new BigDecimal(100));
		LoanPayed[] pays = new LoanPayed[month];
		BigDecimal Rate = new BigDecimal(rate);
		BigDecimal Capital = new BigDecimal(capital);
		for (int i = 0; i < month; i++) {
			LoanPayed payed = new LoanPayed();
			pays[i] = payed;
			BigDecimal interest = reserve2(Capital.multiply(Rate));
			payed.setInterest(interest);
			// 应付本金不得超过剩余本金
			BigDecimal payCapital = payPerMonth.subtract(interest);
			if (payCapital.compareTo(Capital) > 0) {
				payCapital = Capital;
			}
			payed.setCapital(payCapital);
			Capital = Capital.subtract(payCapital);
		}
		return pays;
	}

	/**
	 * 等额本金<br>
	 * Average Capital Method
	 * 
	 * <pre>
	 * 即贷款期每月以相等的额度平均偿还贷款本息，每月还款计算公式为： 
	 * 每月还款额=贷款本金×月利率×（1+月利率）还款月数/[（1+月利率）还款月数-1]
	 * </pre>
	 * 
	 * @param capital
	 * @param month
	 * @param rate
	 * @return
	 */
	public static final LoanPayed[] averageCapital(double capital, int month, double rate) {
		BigDecimal Capital = new BigDecimal(capital);
		BigDecimal Rate = new BigDecimal(rate);
		BigDecimal monthCaptical = reserve2(new BigDecimal(capital * 1.0 / month));

		BigDecimal payed = new BigDecimal(0);
		LoanPayed[] pays = new LoanPayed[month];
		for (int i = 0; i < month; i++) {
			BigDecimal interst = reserve2(Capital.subtract(payed).multiply(Rate));
			if (i == month - 1) {
				pays[i] = new LoanPayed(Capital.subtract(payed), interst);
			} else {
				pays[i] = new LoanPayed(monthCaptical, interst);
			}
			payed = payed.add(monthCaptical);
		}
		return pays;
	}

	public static BigDecimal reserve2(BigDecimal num) {
		return new BigDecimal(num.multiply(new BigDecimal(100)).intValue()).divide(new BigDecimal(
				100));
	}
}
