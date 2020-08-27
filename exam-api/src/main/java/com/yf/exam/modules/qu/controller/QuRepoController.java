package com.yf.exam.modules.qu.controller;

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
import com.yf.exam.modules.qu.dto.QuRepoDTO;
import com.yf.exam.modules.qu.dto.request.QuRepoBatchReqDTO;
import com.yf.exam.modules.qu.dto.response.QuRepoRespDTO;
import com.yf.exam.modules.qu.entity.QuRepo;
import com.yf.exam.modules.qu.service.QuRepoRefService;
import com.yf.exam.modules.qu.service.QuRepoService;
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
* 题库控制器
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 13:25
*/
@Api(tags={"题库"})
@RestController
@RequestMapping("/exam/api/qu/repo")
public class QuRepoController extends BaseController {

    @Autowired
    private QuRepoService baseService;

    @Autowired
    private QuRepoRefService quRepoRefService;

    /**
    * 添加或修改
    * @param reqDTO
    * @return
    */
    @AdminInject
    @ApiOperation(value = "添加或修改")
    @RequestMapping(value = "/save", method = { RequestMethod.POST})
    public ApiRest<BaseIdRespDTO> save(@RequestBody QuRepoDTO reqDTO) {
        //复制参数
        QuRepo entity = new QuRepo();
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
    public ApiRest<QuRepoDTO> find(@RequestBody BaseIdReqDTO reqDTO) {
        QuRepo entity = baseService.getById(reqDTO.getId());
        QuRepoDTO dto = new QuRepoDTO();
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
    public ApiRest<IPage<QuRepoRespDTO>> paging(@RequestBody PagingReqDTO<QuRepoDTO> reqDTO) {

        //分页查询并转换
        IPage<QuRepoRespDTO> page = baseService.paging(reqDTO);

        return super.success(page);
    }

    /**
     * 批量操作
     * @param reqDTO
     * @return
     */
    @AdminInject
    @ApiOperation(value = "批量操作", notes = "批量加入或从题库移除")
    @RequestMapping(value = "/batch-action", method = { RequestMethod.POST})
    public ApiRest paging(@RequestBody QuRepoBatchReqDTO reqDTO) {

        //分页查询并转换
        quRepoRefService.batchAction(reqDTO);
        return super.success();
    }

    /**
     * 查找列表，每次最多返回200条数据
     * @param reqDTO
     * @return
     */
    @AdminInject
    @ApiOperation(value = "查找列表")
    @RequestMapping(value = "/list", method = { RequestMethod.POST})
    public ApiRest<List<QuRepoDTO>> list(@RequestBody QuRepoDTO reqDTO) {

        //分页查询并转换
        QueryWrapper<QuRepo> wrapper = new QueryWrapper<>();

        //转换并返回
        List<QuRepo> list = baseService.list(wrapper);

        //转换数据
        List<QuRepoDTO> dtoList = BeanMapper.mapList(list, QuRepoDTO.class);

        return super.success(dtoList);
    }
}
