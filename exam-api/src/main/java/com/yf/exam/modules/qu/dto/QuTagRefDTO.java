package com.yf.exam.modules.qu.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import java.io.Serializable;
import java.util.Date;

/**
* <p>
* 题目标签请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Data
@ApiModel(value="题目标签", description="题目标签")
public class QuTagRefDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    
    @ApiModelProperty(value = "ID", required=true)
    private String id;
    
    @ApiModelProperty(value = "问题", required=true)
    private String quId;
    
    @ApiModelProperty(value = "标签", required=true)
    private String tagId;
    
}
