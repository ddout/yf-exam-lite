package com.yf.exam.modules.paper.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

/**
* <p>
* 规则题库实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@TableName("el_paper_rule_repo")
public class PaperRuleRepo extends Model<PaperRuleRepo> {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;

    /**
     * 规则ID
     */
    @TableField("rule_id")
    private String ruleId;

    /**
     * 题库ID
     */
    @TableField("repo_id")
    private String repoId;

    /**
     * 单选题数量
     */
    @TableField("radio_count")
    private Integer radioCount;

    /**
     * 单选题分数
     */
    @TableField("radio_score")
    private Integer radioScore;

    /**
     * 多选题数量
     */
    @TableField("multi_count")
    private Integer multiCount;

    /**
     * 多选题分数
     */
    @TableField("multi_score")
    private Integer multiScore;

    /**
     * 判断题数量
     */
    @TableField("judge_count")
    private Integer judgeCount;

    /**
     * 判断题分数
     */
    @TableField("judge_score")
    private Integer judgeScore;

    /**
     * 简答题数量
     */
    @TableField("saq_count")
    private Integer saqCount;

    /**
     * 简答题分数
     */
    @TableField("saq_score")
    private Integer saqScore;
    
}
