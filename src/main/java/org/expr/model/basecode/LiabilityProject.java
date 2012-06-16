package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 负债项目
 * 
 * @author Administrator
 * 
 */
public class LiabilityProject extends BaseCode {
    
    /** 上级项目 */
    private LiabilityProject parent;

    
    public LiabilityProject getParent() {
        return parent;
    }

    
    public void setParent(LiabilityProject parent) {
        this.parent = parent;
    }
    
}