package org.expr.model.lesson;

import org.beanfuse.model.pojo.LongIdObject;
import org.expr.model.basecode.Analysis;

/**
 * 实验中各分析表分数分布
 * 
 * @author Administrator
 * 
 */
public class ExperimentMark extends LongIdObject {

	private Experiment experiment;
	
	private Analysis analysis;
	
	private Float mark;

	public Experiment getExperiment() {
		return experiment;
	}

	public void setExperiment(Experiment experiment) {
		this.experiment = experiment;
	}

	public Analysis getAnalysis() {
		return analysis;
	}

	public void setAnalysis(Analysis analysis) {
		this.analysis = analysis;
	}

	public Float getMark() {
		return mark;
	}

	public void setMark(Float mark) {
		this.mark = mark;
	}
	
}
