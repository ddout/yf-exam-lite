package com.yf.exam.modules.paper.dto.ext;

import com.yf.exam.modules.paper.dto.PaperRuleDTO;
import com.yf.exam.modules.paper.dto.PaperRuleRepoDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
* <p>
* 试卷规则请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@ApiModel(value="试卷规则详情类", description="试卷规则详情类")
public class PaperRuleDetailDTO extends PaperRuleDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "题库列表", required=true)
    List<PaperRuleRepoDTO> repoList;
    
}
