package com.moadata.bdms.common.base.vo;

import java.io.Serializable;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 모든 도메인 객체가 상속받아야할 기본 클래스.
 *
 */
public class BaseObject implements Serializable {
    /**
     * Use serialVersionUID science
     */
    private static final long serialVersionUID = 4711031603329794236L;

    /**
     * 해당 객체의 toString 오버라이드.
     *
     * @return 객체의 각 프로퍼티와 해당 값을 text로 제공
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }

    /**
     * 해당 객체의 equals 오버라이드.
     *
     * @param obj 비교 대상 객체
     * @return 비교 대상 객체와 각 프로퍼티값이 동일한 경우 <code>tue</code>반환
     */
    @Override
    public boolean equals(Object obj) {
        return EqualsBuilder.reflectionEquals(this, obj);
    }

    /**
     * 해당 객체의 hashCode 오버라이드.
     *
     * @return the int
     */
    @Override
    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }
}