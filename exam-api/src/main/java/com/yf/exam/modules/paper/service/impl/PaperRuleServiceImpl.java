package com.yf.exam.modules.paper.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.modules.paper.dto.PaperRuleDTO;
import com.yf.exam.modules.paper.dto.PaperRuleRepoDTO;
import com.yf.exam.modules.paper.dto.ext.PaperRuleDetailDTO;
import com.yf.exam.modules.paper.entity.PaperRule;
import com.yf.exam.modules.paper.mapper.PaperRuleMapper;
import com.yf.exam.modules.paper.service.PaperRuleRepoService;
import com.yf.exam.modules.paper.service.PaperRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
public class PaperRuleServiceImpl extends ServiceImpl<PaperRuleMapper, PaperRule> implements PaperRuleService {


    @Autowired
    private PaperRuleRepoService paperRuleRepoService;

    @Override
    public IPage<PaperRuleDTO> paging(PagingReqDTO<PaperRuleDTO> reqDTO) {

        //创建分页对象
        IPage<PaperRule> query = new Page<>(reqDTO.getCurrent(), reqDTO.getSize());

        //查询条件
        QueryWrapper<PaperRule> wrapper = new QueryWrapper<>();

        PaperRuleDTO params = reqDTO.getParams();
        if(params!=null){
            if(!StringUtils.isEmpty(params.getTitle())){
                wrapper.lambda().like(PaperRule::getTitle, params.getTitle());
            }
        }


        //获得数据
        IPage<PaperRule> page = this.page(query, wrapper);
        //转换结果
        IPage<PaperRuleDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<PaperRuleDTO>>(){});
        return pageData;
     }

    @Override
    public void save(PaperRuleDetailDTO reqDTO) {

        // 保存基本信息
        PaperRule rule = new PaperRule();
        BeanMapper.copy(reqDTO, rule);
        this.saveOrUpdate(rule);

        // 保存引用关系
        paperRuleRepoService.saveAll(rule.getId(), reqDTO.getRepoList());
    }

    @Override
    public PaperRuleDetailDTO detail(String id) {
        PaperRule rule = this.getById(id);

        PaperRuleDetailDTO respDTO = new PaperRuleDetailDTO();
        BeanMapper.copy(rule, respDTO);

        List<PaperRuleRepoDTO> list = paperRuleRepoService.listByRule(id);
        respDTO.setRepoList(list);

        return respDTO;
    }
}
