/*
 * Copyright 2008-2009 MOPAS(Ministry of Public Administration and Security).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.moadata.bdms.support.idgen.service.impl;

import java.math.BigDecimal;

import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.support.idgen.service.IdGenService;
import com.moadata.bdms.support.idgen.service.IdGenStrategy;

/**
 * ID Generation 서비스를 위한 Abstract Service
 * @author 실행환경 개발팀 김태호
 * @since 2009.02.01
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.02.01  김태호          최초 생성
 * 
 * </pre>
 */
public abstract class AbstractIdGenService implements IdGenService {

    /**
     * 내부 synchronization을 위한 정보
     */
    private final Object mSemaphore = new Object();

    /**
     * 정책정보 생성
     */
    private IdGenStrategy strategy = new IdGenStrategy() {
        public String makeId(String originalId) {
            return originalId;
        }
    };

    /**
     * BigDecimal 사용 여부
     */
    protected boolean useBigDecimals = false;

    /**
     * 기본 생성자
     */
    public AbstractIdGenService() {
    }

    /**
     * BigDecimal 타입의 유일 아이디 제공
     * @return BigDecimal 타입의 다음 ID
     * @throws ProcessException
     *         if an Id could not be allocated for any
     *         reason.
     */
    protected abstract BigDecimal getNextBigDecimalIdInner() throws ProcessException;

    /**
     * long 타입의 유일 아이디 제공
     * @return long 타입의 다음 ID
     * @throws ProcessException
     *         여타이유에 의해 아이디 생성이 불가능 할때
     */
    protected abstract long getNextLongIdInner() throws ProcessException;

    /**
     * BigDecimal 사용여부 세팅
     * @param useBigDecimals
     *        BigDecimal 사용여부
     */
    public final void setUseBigDecimals(boolean useBigDecimals) {
        this.useBigDecimals = useBigDecimals;
    }

    /**
     * BigDecimal 사용여부 정보 리턴
     * @return boolean check using BigDecimal
     */
    protected final boolean isUsingBigDecimals() {
        return useBigDecimals;
    }

    /**
     * Returns BigDecimal 타입의 다음 ID 제공
     * @return BigDecimal the next Id.
     * @throws ProcessException
     *         다음 아이디가 유효한 BigDecimal의 범위를 벗어날때
     */
    public final BigDecimal getNextBigDecimalId() throws ProcessException {
        BigDecimal bd;
        if (useBigDecimals) {
            // Use BigDecimal data type
            synchronized (mSemaphore) {
                bd = getNextBigDecimalIdInner();
            }
        } else {
            // Use long data type
            synchronized (mSemaphore) {
                bd = new BigDecimal(getNextLongIdInner());
            }
        }

        return bd;
    }

    /**
     * String 타입의 Id 제공하는데 정책의 아이디 생성 호출함
     * @return the next Id.
     * @throws ProcessException
     *         다음 아이디가 유효한 byte의 범위를 벗어날때
     */
    public final String getNextStringId() throws ProcessException {
        return strategy.makeId(getNextBigDecimalId().toString());
    }

    /**
     * 정책 얻기
     * @return IdGenerationStrategy
     */
    public IdGenStrategy getStrategy() {
        return strategy;
    }

    /**
     * 정책 세팅
     * @param strategy
     *        to be set by Spring Framework
     */
    public void setStrategy(IdGenStrategy strategy) {
        this.strategy = strategy;
    }

}
