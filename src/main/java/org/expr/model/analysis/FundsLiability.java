package org.expr.model.analysis;

import org.beanfuse.model.Component;
import org.expr.model.basecode.LiabilityProject;

/**
 * 负债表
 * 
 * @author Administrator
 * 
 */
public class FundsLiability implements Component {
    
    /** 负债项目 */
    private LiabilityProject liabilityProject;
    
    /** 负债金额 */
    private Float amount;

    
    public Float getAmount() {
        return amount;
    }

    
    public void setAmount(Float amount) {
        this.amount = amount;
    }

    
    public LiabilityProject getLiabilityProject() {
        return liabilityProject;
    }

    
    public void setLiabilityProject(LiabilityProject liabilityProject) {
        this.liabilityProject = liabilityProject;
    }

}