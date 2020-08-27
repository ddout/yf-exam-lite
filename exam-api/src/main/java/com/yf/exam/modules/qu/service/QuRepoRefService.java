package com.yf.exam.modules.qu.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuRepoRefDTO;
import com.yf.exam.modules.qu.dto.request.QuRepoBatchReqDTO;
import com.yf.exam.modules.qu.entity.QuRepoRef;

import java.util.List;

/**
* <p>
* 试题题库业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
public interface QuRepoRefService extends IService<QuRepoRef> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<QuRepoRefDTO> paging(PagingReqDTO<QuRepoRefDTO> reqDTO);

    /**
     * 保存全部列表
     * @param quId
     * @param quType
     * @param ids
     */
    void saveAll(String quId, Integer quType, List<String> ids);


    /**
     * 根据问题查找题库
     * @param quId
     * @return
     */
    List<String> listByQu(String quId);

    /**
     * 批量操作
     * @param reqDTO
     */
    void batchAction(QuRepoBatchReqDTO reqDTO);
}
