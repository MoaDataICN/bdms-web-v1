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
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.moadata.bdms.common.exception.ProcessException;
import com.moadata.bdms.support.idgen.repository.IdgenDao;

/**
 * ID Generation 서비스를 위한 Table 구현 클래스
 * <p>
 * <b>NOTE</b>: 채번 테이블을 정의하고, 각 관리대상에 대한 현재 최종 Max 번호를
 * 관리하여 Table 기반의 유일키를 제공 받을 수 있다.
 * 
 * <pre>
 *       필요한 테이블 생성 스크립트
 *   CREATE TABLE ids (
 *       table_name varchar(16) NOT NULL,
 *       next_id INTEGER NOT NULL,
 *       PRIMARY KEY (table_name)
 *   );
 * </pre>
 * @author 실행환경 개발팀 김태호
 * @since 2009.02.01
 * @version 1.0
 * @see <pre>
 *  == 개정이력(Modification Information) ==
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.02.01  김태호          최초 생성
 *   2010.11.17  한성곤          해당 키관련 record가 없는 경우, 초기 키정보를 insert하도록 변경 
 * 
 * </pre>
 */
public class TableIdGenService extends AbstractDataBlockIdGenService {

    /**
     * ID생성을 위한 테이블 정보 디폴트는 ids임.
     */
    private String table = "ids";

    /**
     * 테이블 정보에 기록되는 대상 키정보 대개의 경우는 아이디로 생성되는 테이블명을 기재함
     */
    private String tableName = "id";

    /**
     * ID생성 Dao
     */
    @Autowired
    private IdgenDao idgenDao;
    
    /**
     * 생성자
     */
    public TableIdGenService() {
    }

