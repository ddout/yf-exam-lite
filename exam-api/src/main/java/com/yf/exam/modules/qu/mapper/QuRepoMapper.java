package com.yf.exam.modules.qu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yf.exam.modules.qu.dto.QuRepoDTO;
import com.yf.exam.modules.qu.dto.response.QuRepoRespDTO;
import com.yf.exam.modules.qu.entity.QuRepo;
import org.apache.ibatis.annotations.Param;

/**
* <p>
* 题库Mapper
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
public interface QuRepoMapper extends BaseMapper<QuRepo> {

    /**
     * 分页查询题库
     * @param page
     * @param query
     * @return
     */
    IPage<QuRepoRespDTO> paging(Page page, @Param("query") QuRepoDTO query);
}
