package com.yf.exam.modules.qu.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuRepoDTO;
import com.yf.exam.modules.qu.dto.response.QuRepoRespDTO;
import com.yf.exam.modules.qu.entity.QuRepo;
import com.yf.exam.modules.qu.mapper.QuRepoMapper;
import com.yf.exam.modules.qu.service.QuRepoService;
import org.springframework.stereotype.Service;

/**
* <p>
* 语言设置 服务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Service
public class QuRepoServiceImpl extends ServiceImpl<QuRepoMapper, QuRepo> implements QuRepoService {

    @Override
    public IPage<QuRepoRespDTO> paging(PagingReqDTO<QuRepoDTO> reqDTO) {

        //创建分页对象
        Page page = new Page(reqDTO.getCurrent(), reqDTO.getSize());

        return baseMapper.paging(page, reqDTO.getParams());
     }
}
