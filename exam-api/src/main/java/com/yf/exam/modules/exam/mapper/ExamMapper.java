package com.yf.exam.modules.exam.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.yf.exam.modules.exam.dto.ExamDTO;
import com.yf.exam.modules.exam.dto.response.ExamRespDTO;
import com.yf.exam.modules.exam.entity.Exam;
import org.apache.ibatis.annotations.Param;

/**
* <p>
* 考试Mapper
* </p>
*
* @author 聪明笨狗
* @since 2020-07-25 16:18
*/
public interface ExamMapper extends BaseMapper<Exam> {

    /**
     * 查找分页内容
     * @param page
     * @param query
     * @return
     */
    IPage<ExamRespDTO> paging(Page page, @Param("query") ExamDTO query);
}
