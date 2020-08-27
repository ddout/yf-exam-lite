package com.yf.exam.modules.user.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.entity.Qu;
import com.yf.exam.modules.qu.service.QuService;
import com.yf.exam.modules.user.dto.UserWrongBookDTO;
import com.yf.exam.modules.user.entity.UserWrongBook;
import com.yf.exam.modules.user.mapper.UserWrongBookMapper;
import com.yf.exam.modules.user.service.UserWrongBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

/**
* <p>
* 语言设置 服务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-27 17:56
*/
@Service
public class UserWrongBookServiceImpl extends ServiceImpl<UserWrongBookMapper, UserWrongBook> implements UserWrongBookService {

    @Autowired
    private QuService quService;

    @Override
    public IPage<UserWrongBookDTO> paging(PagingReqDTO<UserWrongBookDTO> reqDTO) {

        //创建分页对象
        Page query = new Page<>(reqDTO.getCurrent(), reqDTO.getSize());

        //查询条件
        QueryWrapper<UserWrongBook> wrapper = new QueryWrapper<>();

        // 用户
        String userId = reqDTO.getUserId();
        if(!StringUtils.isEmpty(userId)){
            wrapper.lambda().eq(UserWrongBook::getUserId, userId);
        }

        UserWrongBookDTO params = reqDTO.getParams();
        if(params!=null){
            if(!StringUtils.isEmpty(params.getTitle())){
                wrapper.lambda().like(UserWrongBook::getTitle, params.getTitle());
            }
        }

        //获得数据
        IPage<UserWrongBook> page = this.page(query, wrapper);
        //转换结果
        IPage<UserWrongBookDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<UserWrongBookDTO>>(){});
        return pageData;
     }



    @Override
    public void addBook(String userId, String quId) {

        QueryWrapper<UserWrongBook> wrapper = new QueryWrapper<>();
        wrapper.lambda()
                .eq(UserWrongBook::getUserId, userId)
                .eq(UserWrongBook::getQuId, quId);

        //查找已有的错题信息
        UserWrongBook book = this.getOne(wrapper, false);


        // 问题
        Qu qu = quService.getById(quId);

        if (book == null) {
            book = new UserWrongBook();
            book.setUserId(userId);
            book.setTitle(qu.getContent());
            book.setQuId(quId);
            book.setWrongCount(1);
            Integer maxSort = this.findMaxSort(userId);
            book.setSort(maxSort+1);

            this.save(book);
        } else {
            book.setWrongCount(book.getWrongCount()+1);
            this.updateById(book);
        }
    }

    @Override
    public String findNext(String userId, String quId) {


        Integer sort = 999999;

        if(!StringUtils.isEmpty(quId)){
            QueryWrapper<UserWrongBook> wrapper = new QueryWrapper<>();
            wrapper.lambda()
                    .eq(UserWrongBook::getUserId, userId)
                    .eq(UserWrongBook::getQuId, quId);
            wrapper.last(" ORDER BY `sort` DESC");

            UserWrongBook last = this.getOne(wrapper, false);
            if(last!=null){
                sort = last.getSort();
            }
        }

        QueryWrapper<UserWrongBook> wrapper = new QueryWrapper<>();
        wrapper.lambda()
                .eq(UserWrongBook::getUserId, userId)
                .lt(UserWrongBook::getSort, sort);
        wrapper.last(" ORDER BY `sort` DESC");

        UserWrongBook next = this.getOne(wrapper, false);
        if(next != null){
            return next.getQuId();
        }

        return null;
    }

    /**
     * 查找最大的排序
     * @param userId
     * @return
     */
    private Integer findMaxSort(String userId){

        QueryWrapper<UserWrongBook> wrapper = new QueryWrapper<>();
        wrapper.lambda()
                .eq(UserWrongBook::getUserId, userId);
        wrapper.last(" ORDER BY `sort` DESC");

        UserWrongBook book = this.getOne(wrapper, false);
        if(book == null){
            return 0;
        }
        return book.getSort();
    }


}
