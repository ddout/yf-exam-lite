package com.yf.exam.modules.sys.log.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.modules.sys.log.dto.SysLogDTO;
import com.yf.exam.modules.sys.log.entity.SysLog;
import com.yf.exam.modules.sys.log.mapper.SysLogMapper;
import com.yf.exam.modules.sys.log.service.SysLogService;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.utils.StringUtils;
import org.springframework.stereotype.Service;

/**
* <p>
* 语言设置 服务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-04-28 10:23
*/
@Service
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

    @Override
    public IPage<SysLogDTO> paging(PagingReqDTO<SysLogDTO> reqDTO) {

        //创建分页对象
        IPage<SysLog> query = reqDTO.toPage();

        //查询条件
        QueryWrapper<SysLog> wrapper = new QueryWrapper<>();

        SysLogDTO params = reqDTO.getParams();

        if(params!=null){
            if(!StringUtils.isBlank(params.getTitle())){
                wrapper.lambda().eq(SysLog::getTitle, params.getTitle());
            }

            if(!StringUtils.isBlank(params.getUserName())){
                wrapper.lambda().eq(SysLog::getUserName, params.getUserName());
            }
        }

        wrapper.lambda().orderByDesc(SysLog::getCreateTime);

        //获得数据
        IPage<SysLog> page = this.page(query, wrapper);
        //转换结果
        IPage<SysLogDTO> pageData = JSON.parseObject(JSON.toJSONString(page), new TypeReference<Page<SysLogDTO>>(){});
        return pageData;
     }
}
