package org.expr.model.basecode;

import com.ekingstar.eams.basecode.BaseCode;

/**
 * 理财目标类型
 * 
 * @author Administrator
 * 
 */
public class MessageStatus extends BaseCode {

	public final static Long NEWLY=new Long(2);

	public final static Long READED=new Long(1);

	public MessageStatus() {
		super();
	}

	public MessageStatus(Long id) {
		super(id);
	}
	
    
}