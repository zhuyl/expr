package org.expr.model;

import java.util.Set;

import org.beanfuse.model.pojo.LongIdTimeObject;
import org.expr.model.analysis.Questionnaire;
import org.expr.model.basecode.LifeCycleType;
import org.expr.model.basecode.RiskBearAttitude;

/**
 * 案例
 * 
 * @author Administrator
 * 
 */
public class Caze extends LongIdTimeObject {
    
    /** 案例编号 */
    private String seq;
    
    /** 案例名称 */
    private String name;
    
    /** 案例内容 */
    private String content;
    
    /** 案例作者 */
    private String author;
    
    /** 生命周期类型 */
    private LifeCycleType lifeCycleType;
    
    /** 风险承受能力问卷 */
    private Questionnaire questionnaire;
    
    /** 是否发布 */
    private boolean publish;
    /**是否想学生公开*/
    private boolean open;

	/** 风险承受态度 */
    private RiskBearAttitude riskBearAttitude;
    
    /** 社会经济状态描述 */
    private String socialState;
  
    /** 动态平衡约束条件 */
    private String dynaEquilibrium;
    
    /**动态平衡调整年度*/
    private Integer changeYear;
    
    /** 分析表集合 */
    private Set analysis;
    

	public Integer getChangeYear() {
		return changeYear;
	}

	public void setChangeYear(Integer changeYear) {
		this.changeYear = changeYear;
	}

	public Questionnaire getQuestionnaire() {
		return questionnaire;
	}

	public void setQuestionnaire(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}
    
	public Set getAnalysis() {
        return analysis;
    }
    
    public void setAnalysis(Set analysis) {
        this.analysis = analysis;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }

    
    public String getContent() {
        return content;
    }

    
    public void setContent(String content) {
        this.content = content;
    }

	public String getDynaEquilibrium() {
        return dynaEquilibrium;
    }

    
    public void setDynaEquilibrium(String dynaEquilibrium) {
        this.dynaEquilibrium = dynaEquilibrium;
    }

    
    public LifeCycleType getLifeCycleType() {
        return lifeCycleType;
    }

    
    public void setLifeCycleType(LifeCycleType lifeCycleType) {
        this.lifeCycleType = lifeCycleType;
    }

    public String getName() {
        return name;
    }

    
    public void setName(String name) {
        this.name = name;
    }

    
    public String getSocialState() {
		return socialState;
	}

	public void setSocialState(String socialState) {
		this.socialState = socialState;
	}

	public boolean isPublish() {
        return publish;
    }

    
    public void setPublish(boolean publish) {
        this.publish = publish;
    }

    
    public RiskBearAttitude getRiskBearAttitude() {
        return riskBearAttitude;
    }

    
    public void setRiskBearAttitude(RiskBearAttitude riskBearAttitude) {
        this.riskBearAttitude = riskBearAttitude;
    }

    
    public String getSeq() {
        return seq;
    }

    
    public void setSeq(String seq) {
        this.seq = seq;
    }

}