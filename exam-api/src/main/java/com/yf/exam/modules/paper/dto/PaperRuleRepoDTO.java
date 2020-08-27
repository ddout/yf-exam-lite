package com.yf.exam.modules.paper.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
* <p>
* 规则题库请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@ApiModel(value="规则题库", description="规则题库")
public class PaperRuleRepoDTO implements Serializable {

    private static final long serialVersionUID = 1L;


    @ApiModelProperty(value = "ID", required=true)
    private String id;

    @ApiModelProperty(value = "规则ID", required=true)
    private String ruleId;

    @ApiModelProperty(value = "题库ID", required=true)
    private String repoId;

    @ApiModelProperty(value = "单选题数量", required=true)
    private Integer radioCount;

    @ApiModelProperty(value = "单选题分数", required=true)
    private Integer radioScore;

    @ApiModelProperty(value = "多选题数量", required=true)
    private Integer multiCount;

    @ApiModelProperty(value = "多选题分数", required=true)
    private Integer multiScore;

    @ApiModelProperty(value = "判断题数量", required=true)
    private Integer judgeCount;

    @ApiModelProperty(value = "判断题分数", required=true)
    private Integer judgeScore;

    @ApiModelProperty(value = "简答题数量", required=true)
    private Integer saqCount;

    @ApiModelProperty(value = "简答题分数", required=true)
    private Integer saqScore;
    
}
