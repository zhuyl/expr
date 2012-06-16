package org.expr.model.analysis;

import org.beanfuse.model.Component;
import org.expr.model.basecode.ExpendProject;

/**
 * 支出表
 * 
 * @author Administrator
 * 
 */
public class Expend implements Component {
    
    /** 支出项目 */
    private ExpendProject expendProject;
    
    /** 支出金额 */
    private Float amount;

    
    public Float getAmount() {
        return amount;
    }

    
    public void setAmount(Float amount) {
        this.amount = amount;
    }

    
    public ExpendProject getExpendProject() {
        return expendProject;
    }

    
    public void setExpendProject(ExpendProject expendProject) {
        this.expendProject = expendProject;
    }

}