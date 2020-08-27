package com.yf.exam.modules.qu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuTagDTO;
import com.yf.exam.modules.qu.entity.QuTag;

/**
* <p>
* 标签业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
public interface QuTagService extends IService<QuTag> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<QuTagDTO> paging(PagingReqDTO<QuTagDTO> reqDTO);
}
