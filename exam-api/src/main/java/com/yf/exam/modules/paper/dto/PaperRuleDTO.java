package com.yf.exam.modules.paper.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
* <p>
* 试卷规则请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@ApiModel(value="试卷规则", description="试卷规则")
public class PaperRuleDTO implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty(value = "规则编号", required=true)
    private String id;

    @ApiModelProperty(value = "规则名称", required=true)
    private String title;

    @ApiModelProperty(value = "主观题分数", required=true)
    private Integer subjScore;

    @ApiModelProperty(value = "客观题分数", required=true)
    private Integer objScore;

    @ApiModelProperty(value = "总分", required=true)
    private Integer totalScore;

    @ApiModelProperty(value = "时长(分钟)", required=true)
    private Integer totalTime;

    @ApiModelProperty(value = "备注信息", required=true)
    private String remark;

    @ApiModelProperty(value = "规则编号", required=true)
    private String code;

    @ApiModelProperty(value = "状态", required=true)
    private Integer state;

    @ApiModelProperty(value = "合格分数线", required=true)
    private Integer qualifyScore;
    
}
