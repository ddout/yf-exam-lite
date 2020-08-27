package com.yf.exam.modules.qu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

/**
* <p>
* 题目标签实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Data
@TableName("el_qu_tag_ref")
public class QuTagRef extends Model<QuTagRef> {

    private static final long serialVersionUID = 1L;
    
    /**
    * ID
    */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;
    
    /**
    * 问题
    */
    @TableField("qu_id")
    private String quId;
    
    /**
    * 标签
    */
    @TableField("tag_id")
    private String tagId;
    
}
