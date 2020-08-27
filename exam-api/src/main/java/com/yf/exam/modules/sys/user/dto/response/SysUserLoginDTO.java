package com.yf.exam.modules.sys.user.dto.response;

import com.yf.exam.modules.sys.user.dto.SysUserDTO;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
* <p>
* 管理用户请求类
* </p>
*
* @author 聪明笨狗
* @since 2020-04-13 16:57
*/
@Data
@ApiModel(value="管理用户登录响应类", description="管理用户登录响应类")
public class SysUserLoginDTO extends SysUserDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "角色列表", required=true)
    private List<String> roles;

    @ApiModelProperty(value = "登录令牌", required=true)
    private String token;
    
}
