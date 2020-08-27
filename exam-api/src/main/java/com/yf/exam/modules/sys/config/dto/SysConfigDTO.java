package com.yf.exam.modules.sys.config.dto;

import com.alibaba.fastjson.annotation.JSONField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* <p>
* 通用配置请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-04-17 09:12
*/
@Data
@ApiModel(value="通用配置", description="通用配置")
public class SysConfigDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    
    @ApiModelProperty(value = "ID", required=true)
    private String id;
    
    @ApiModelProperty(value = "预热时长", required=true)
    private Integer prepare;

    @JSONField(format = "HH:mm")
    @ApiModelProperty(value = "休市开始时间", required=true)
    private Date restStart;

    @JSONField(format = "HH:mm")
    @ApiModelProperty(value = "休市结束时间", required=true)
    private Date restEnd;
    
}
