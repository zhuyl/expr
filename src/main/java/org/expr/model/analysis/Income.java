package org.expr.model.analysis;

import org.beanfuse.model.Component;
import org.expr.model.basecode.IncomeProject;

/**
 * 收入表
 * 
 * @author Administrator
 * 
 */
public class Income implements Component {

    /** 收入项目 */
    private IncomeProject incomeProject;

    /** 收入金额 */
    private Float amount;

    
    public Float getAmount() {
        return amount;
    }

    
    public void setAmount(Float amount) {
        this.amount = amount;
    }


    public IncomeProject getIncomeProject() {
        return incomeProject;
    }

    
    public void setIncomeProject(IncomeProject incomeProject) {
        this.incomeProject = incomeProject;
    }
    
}