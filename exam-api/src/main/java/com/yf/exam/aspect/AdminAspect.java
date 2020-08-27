package com.yf.exam.aspect;

import com.yf.exam.aspect.utils.InjectUtils;
import com.yf.exam.modules.sys.user.dto.response.SysUserLoginDTO;
import com.yf.exam.modules.sys.user.service.SysUserService;
import com.yf.exam.core.annon.AdminInject;
import com.yf.exam.core.exception.ServiceException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

import static org.slf4j.LoggerFactory.getLogger;

/**
 * 注入当前登录用户信息
 * @author bool
 */
@Aspect
@Component
public class AdminAspect {

    private static final Logger logger = getLogger(AdminAspect.class);

    @Autowired
    private InjectUtils injectUtils;

    @Autowired
    private SysUserService sysUserService;

    @Autowired(required = false)
    private HttpServletRequest request;

    @Autowired(required = false)
    private HttpServletResponse response;

    @Around("@annotation(com.yf.exam.core.annon.AdminInject)")
    public Object aroundAdvice(ProceedingJoinPoint jp) throws Throwable {

        logger.info("++++拦截并获取信息");

        Method method = ((MethodSignature) jp.getSignature()).getMethod();

        //解析获取商家编号并且校验商家编号和店铺注解
        AdminInject ann = method.getAnnotation(AdminInject.class);

        //接口参数
        Object[] params = jp.getArgs();

        //从Token中获取
        String token = request.getHeader("token");
        SysUserLoginDTO respDTO = null;
        try {
            respDTO = sysUserService.token(token);
        }catch (ServiceException e){
            //只有必须
        }

        //获取请求头的token
        if(respDTO == null && ann.required()){
            injectUtils.restError(response);
            return null;
        }

        if(respDTO!=null){
            if(params!=null && params.length>ann.index()){
                if(ann.ids()!=null && ann.ids().length>0) {
                    injectUtils.setValue(params[ann.index()], respDTO.getId(), ann.ids());
                }
                if(ann.names()!=null && ann.names().length>0) {
                    injectUtils.setValue(params[ann.index()], respDTO.getUserName(), ann.names());
                }
            }
        }

        return jp.proceed(params);
    }

}
