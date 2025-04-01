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
package com.moadata.bdms.support.idgen.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.moadata.bdms.common.exception.ProcessException;

/**
 * Id Generation 서비스의 인터페이스 클래스
 * <p>
 * <b>NOTE</b>: 이 서비스를 통해 어플리케이션에서 UUID, DB에 저장된 값을 이용한 유일키를 제공 받을 수 있다.
 * 
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
public interface IdGenService {
    Log LOGGER = LogFactory.getLog(IdGenService.class);
    
    /**
     * String 형식의 Id 제공
     * 
     * @return 다음 ID
     * @throws ProcessException
     *             유효한 String Id의 범위를 벗어 났을 경우
     */
    //String getNextStringId() throws ProcessException;
    String getNextStringId() throws Exception;
}
