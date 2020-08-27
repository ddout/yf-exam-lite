package com.yf.exam.modules.paper.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yf.exam.core.annon.AdminInject;
import com.yf.exam.core.api.ApiRest;
import com.yf.exam.core.api.controller.BaseController;
import com.yf.exam.core.api.dto.BaseIdReqDTO;
import com.yf.exam.core.api.dto.BaseIdsReqDTO;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.modules.paper.dto.PaperRuleDTO;
import com.yf.exam.modules.paper.dto.ext.PaperRuleDetailDTO;
import com.yf.exam.modules.paper.entity.PaperRule;
import com.yf.exam.modules.paper.service.PaperRuleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
* <p>
* 试卷规则控制器
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
@Api(tags={"试卷规则"})
@RestController
@RequestMapping("/exam/api/paper/rule")
public class PaperRuleController extends BaseController {

    @Autowired
    private PaperRuleService baseService;

    /**
    * 添加或修改
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "添加或修改")
    @RequestMapping(value = "/save", method = { RequestMethod.POST})
    public ApiRest save(@RequestBody PaperRuleDetailDTO reqDTO) {
        //复制参数
        baseService.save(reqDTO);
        return super.success();
    }

    /**
    * 批量删除
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "批量删除")
    @RequestMapping(value = "/delete", method = { RequestMethod.POST})
    public ApiRest delete(@RequestBody BaseIdsReqDTO reqDTO) {
        //根据ID删除
        baseService.removeByIds(reqDTO.getIds());
        return super.success();
    }

    /**
    * 查找详情
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "查找详情")
    @RequestMapping(value = "/detail", method = { RequestMethod.POST})
    public ApiRest<PaperRuleDetailDTO> find(@RequestBody BaseIdReqDTO reqDTO) {
        PaperRuleDetailDTO dto = baseService.detail(reqDTO.getId());
        return super.success(dto);
    }

    /**
    * 分页查找
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "分页查找")
    @RequestMapping(value = "/paging", method = { RequestMethod.POST})
    public ApiRest<IPage<PaperRuleDTO>> paging(@RequestBody PagingReqDTO<PaperRuleDTO> reqDTO) {

        //分页查询并转换
        IPage<PaperRuleDTO> page = baseService.paging(reqDTO);

        return super.success(page);
    }

    /**
     * 查找列表，每次最多返回200条数据
     * @param reqDTO
     * @return
     */
    @AdminInject
    @ApiOperation(value = "查找列表")
    @RequestMapping(value = "/list", method = { RequestMethod.POST})
    public ApiRest<List<PaperRuleDTO>> list(@RequestBody PaperRuleDTO reqDTO) {

        //分页查询并转换
        QueryWrapper<PaperRule> wrapper = new QueryWrapper<>();

        //转换并返回
        List<PaperRule> list = baseService.list(wrapper);

        //转换数据
        List<PaperRuleDTO> dtoList = BeanMapper.mapList(list, PaperRuleDTO.class);

        return super.success(dtoList);
    }
}
