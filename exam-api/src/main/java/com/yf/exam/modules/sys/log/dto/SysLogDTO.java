package com.yf.exam.modules.sys.log.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* <p>
* 系统日志请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-04-28 10:23
*/
@Data
@ApiModel(value="系统日志", description="系统日志")
public class SysLogDTO implements Serializable {

    private static final long serialVersionUID = 1L;
    
    
    @ApiModelProperty(value = "ID", required=true)
    private String id;
    
    @ApiModelProperty(value = "日志名称", required=true)
    private String title;
    
    @ApiModelProperty(value = "用户ID", required=true)
    private String userId;
    
    @ApiModelProperty(value = "用户名称", required=true)
    private String userName;
    
    @ApiModelProperty(value = "IP地址", required=true)
    private String ip;
    
    @ApiModelProperty(value = "IP归属地", required=true)
    private String ipRegion;
    
    @ApiModelProperty(value = "创建时间", required=true)
    private Date createTime;
    
    @ApiModelProperty(value = "日志明细", required=true)
    private String data;
    
}
