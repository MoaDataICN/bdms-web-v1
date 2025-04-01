package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import org.apache.ibatis.type.Alias;

import lombok.Data;

/**
 * Code
 */
@Data
@Alias("searchConditionVO")
public class SearchConditionVO extends BaseObject {
    /** The Constant serialVersionUID. */
    private static final long serialVersionUID = -4979675148858002532L;

    private String field;
    private String value;
    private String operator;
}
