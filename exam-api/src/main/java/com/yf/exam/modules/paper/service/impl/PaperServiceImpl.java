package com.yf.exam.modules.paper.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yf.exam.core.api.dto.PagingReqDTO;
import com.yf.exam.core.exception.ServiceException;
import com.yf.exam.core.utils.BeanMapper;
import com.yf.exam.core.utils.StringUtils;
import com.yf.exam.modules.exam.entity.Exam;
import com.yf.exam.modules.exam.service.ExamService;
import com.yf.exam.modules.paper.dto.PaperDTO;
import com.yf.exam.modules.paper.dto.PaperQuDTO;
import com.yf.exam.modules.paper.dto.PaperRuleRepoDTO;
import com.yf.exam.modules.paper.dto.ext.PaperQuAnswerExtDTO;
import com.yf.exam.modules.paper.dto.ext.PaperQuDetailDTO;
import com.yf.exam.modules.paper.dto.request.PaperAnswerDTO;
import com.yf.exam.modules.paper.dto.response.ExamDetailRespDTO;
import com.yf.exam.modules.paper.dto.response.ExamResultRespDTO;
import com.yf.exam.modules.paper.dto.response.PaperPagingRespDTO;
import com.yf.exam.modules.paper.entity.Paper;
import com.yf.exam.modules.paper.entity.PaperQu;
import com.yf.exam.modules.paper.entity.PaperQuAnswer;
import com.yf.exam.modules.paper.entity.PaperRule;
import com.yf.exam.modules.paper.enums.PaperState;
import com.yf.exam.modules.paper.mapper.PaperMapper;
import com.yf.exam.modules.paper.service.PaperQuAnswerService;
import com.yf.exam.modules.paper.service.PaperQuService;
import com.yf.exam.modules.paper.service.PaperRuleRepoService;
import com.yf.exam.modules.paper.service.PaperRuleService;
import com.yf.exam.modules.paper.service.PaperService;
import com.yf.exam.modules.qu.entity.Qu;
import com.yf.exam.modules.qu.entity.QuAnswer;
import com.yf.exam.modules.qu.enums.QuType;
import com.yf.exam.modules.qu.service.QuAnswerService;
import com.yf.exam.modules.qu.service.QuService;
import com.yf.exam.modules.sys.user.service.SysUserRoleService;
import com.yf.exam.modules.user.service.UserWrongBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
* <p>
* 语言设置 服务实现类
* </p>
*
* @author 聪明笨狗
* @since 2020-05-25 16:33
*/
@Service
public class PaperServiceImpl extends ServiceImpl<PaperMapper, Paper> implements PaperService {

    @Autowired
    private SysUserRoleService sysUserRoleService;

    @Autowired
    private PaperRuleService paperRuleService;

    @Autowired
    private ExamService examService;

    @Autowired
    private PaperRuleRepoService paperRuleRepoService;

    @Autowired
    private QuService quService;

    @Autowired
    private QuAnswerService quAnswerService;

    @Autowired
    private PaperService paperService;

    @Autowired
    private PaperQuService paperQuService;

    @Autowired
    private PaperQuAnswerService paperQuAnswerService;

    @Autowired
    private UserWrongBookService userWrongBookService;

    /**
     * 展示的选项，ABCD这样
     */
    private static List<String> ABC = Arrays.asList(new String[]{
            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K","L","M","N","O","P","Q","R","S","T","U","V","W","X"
            ,"Y","Z"
    });


    @Override
    public String createPaper(String userId, String examId) {

        // 查找考试
        Exam exam = examService.getById(examId);

        if(exam == null){
            throw new ServiceException(1, "考试不存在！");
        }

        //查找规则
        PaperRule rule = paperRuleService.getById(exam.getRuleId());

        if(rule == null){
            throw new ServiceException(1, "考试规则不存在，请联系管理员！");
        }

        //查找规则选定的题库
        List<PaperQu> quList = this.generateQuListByRule(rule);

        if(CollectionUtils.isEmpty(quList)){
            throw new ServiceException(1, "规则不正确，无对应的考题！");
        }

        //保存试卷内容
        String paperId = this.savePaper(userId, examId, rule, quList);

        return paperId;
    }

    @Override
    public ExamDetailRespDTO paperDetail(String paperId) {


        ExamDetailRespDTO respDTO = new ExamDetailRespDTO();

        // 试题基本信息
        Paper paper = paperService.getById(paperId);
        BeanMapper.copy(paper, respDTO);

        // 查找题目列表
        List<PaperQuDTO> list = paperQuService.listByPaper(paperId);

        List<PaperQuDTO> radioList = new ArrayList<>();
        List<PaperQuDTO> multiList = new ArrayList<>();
        for(PaperQuDTO item: list){
            if(QuType.RADIO.equals(item.getQuType())){
                radioList.add(item);
            }
            if(QuType.MULTI.equals(item.getQuType())){
                multiList.add(item);
            }
        }

        respDTO.setRadioList(radioList);
        respDTO.setMultiList(multiList);
        return respDTO;
    }

