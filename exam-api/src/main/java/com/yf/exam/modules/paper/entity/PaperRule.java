package com.yf.exam.modules.paper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

/**
* <p>
* 试卷规则实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@TableName("el_paper_rule")
public class PaperRule extends Model<PaperRule> {

    private static final long serialVersionUID = 1L;

    /**
     * 规则编号
     */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;

    /**
     * 规则名称
     */
    private String title;

    /**
     * 主观题分数
     */
    @TableField("subj_score")
    private Integer subjScore;

    /**
     * 客观题分数
     */
    @TableField("obj_score")
    private Integer objScore;

    /**
     * 总分
     */
    @TableField("total_score")
    private Integer totalScore;

    /**
     * 时长(分钟)
     */
    @TableField("total_time")
    private Integer totalTime;

    /**
     * 备注信息
     */
    private String remark;

    /**
     * 规则编号
     */
    private String code;

    /**
     * 状态
     */
    private Integer state;

    /**
     * 合格分数线
     */
    @TableField("qualify_score")
    private Integer qualifyScore;
    
}
