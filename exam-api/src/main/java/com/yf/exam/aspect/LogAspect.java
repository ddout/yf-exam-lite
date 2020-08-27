package com.yf.exam.aspect;

import com.alibaba.fastjson.JSON;
import com.yf.exam.core.annon.LogInject;
import com.yf.exam.core.exception.ServiceException;
import com.yf.exam.core.utils.IpUtils;
import com.yf.exam.core.utils.StringUtils;
import com.yf.exam.modules.sys.log.entity.SysLog;
import com.yf.exam.modules.sys.log.service.SysLogService;
import com.yf.exam.modules.sys.user.dto.request.SysUserLoginReqDTO;
import com.yf.exam.modules.sys.user.dto.response.SysUserLoginDTO;
import com.yf.exam.modules.sys.user.service.SysUserService;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * 日志过滤
 * @author bool
 */
@Aspect
@Component
public class LogAspect {

    private static final Logger logger = getLogger(LogAspect.class);

    @Autowired
    private SysUserService sysUserService;

    @Autowired
    private SysLogService sysLogService;

    @Autowired(required = false)
    private HttpServletRequest request;

    private static final String LOGIN_NAME = "login";


    @Around("@annotation(com.yf.exam.core.annon.LogInject)")
    public Object aroundAdvice(ProceedingJoinPoint jp) throws Throwable {

        logger.info("++++注入操作日志信息");

        // 日志本体
        SysLog log = new SysLog();

        // IP地址
        String ip = IpUtils.extractClientIp(request);
        log.setIp(ip);

        Method method = ((MethodSignature) jp.getSignature()).getMethod();

        //接口参数
        Object[] params = jp.getArgs();

        //解析注入信息
        LogInject ann = method.getAnnotation(LogInject.class);
        log.setTitle(ann.title());

        // 方法名称
        String name = method.getName();

        // 如果是登录方法
        if(LOGIN_NAME.equals(name)){
            SysUserLoginReqDTO loginDTO = (SysUserLoginReqDTO)params[0];
            log.setUserName(loginDTO.getUsername());
        }else{

            //从Token中获取
            String token = request.getHeader("token");
            if(!StringUtils.isBlank(token)){
                // 获取登录信息
                try {
                    SysUserLoginDTO respDTO = sysUserService.token(token);
                    log.setUserId(respDTO.getId());
                    log.setUserName(respDTO.getUserName());
                }catch (ServiceException e){

                }
            }
        }

        // 记录数据
        log.setData(JSON.toJSONString(params));
        log.setCreateTime(new Date());

        // 保存数据库
        sysLogService.save(log);

        return jp.proceed(params);
    }

}
