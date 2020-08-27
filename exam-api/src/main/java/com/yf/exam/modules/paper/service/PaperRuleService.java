package com.yf.exam.modules.paper.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.paper.dto.PaperRuleDTO;
import com.yf.exam.modules.paper.dto.ext.PaperRuleDetailDTO;
import com.yf.exam.modules.paper.entity.PaperRule;

/**
* <p>
* 试卷规则业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
public interface PaperRuleService extends IService<PaperRule> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<PaperRuleDTO> paging(PagingReqDTO<PaperRuleDTO> reqDTO);

    /**
     * 保存规则
     * @param reqDTO
     */
    void save(PaperRuleDetailDTO reqDTO);

    /**
     * 查找规则
     * @param id
     * @return
     */
    PaperRuleDetailDTO detail(String id);
}
