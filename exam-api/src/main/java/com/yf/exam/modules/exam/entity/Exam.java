package com.yf.exam.modules.exam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import java.util.Date;

/**
* <p>
* 考试实体类
* </p>
*
* @author 聪明笨狗
* @since 2020-07-25 16:18
*/
@Data
@TableName("el_exam")
public class Exam extends Model<Exam> {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId(value = "id", type = IdType.ID_WORKER_STR)
    private String id;

    /**
     * 考试名称
     */
    private String title;

    /**
     * 考试描述
     */
    private String content;

    /**
     * 是否公开
     */
    private Boolean open;

    /**
     * 口令密码
     */
    private String password;

    /**
     * 课程状态
     */
    private Integer state;

    /**
     * 考试规则ID
     */
    @TableField("rule_id")
    private String ruleId;

    /**
     * 是否限时
     */
    @TableField("time_limit")
    private Boolean timeLimit;

    /**
     * 开始时间
     */
    @TableField("start_time")
    private Date startTime;

    /**
     * 结束时间
     */
    @TableField("end_time")
    private Date endTime;

    /**
     * 创建时间
     */
    @TableField("create_time")
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField("update_time")
    private Date updateTime;

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
     * 总分数
     */
    @TableField("total_score")
    private Integer totalScore;

    /**
     * 总时长（分钟）
     */
    @TableField("total_time")
    private Integer totalTime;

    /**
     * 及格分数
     */
    @TableField("qualify_score")
    private Integer qualifyScore;
    
}
