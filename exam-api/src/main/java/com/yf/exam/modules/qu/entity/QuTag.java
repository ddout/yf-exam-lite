package com.yf.exam.modules.qu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

/**
* <p>
* 标签实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Data
@TableName("el_qu_tag")
public class QuTag extends Model<QuTag> {

    private static final long serialVersionUID = 1L;
    
    /**
    * ID
    */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;
    
    /**
    * 标签类型
    */
    @TableField("tag_type")
    private Integer tagType;
    
    /**
    * 标签名称
    */
    @TableField("tag_name")
    private String tagName;
    
}
