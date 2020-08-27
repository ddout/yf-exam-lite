package com.yf.exam.modules.qu.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuTagDTO;
import com.yf.exam.modules.qu.entity.QuTag;
import com.yf.exam.modules.qu.mapper.QuTagMapper;
import com.yf.exam.modules.qu.service.QuTagService;
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
public class QuTagServiceImpl extends ServiceImpl<QuTagMapper, QuTag> implements QuTagService {

    @Override
    public IPage<QuTagDTO> paging(PagingReqDTO<QuTagDTO> reqDTO) {

        //创建分页对象
        IPage<QuTag> query = new Page<>(reqDTO.getCurrent(), reqDTO.getSize());

        //查询条件
        QueryWrapper<QuTag> wrapper = new QueryWrapper<>();

        //获得数据
        IPage<QuTag> page = this.page(query, wrapper);
        //转换结果
        IPage<QuTagDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<QuTagDTO>>(){});
        return pageData;
     }
}
