package com.yf.exam.modules.sys.log.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

import java.util.Date;

/**
* <p>
* 系统日志实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-04-28 10:23
*/
@Data
@TableName("sys_log")
public class SysLog extends Model<SysLog> {

    private static final long serialVersionUID = 1L;
    
    /**
    * ID
    */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;
    
    /**
    * 日志名称
    */
    private String title;
    
    /**
    * 用户ID
    */
    @TableField("user_id")
    private String userId;
    
    /**
    * 用户名称
    */
    @TableField("user_name")
    private String userName;
    
    /**
    * IP地址
    */
    private String ip;
    
    /**
    * IP归属地
    */
    @TableField("ip_region")
    private String ipRegion;
    
    /**
    * 创建时间
    */
    @TableField("create_time")
    private Date createTime;
    
    /**
    * 日志明细
    */
    private String data;
    
}
