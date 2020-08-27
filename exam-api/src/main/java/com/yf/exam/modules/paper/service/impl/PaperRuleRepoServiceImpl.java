package com.yf.exam.modules.paper.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.modules.paper.dto.PaperRuleRepoDTO;
import com.yf.exam.modules.paper.entity.PaperRuleRepo;
import com.yf.exam.modules.paper.mapper.PaperRuleRepoMapper;
import com.yf.exam.modules.paper.service.PaperRuleRepoService;
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
* @since 2020-05-25 16:33
*/
@Service
public class PaperRuleRepoServiceImpl extends ServiceImpl<PaperRuleRepoMapper, PaperRuleRepo> implements PaperRuleRepoService {

    @Override
    public IPage<PaperRuleRepoDTO> paging(PagingReqDTO<PaperRuleRepoDTO> reqDTO) {

        //创建分页对象
        IPage<PaperRuleRepo> query = new Page<>(reqDTO.getCurrent(), reqDTO.getSize());

        //查询条件
        QueryWrapper<PaperRuleRepo> wrapper = new QueryWrapper<>();

        //获得数据
        IPage<PaperRuleRepo> page = this.page(query, wrapper);
        //转换结果
        IPage<PaperRuleRepoDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<PaperRuleRepoDTO>>(){});
        return pageData;
     }

    @Override
    public List<PaperRuleRepoDTO> listByRule(String ruleId) {
        //查询条件
        QueryWrapper<PaperRuleRepo> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(PaperRuleRepo::getRuleId, ruleId);

        List<PaperRuleRepo> list = this.list(wrapper);
        return BeanMapper.mapList(list, PaperRuleRepoDTO.class);
    }

    @Override
    public void saveAll(String ruleId, List<PaperRuleRepoDTO> reqDTO) {

        // 先删除
        QueryWrapper<PaperRuleRepo> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(PaperRuleRepo::getRuleId, ruleId);
        this.remove(wrapper);

        // 保存全部
        if(!CollectionUtils.isEmpty(reqDTO)){
            List<PaperRuleRepo> list = new ArrayList<>();
            for(PaperRuleRepoDTO item: reqDTO){
                PaperRuleRepo ref = new PaperRuleRepo();
                BeanMapper.copy(item, ref);
                ref.setRuleId(ruleId);
                list.add(ref);
            }
            this.saveBatch(list);
        }
    }
}
