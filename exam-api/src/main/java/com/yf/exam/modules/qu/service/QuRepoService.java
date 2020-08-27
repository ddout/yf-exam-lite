package com.yf.exam.modules.qu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuRepoDTO;
import com.yf.exam.modules.qu.dto.response.QuRepoRespDTO;
import com.yf.exam.modules.qu.entity.QuRepo;

/**
* <p>
* 题库业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
public interface QuRepoService extends IService<QuRepo> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<QuRepoRespDTO> paging(PagingReqDTO<QuRepoDTO> reqDTO);
}
