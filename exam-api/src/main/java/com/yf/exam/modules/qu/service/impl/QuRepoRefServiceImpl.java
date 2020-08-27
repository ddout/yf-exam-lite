package com.yf.exam.modules.qu.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.modules.qu.dto.QuRepoRefDTO;
import com.yf.exam.modules.qu.dto.request.QuRepoBatchReqDTO;
import com.yf.exam.modules.qu.entity.Qu;
import com.yf.exam.modules.qu.entity.QuRepoRef;
import com.yf.exam.modules.qu.mapper.QuMapper;
import com.yf.exam.modules.qu.mapper.QuRepoRefMapper;
import com.yf.exam.modules.qu.service.QuRepoRefService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
* <p>
* 语言设置 服务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:23
*/
@Service
public class QuRepoRefServiceImpl extends ServiceImpl<QuRepoRefMapper, QuRepoRef> implements QuRepoRefService {


    @Autowired
    private QuMapper quMapper;

    @Override
    public IPage<QuRepoRefDTO> paging(PagingReqDTO<QuRepoRefDTO> reqDTO) {

        //创建分页对象
        IPage<QuRepoRef> query = new Page<>(reqDTO.getCurrent(), reqDTO.getSize());

        //查询条件
        QueryWrapper<QuRepoRef> wrapper = new QueryWrapper<>();

        //获得数据
        IPage<QuRepoRef> page = this.page(query, wrapper);
        //转换结果
        IPage<QuRepoRefDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<QuRepoRefDTO>>(){});
        return pageData;
     }

    @Override
    public void saveAll(String quId, Integer quType, List<String> ids) {
        // 先删除
        QueryWrapper<QuRepoRef> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(QuRepoRef::getQuId, quId);
        this.remove(wrapper);

        // 保存全部
        if(!CollectionUtils.isEmpty(ids)){
            List<QuRepoRef> list = new ArrayList<>();
            for(String id: ids){
                QuRepoRef ref = new QuRepoRef();
                ref.setQuId(quId);
                ref.setRepoId(id);
                ref.setQuType(quType);
                list.add(ref);
            }
            this.saveBatch(list);
        }
    }

    @Override
    public List<String> listByQu(String quId) {
        // 先删除
        QueryWrapper<QuRepoRef> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(QuRepoRef::getQuId, quId);
        List<QuRepoRef> list = this.list(wrapper);
        List<String> ids = new ArrayList<>();
        if(!CollectionUtils.isEmpty(list)){
            for(QuRepoRef item: list){
                ids.add(item.getRepoId());
            }
        }
        return ids;
    }

    @Override
    public void batchAction(QuRepoBatchReqDTO reqDTO) {

        // 移除的
        if(reqDTO.getRemove()!=null &&  reqDTO.getRemove()){
            QueryWrapper<QuRepoRef> wrapper = new QueryWrapper<>();
            wrapper.lambda()
                    .in(QuRepoRef::getRepoId, reqDTO.getRepoIds())
                    .in(QuRepoRef::getQuId, reqDTO.getQuIds());
            this.remove(wrapper);
            return;
        }

        // 新增的
        for(String quId : reqDTO.getQuIds()){
            Qu q = quMapper.selectById(quId);
            this.saveAll(quId, q.getQuType(), reqDTO.getRepoIds());
        }

    }
}