    /**
     * blockSize 대로 ID 지정
     * @param blockSize
     *        지정되는 blockSize
     * @param useBigDecimals
     *        BigDecimal 사용 여부
     * @return BigDecimal을 사용하면 BigDecimal 아니면 long 리턴
     * @throws ProcessException
     *         ID생성을 위한 블럭 할당이 불가능할때
     */
    private Object allocateIdBlock(int blockSize, boolean useBigDecimals) throws ProcessException {

        Object nextId = null;
        Object newNextId = null;
        long oldNextId = 0;
        
        try {
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("table", table);
            parameter.put("tableName", tableName);
            
            String getId = idgenDao.selectNextId(parameter);
            
            if(getId != null) {
                oldNextId = Long.parseLong(getId);
            } else {
                // 해당 키관련 record가 없는 경우
                idgenDao.insertDefaultData(parameter);
            }
            
            newNextId = new Long(oldNextId + blockSize);
            nextId = new Long(oldNextId);
            
            parameter.put("newNextId", newNextId);
            parameter.put("nextId", nextId);
            
            idgenDao.updateNextId(parameter);
        } catch(Exception e) {
            throw new ProcessException("Key 생성 오류", new Exception());
        }
        
        return nextId;
        /*
        if (getLogger().isDebugEnabled()) {
            getLogger().debug(messageSource.getMessage("debug.idgnr.allocate.idblock", new Object[] {new Integer(blockSize), tableName }, Locale.getDefault()));
        }
        
        try {
            Connection conn = getConnection();
            try {

                boolean autoCommit = conn.getAutoCommit();

                Statement stmt = conn.createStatement();
                
                try {

                    int tries = 0;
                    boolean isFirstSelect = true;	// 해당 키관련 record가 없는 경우 처리 (2010-11-17)
                    
                    while (tries < 50) {
                        String query = "SELECT next_id FROM " + table + " WHERE table_name = '" + tableName + "'";
                        ResultSet rs = stmt.executeQuery(query);
                        //----------------------------------------------
            			// 해당 키관련 record가 없는 경우 처리 (2010-11-17)
            			//----------------------------------------------
            			if (isFirstSelect && !rs.next()) {
            			    try {
                				query = "INSERT INTO " + table + "(table_name, next_id) " + "values('" + tableName + "', 0)";
                
                				stmt.executeUpdate(query);
                
                				if (!autoCommit) {
                				    conn.commit();
                				}
            			    } catch (SQLException ex) {
                				if (getLogger().isErrorEnabled()) {
                				    getLogger().error(messageSource.getMessage("error.idgnr.insert.idblock", new String[] { tableName }, Locale.getDefault()));
                				}
                				throw new ProcessException(messageSource, "error.idgnr.insert.idblock", new String[] { tableName }, null);
            			    } finally {
                				if (rs != null) {
                				    rs.close();
                				}
            			    }
            			    isFirstSelect = false;
            			    continue; // 다시 select를 처리하기 위해 ...
            			}
                        ////--------------------------------------------
                        if (!rs.next()) {
                            if (getLogger().isErrorEnabled()) {
                                //Unable to allocate a block of Ids. no row with table_name='FILE_ID' exists in the SEQS table.
                                getLogger().error(messageSource.getMessage("error.idgnr.tableid.notallocate.id", new String[] {tableName, table }, Locale.getDefault()));
                            }
                                
                            if (!autoCommit) {
                                conn.rollback();
                            }
                            throw new ProcessException(messageSource, "error.idgnr.tableid.notallocate.id", new String[] {tableName, table }, null);
                        }

                        Object nextId;
                        Object newNextId;
                        if (useBigDecimals) {
                            BigDecimal oldNextId = rs.getBigDecimal(1);
                            newNextId = oldNextId.add(new BigDecimal(blockSize));
                            nextId = oldNextId;
                        } else {
                            long oldNextId = rs.getLong(1);
                            newNextId = new Long(oldNextId + blockSize);
                            nextId = new Long(oldNextId);
                        }

                        try {
                            query = "UPDATE " + table + " SET next_id = " + newNextId + " " + " WHERE table_name = '" + tableName + "' " + "  AND next_id = " + nextId + "";

                            int updated = stmt.executeUpdate(query);
                            
                            if (updated >= 1) {
                                if (!autoCommit) {
                                    conn.commit();
                                }
                                return nextId;
                            } else {
                                if (getLogger().isDebugEnabled()) {
                                    getLogger().debug(messageSource.getMessage("debug.idgnr.updated.norows", new String[] {}, Locale.getDefault()));
                                }
                            }
                        } catch (SQLException e) {
                            if (getLogger().isWarnEnabled()) {
                                getLogger().warn(messageSource.getMessage("warn.idgnr.update.idblock", new String[] {}, Locale.getDefault()));
                            }
                        }

                        if (!autoCommit) {
                            conn.rollback();
                        }

                        tries++;
                    }

                    if (getLogger().isErrorEnabled()) {
                        getLogger().error(messageSource.getMessage("error.idgnr.null.id",new String[] {}, Locale.getDefault()));
                    }
                        
                    return null;
                } finally {
                    stmt.close();
                }
            } finally {
                conn.close();
            }
        } catch (SQLException e) {
            if (getLogger().isErrorEnabled()) {
                getLogger().error(messageSource.getMessage("error.idgnr.get.connection", new String[] {}, Locale.getDefault()), e);
            }
                
            throw new ProcessException(messageSource, "error.idgnr.get.connection", e);
        }
        */
    }

    /**
     * blockSize 대로 ID 지정(BigDecimal)
     * @param blockSize
     *        지정되는 blockSize
     * @return 할당된 블럭의 첫번째 아이디
     * @throws ProcessException
     *         ID생성을 위한 블럭 할당이 불가능할때
     */
    protected BigDecimal allocateBigDecimalIdBlock(int blockSize)
            throws ProcessException {
        return (BigDecimal) allocateIdBlock(blockSize, true);
    }

    /**
     * blockSize 대로 ID 지정(long)
     * @param blockSize
     *        지정되는 blockSize
     * @return 할당된 블럭의 첫번째 아이디
     * @throws ProcessException
     *         ID생성을 위한 블럭 할당이 불가능할때
     */
    protected long allocateLongIdBlock(int blockSize) throws ProcessException {
        Long id = (Long) allocateIdBlock(blockSize, false);

        return id.longValue();
    }

    /**
     * ID생성을 위한 테이블 정보 Injection
     * @param table
     *        config로 지정되는 정보
     */
    public void setTable(String table) {
        this.table = table;
    }

    /**
     * ID 생성을 위한 테이블의 키정보 ( 대개의경우는 대상 테이블명을 기재함 )
     * @param tableName
     *        config로 지정되는 정보
     */
    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

}
