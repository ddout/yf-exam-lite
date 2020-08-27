package com.yf.exam.modules.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.exam.dto.ExamDTO;
import com.yf.exam.modules.exam.dto.response.ExamRespDTO;
import com.yf.exam.modules.exam.entity.Exam;

/**
* <p>
* 考试业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-07-25 16:18
*/
public interface ExamService extends IService<Exam> {

    /**
     * 保存或修改
     * @param reqDTO
     */
    void save(ExamDTO reqDTO);

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<ExamRespDTO> paging(PagingReqDTO<ExamDTO> reqDTO);
}
