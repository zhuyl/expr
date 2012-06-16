package org.expr.model.analysis;

import org.beanfuse.model.Component;
import org.expr.model.basecode.AssetProject;

/**
 * 资产表
 * 
 * @author Administrator
 * 
 */
public class FundsAsset implements Component {

    /** 资产项目 */
    private AssetProject assetProject;

    /** 资产金额 */
    private Float amount;
    
    
    public Float getAmount() {
        return amount;
    }

    
    public void setAmount(Float amount) {
        this.amount = amount;
    }


    public AssetProject getAssetProject() {
        return assetProject;
    }

    
    public void setAssetProject(AssetProject assetProject) {
        this.assetProject = assetProject;
    }

}