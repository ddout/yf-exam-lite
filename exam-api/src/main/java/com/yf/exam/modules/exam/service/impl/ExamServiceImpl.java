package com.yf.exam.modules.exam.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.exception.ServiceException;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.core.utils.StringUtils;
import com.yf.exam.modules.exam.dto.ExamDTO;
import com.yf.exam.modules.exam.dto.response.ExamRespDTO;
import com.yf.exam.modules.exam.entity.Exam;
import com.yf.exam.modules.exam.mapper.ExamMapper;
import com.yf.exam.modules.exam.service.ExamService;
import com.yf.exam.modules.paper.entity.PaperRule;
import com.yf.exam.modules.paper.service.PaperRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* <p>
* 考试业务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-07-25 16:18
*/
@Service
public class ExamServiceImpl extends ServiceImpl<ExamMapper, Exam> implements ExamService {


    @Autowired
    private PaperRuleService paperRuleService;

    @Override
    public void save(ExamDTO reqDTO) {

        // ID
        String id = reqDTO.getId();

        //复制参数
        Exam entity = new Exam();
        BeanMapper.copy(reqDTO, entity);

        // 新增复制参数
        if(StringUtils.isBlank(id)){
           PaperRule rule = paperRuleService.getById(reqDTO.getRuleId());
           if(rule == null){
               throw new ServiceException(1 , "考试规则不存在！");
           }

           entity.setObjScore(rule.getObjScore());
           entity.setSubjScore(rule.getSubjScore());
           entity.setTotalScore(rule.getTotalScore());
           entity.setTotalTime(rule.getTotalTime());
           entity.setQualifyScore(rule.getQualifyScore());
        }

        this.saveOrUpdate(entity);

    }

    @Override
    public IPage<ExamRespDTO> paging(PagingReqDTO<ExamDTO> reqDTO) {

        //创建分页对象
        Page page = new Page(reqDTO.getCurrent(), reqDTO.getSize());

        //转换结果
        IPage<ExamRespDTO> pageData = baseMapper.paging(page, reqDTO.getParams());
        return pageData;
     }
}
