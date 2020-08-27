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
* 标签请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Data
@ApiModel(value="标签", description="标签")
public class QuTagDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    
    @ApiModelProperty(value = "ID", required=true)
    private String id;
    
    @ApiModelProperty(value = "标签类型")
    private Integer tagType;
    
    @ApiModelProperty(value = "标签名称", required=true)
    private String tagName;
    
}
