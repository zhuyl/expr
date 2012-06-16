/**
* Expr System 
*/
package org.expr.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;

/**
 * Administrator 
 * Id:StringUtil.java 2010-10-30 下午12:20:05
 */
public class StringUtil {
	
	public static String[] replaceToComma(String target){
		if(StringUtils.isBlank(target)){
			return new String[0];
		}
		target=StringUtils.replaceChars(target, ';', ',');
		target=StringUtils.replaceChars(target, ' ', ',');
		target=StringUtils.replaceChars(target, '\n', ',');
		target=StringUtils.replaceChars(target, '\t', ',');
		target=StringUtils.replaceChars(target, '\r', ',');
		String [] targets=StringUtils.split(target, ',');
		List<String> list=new  ArrayList<String>();
		for(String one:targets){
			if(StringUtils.isNotBlank(one)){
				list.add(one.trim());
			}
		}
		String [] rs=new String[list.size()];
		list.toArray(rs);
		return rs;
	}
}
