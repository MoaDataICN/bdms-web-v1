package com.moadata.bdms.common.util;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

/**
 * ProjectUtil
 * 
 */
public final class ProjectUtil {
	private ProjectUtil() {
		throw new AssertionError();
	}
	
	public static void copyNonNullProperties(Object src, Object target) {
		BeanUtils.copyProperties(src, target, getNullPropertyNames(src));
	}

	public static String[] getNullPropertyNames (Object source) {
		final BeanWrapper src = new BeanWrapperImpl(source);
		java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();
		
		Set<String> emptyNames = new HashSet<String>();
		for(java.beans.PropertyDescriptor pd : pds) {
			Object srcValue = src.getPropertyValue(pd.getName());
			if (srcValue == null) {
				emptyNames.add(pd.getName());
			} else if(srcValue instanceof Character) {
				/*Character DEFAULT_CHAR = new Character(Character.MIN_VALUE);
				if(DEFAULT_CHAR.compareTo((Character) srcValue) == 0) {
					emptyNames.add(pd.getName());
				}*/
				if(((Character) srcValue) == 0) {
					emptyNames.add(pd.getName());
				}
			}
		}
		String[] result = new String[emptyNames.size()];
		return emptyNames.toArray(result);
	}
}
