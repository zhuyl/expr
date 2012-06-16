package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 资产项目
 * 
 * @author Administrator
 * 
 */
public class AssetProject extends BaseCode {
    
    /** 上级项目 */
    private AssetProject parent;

    
    public AssetProject getParent() {
        return parent;
    }

    
    public void setParent(AssetProject parent) {
        this.parent = parent;
    }
    
}