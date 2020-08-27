package com.yf.exam.modules.user.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.user.dto.UserWrongBookDTO;
import com.yf.exam.modules.user.entity.UserWrongBook;

/**
* <p>
* 错题本业务类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-27 17:56
*/
public interface UserWrongBookService extends IService<UserWrongBook> {

    /**
    * 分页查询数据
    * @param reqDTO
    * @return
    */
    IPage<UserWrongBookDTO> paging(PagingReqDTO<UserWrongBookDTO> reqDTO);

    /**
     * 加入错题本
     * @param userId
     * @param quId
     */
    void addBook(String userId, String quId);

    /**
     * 查找第一个错题
     * @param userId
     * @param quId
     * @return
     */
    String findNext(String userId, String quId);
}
