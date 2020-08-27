package com.yf.exam.modules.paper.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yf.exam.modules.paper.dto.PaperDTO;
import com.yf.exam.modules.paper.dto.response.PaperPagingRespDTO;
import com.yf.exam.modules.paper.entity.Paper;
import org.apache.ibatis.annotations.Param;

/**
* <p>
* 试卷Mapper
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
public interface PaperMapper extends BaseMapper<Paper> {

    /**
     * 查找试卷分页
     * @param page
     * @param query
     * @return
     */
    IPage<PaperPagingRespDTO> paging(Page page, @Param("query") PaperDTO query);
}