    @Override
    public ExamResultRespDTO paperResult(String paperId) {

        ExamResultRespDTO respDTO = new ExamResultRespDTO();

        // 试题基本信息
        Paper paper = paperService.getById(paperId);
        BeanMapper.copy(paper, respDTO);

        List<PaperQuDetailDTO> quList = paperQuService.listForPaperResult(paperId);
        respDTO.setQuList(quList);

        return respDTO;
    }

    @Override
    public PaperQuDetailDTO findQuDetail(String paperId, String quId) {

        PaperQuDetailDTO respDTO = new PaperQuDetailDTO();
        // 问题
        Qu qu = quService.getById(quId);

        // 基本信息
        PaperQu paperQu = paperQuService.findByKey(paperId, quId);
        BeanMapper.copy(paperQu, respDTO);
        respDTO.setContent(qu.getContent());
        respDTO.setImage(qu.getImage());
        respDTO.setVideo(qu.getVideo());

        // 答案列表
        List<PaperQuAnswerExtDTO> list = paperQuAnswerService.listForExam(paperId, quId);
        respDTO.setAnswerList(list);

        return respDTO;
    }


    /**
     * 根据规则查找生成题目列表
     * @param rule
     * @return
     */
    private List<PaperQu> generateQuListByRule(PaperRule rule){

        // 查找规则指定的题库
        List<PaperRuleRepoDTO> list = paperRuleRepoService.listByRule(rule.getId());

        //最终的题目列表
        List<PaperQu> quList = new ArrayList<>();

        //排除ID，避免题目重复
        List<String> excludes = new ArrayList<>();
        excludes.add("none");

        if (!CollectionUtils.isEmpty(list)) {
            for (PaperRuleRepoDTO item : list) {

                // 单选题
                if(item.getRadioCount() > 0){
                    List<Qu> radioList = quService.listByRandom(item.getRepoId(), QuType.RADIO, excludes, item.getRadioCount());
                    for (Qu qu : radioList) {
                        PaperQu paperQu = this.processPaperQu(item, qu);
                        quList.add(paperQu);
                        excludes.add(qu.getId());
                    }
                }

                //多选题
                if(item.getMultiCount() > 0) {
                    List<Qu> multiList = quService.listByRandom(item.getRepoId(), QuType.MULTI, excludes, item.getMultiCount());
                    for (Qu qu : multiList) {
                        PaperQu paperQu = this.processPaperQu(item, qu);
                        quList.add(paperQu);
                        excludes.add(qu.getId());
                    }
                }

            }
        }
        return quList;
    }

    /**
     * 填充试题题目信息
     * @param repo
     * @param qu
     * @return
     */
    private PaperQu processPaperQu(PaperRuleRepoDTO repo, Qu qu) {

        //保存试题信息
        PaperQu paperQu = new PaperQu();
        paperQu.setQuId(qu.getId());
        paperQu.setAnswered(false);
        paperQu.setIsRight(false);
        paperQu.setQuType(qu.getQuType());

        if (QuType.RADIO.equals(qu.getQuType())) {
            paperQu.setScore(repo.getRadioScore());
            paperQu.setActualScore(repo.getRadioScore());
        }

        if (QuType.MULTI.equals(qu.getQuType())) {
            paperQu.setScore(repo.getMultiScore());
            paperQu.setActualScore(repo.getMultiScore());
        }


        return paperQu;
    }


    /**
     * 保存试卷
     * @param userId
     * @param rule
     * @param quList
     * @return
     */
    private String savePaper(String userId, String examId, PaperRule rule, List<PaperQu> quList) {

        //保存试卷基本信息
        Paper paper = new Paper();
        paper.setExamId(examId);
        paper.setTitle(rule.getTitle());
        paper.setTotalScore(rule.getTotalScore());
        paper.setTotalTime(rule.getTotalTime());
        paper.setUserScore(0);
        paper.setUserId(userId);
        paper.setCreateTime(new Date());
        paper.setUpdateTime(new Date());
        paper.setQualifyScore(rule.getQualifyScore());
        paper.setState(PaperState.ING);
        paper.setHasSaq(false);

        paperService.save(paper);

        if (!CollectionUtils.isEmpty(quList)) {
            this.savePaperQu(paper.getId(), quList);
        }

        return paper.getId();
    }


