package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 理财分析类型表
 * 
 * @author Administrator
 * 
 */
public class Analysis extends   BaseCode {
    
    /** 分析表描述 */
    private String description;
    
    /** 分析表类型 */
    private String type;
    
    /** 分析阶段 */
    private AnalysisPhase phase;
    
    public AnalysisPhase getPhase() {
        return phase;
    }

    
    public void setPhase(AnalysisPhase analysisPhase) {
        this.phase = analysisPhase;
    }

    
    public String getDescription() {
        return description;
    }

    
    public void setDescription(String description) {
        this.description = description;
    }

	public String getType() {
        return type;
    }

    
    public void setType(String type) {
        this.type = type;
    }
    
}