package com.yf.exam.modules.exam.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.util.Date;

import java.io.Serializable;

/**
* <p>
* 考试数据传输类
* </p>
*
* @author 聪明笨狗
* @since 2020-07-25 16:18
*/
@Data
@ApiModel(value="考试", description="考试")
public class ExamDTO implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty(value = "ID", required=true)
    private String id;

    @ApiModelProperty(value = "考试名称", required=true)
    private String title;

    @ApiModelProperty(value = "考试描述", required=true)
    private String content;

    @ApiModelProperty(value = "是否公开", required=true)
    private Boolean open;

    @ApiModelProperty(value = "口令密码", required=true)
    private String password;

    @ApiModelProperty(value = "课程状态", required=true)
    private Integer state;

    @ApiModelProperty(value = "考试规则ID", required=true)
    private String ruleId;

    @ApiModelProperty(value = "是否限时", required=true)
    private Boolean timeLimit;

    @ApiModelProperty(value = "开始时间", required=true)
    private Date startTime;

    @ApiModelProperty(value = "结束时间", required=true)
    private Date endTime;

    @ApiModelProperty(value = "创建时间", required=true)
    private Date createTime;

    @ApiModelProperty(value = "更新时间", required=true)
    private Date updateTime;

    @ApiModelProperty(value = "主观题分数", required=true)
    private Integer subjScore;

    @ApiModelProperty(value = "客观题分数", required=true)
    private Integer objScore;

    @ApiModelProperty(value = "总分数", required=true)
    private Integer totalScore;

    @ApiModelProperty(value = "总时长（分钟）", required=true)
    private Integer totalTime;

    @ApiModelProperty(value = "及格分数", required=true)
    private Integer qualifyScore;


}
