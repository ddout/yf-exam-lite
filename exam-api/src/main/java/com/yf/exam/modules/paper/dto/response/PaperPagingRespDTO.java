package com.yf.exam.modules.paper.dto.response;

import com.yf.exam.modules.paper.dto.PaperDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
* <p>
* 试卷请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 17:31
*/
@Data
@ApiModel(value="试卷分页响应类", description="试卷分页响应类")
public class PaperPagingRespDTO extends PaperDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "用户姓名", required=true)
    private String realName;
}