    /**
     * 保存试卷试题列表
     * @param paperId
     * @param quList
     */
    private void savePaperQu(String paperId, List<PaperQu> quList){

        List<PaperQu> batchQuList = new ArrayList<>();
        List<PaperQuAnswer> batchAnswerList = new ArrayList<>();

        int sort = 0;
        for (PaperQu item : quList) {

            item.setPaperId(paperId);
            item.setSort(sort);
            item.setId(UUID.randomUUID().toString());

            //回答列表
            List<QuAnswer> answerList = quAnswerService.listAnswerByRandom(item.getQuId());

            if (!CollectionUtils.isEmpty(answerList)) {

                int ii = 0;
                for (QuAnswer answer : answerList) {
                    PaperQuAnswer paperQuAnswer = new PaperQuAnswer();
                    paperQuAnswer.setId(UUID.randomUUID().toString());
                    paperQuAnswer.setPaperId(paperId);
                    paperQuAnswer.setQuId(answer.getQuId());
                    paperQuAnswer.setAnswerId(answer.getId());
                    paperQuAnswer.setChecked(false);
                    paperQuAnswer.setSort(ii);
                    paperQuAnswer.setAbc(ABC.get(ii));
                    paperQuAnswer.setIsRight(answer.getIsRight());
                    ii++;
                    batchAnswerList.add(paperQuAnswer);
                }
            }

            batchQuList.add(item);
            sort++;
        }

        //添加问题
        paperQuService.saveBatch(batchQuList);

        //批量添加问题答案
        paperQuAnswerService.saveBatch(batchAnswerList);
    }

    @Override
    public void fillAnswer(PaperAnswerDTO reqDTO) {


        // 未作答
        if(CollectionUtils.isEmpty(reqDTO.getAnswers()) && StringUtils.isBlank(reqDTO.getAnswer())){
            return;
        }

        //查找答案列表
        List<PaperQuAnswer> list = paperQuAnswerService.listForFill(reqDTO.getPaperId(), reqDTO.getQuId());

        //是否正确
        boolean right = true;

        //更新正确答案
        for (PaperQuAnswer item : list) {

            if (reqDTO.getAnswers().contains(item.getId())) {
                item.setChecked(true);
            } else {
                item.setChecked(false);
            }

            //有一个对不上就是错的
            if (item.getIsRight()!=null && !item.getIsRight().equals(item.getChecked())) {
                right = false;
            }
            paperQuAnswerService.updateById(item);
        }

        //修改为已回答
        PaperQu qu = new PaperQu();
        qu.setQuId(reqDTO.getQuId());
        qu.setPaperId(reqDTO.getPaperId());
        qu.setIsRight(right);
        qu.setAnswer(reqDTO.getAnswer());
        qu.setAnswered(true);

        paperQuService.updateByKey(qu);

    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void handExam(String paperId) {

        //获取试卷信息
        Paper paper = paperService.getById(paperId);

        //如果不是正常的，抛出异常
        if(!PaperState.ING.equals(paper.getState())){
            throw new ServiceException(1, "试卷状态不正确！");
        }

        // 客观分
        int objScore = paperQuService.sumObjective(paperId);
        paper.setObjScore(objScore);
        paper.setUserScore(objScore);

        // 主观分，因为要阅卷，所以给0
        paper.setSubjScore(0);

        // 待阅卷
        if(paper.getHasSaq()) {
            paper.setState(PaperState.WAIT_OPT);
        }else {
            paper.setState(PaperState.FINISHED);
        }
        paper.setUpdateTime(new Date());

        //计算考试时长
        Calendar cl = Calendar.getInstance();
        cl.setTimeInMillis(System.currentTimeMillis());
        int userTime = (int)((System.currentTimeMillis() - paper.getCreateTime().getTime()) / 1000 / 60);
        paper.setUserTime(userTime);

        //更新试卷
        paperService.updateById(paper);

        //把打错的问题加入错题本
        List<PaperQuDTO> list = paperQuService.listByPaper(paperId);
        for(PaperQuDTO qu: list){
            // 主观题和对的都不加入错题库
            if(qu.getIsRight().equals(1L)){
                continue;
            }
            //加入错题本
            userWrongBookService.addBook(paper.getUserId(), qu.getQuId());
        }
    }

    @Override
    public IPage<PaperPagingRespDTO> paging(PagingReqDTO<PaperDTO> reqDTO) {

        //创建分页对象
        Page page = new Page(reqDTO.getCurrent(), reqDTO.getSize());

        // 查询参数
        PaperDTO query = reqDTO.getParams();

        // 用户
        String userId = reqDTO.getUserId();

        // 学生只能看自己的试卷
        boolean student = sysUserRoleService.isStudent(userId);
        if(student){
            query.setUserId(userId);
        }

        //转换结果
        IPage<PaperPagingRespDTO> pageData = baseMapper.paging(page, reqDTO.getParams());
        return pageData;
     }
}
