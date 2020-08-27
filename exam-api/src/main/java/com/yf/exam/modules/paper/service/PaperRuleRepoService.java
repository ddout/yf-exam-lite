package com.yf.exam.modules.paper.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.paper.dto.PaperRuleRepoDTO;
import com.yf.exam.modules.paper.entity.PaperRuleRepo;

import java.util.List;

/**
* <p>
* 规则题库业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
public interface PaperRuleRepoService extends IService<PaperRuleRepo> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<PaperRuleRepoDTO> paging(PagingReqDTO<PaperRuleRepoDTO> reqDTO);

    /**
     * 根据规则ID列出规则题库
     * @param ruleId
     * @return
     */
    List<PaperRuleRepoDTO> listByRule(String ruleId);

    /**
     * 保存全部
     * @param ruleId
     * @param reqDTO
     */
    void saveAll(String ruleId, List<PaperRuleRepoDTO> reqDTO);
}
