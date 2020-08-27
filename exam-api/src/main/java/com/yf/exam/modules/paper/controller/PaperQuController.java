package com.yf.exam.modules.paper.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.yf.exam.core.annon.AdminInject;
import com.yf.exam.core.api.ApiRest;
import com.yf.exam.core.api.controller.BaseController;
import com.yf.exam.core.api.dto.BaseIdReqDTO;
import com.yf.exam.core.api.dto.BaseIdRespDTO;
import com.yf.exam.core.api.dto.BaseIdsReqDTO;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.modules.paper.dto.PaperQuDTO;
import com.yf.exam.modules.paper.entity.PaperQu;
import com.yf.exam.modules.paper.service.PaperQuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
* <p>
* 试卷考题控制器
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
@Api(tags={"试卷考题"})
@RestController
@RequestMapping("/exam/api/paper/paper-qu")
public class PaperQuController extends BaseController {

    @Autowired
    private PaperQuService baseService;

    /**
    * 添加或修改
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "添加或修改")
    @RequestMapping(value = "/save", method = { RequestMethod.POST})
    public ApiRest<BaseIdRespDTO> save(@RequestBody PaperQuDTO reqDTO) {
        //复制参数
        PaperQu entity = new PaperQu();
        BeanMapper.copy(reqDTO, entity);
        baseService.saveOrUpdate(entity);
        return super.success(new BaseIdRespDTO(entity.getId()));
    }

    /**
    * 批量删除
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "批量删除")
    @RequestMapping(value = "/delete", method = { RequestMethod.POST})
    public ApiRest edit(@RequestBody BaseIdsReqDTO reqDTO) {
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
    public ApiRest<PaperQuDTO> find(@RequestBody BaseIdReqDTO reqDTO) {
        PaperQu entity = baseService.getById(reqDTO.getId());
        PaperQuDTO dto = new PaperQuDTO();
        BeanUtils.copyProperties(entity, dto);
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
    public ApiRest<IPage<PaperQuDTO>> paging(@RequestBody PagingReqDTO<PaperQuDTO> reqDTO) {

        //分页查询并转换
        IPage<PaperQuDTO> page = baseService.paging(reqDTO);

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
    public ApiRest<List<PaperQuDTO>> list(@RequestBody PaperQuDTO reqDTO) {

        //分页查询并转换
        QueryWrapper<PaperQu> wrapper = new QueryWrapper<>();

        //转换并返回
        List<PaperQu> list = baseService.list(wrapper);

        //转换数据
        List<PaperQuDTO> dtoList = BeanMapper.mapList(list, PaperQuDTO.class);

        return super.success(dtoList);
    }
}
