package com.example.frame.common.exception.handler;


import cn.dev33.satoken.exception.NotLoginException;
import cn.dev33.satoken.exception.NotPermissionException;
import cn.dev33.satoken.exception.NotRoleException;
import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.IPUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@RestControllerAdvice
@Slf4j
public class RestExceptionHandler {

    /**
     * 系统繁忙，请稍候再试"
     *
     * @return com.xh.lesson.utils.DataResult<T>
     */
    @ExceptionHandler(Exception.class)
    public <T> DataResult<T> handleException(Exception e) {
        log.error("Exception,exception:{}", e);
        return DataResult.getResult(BaseResponseCode.SYSTEM_BUSY);
    }

    /**
     * 缺少请求参数异常
     *
     * @param ex HttpMessageNotReadableException
     */
    @ExceptionHandler(MissingServletRequestParameterException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public <T> DataResult<T> handleHttpMessageNotReadableException(
            MissingServletRequestParameterException ex) {
        log.error("缺少请求参数，{}", ex.getMessage());
        return DataResult.getResult(BaseResponseCode.BAD_REQUEST);
    }

    /**
     * 空指针异常
     *
     * @param ex NullPointerException
     */
    @ExceptionHandler(NullPointerException.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public <T> DataResult<T> handleTypeMismatchException(NullPointerException ex) {
        log.error("空指针异常，{}", ex);
        return DataResult.getResult(BaseResponseCode.INTERNAL_SERVER_ERROR);
    }


    /**
     * 自定义全局异常处理
     *
     * @return com.xh.lesson.utils.DataResult<T>
     */
    @ExceptionHandler(value = BusinessException.class)
    <T> DataResult<T> businessExceptionHandler(BusinessException e) {
        log.error("BusinessException,exception:{}", e);
        return new DataResult<>(e.getMessageCode(), e.getDetailMessage());
    }

    /**
     * 处理validation 框架异常
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    <T> DataResult<T> methodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        log.error(
                "methodArgumentNotValidExceptionHandler bindingResult.allErrors():{},exception:{}",
                e.getBindingResult().getAllErrors(),
                e);
        List<ObjectError> errors = e.getBindingResult().getAllErrors();
        return createValidExceptionResp(errors);
    }

    private <T> DataResult<T> createValidExceptionResp(List<ObjectError> errors) {
        String[] msgs = new String[errors.size()];
        int i = 0;
        for (ObjectError error : errors) {
            msgs[i] = error.getDefaultMessage();
            log.info("msg={}", msgs[i]);
            i++;
        }
        return DataResult.getResult(
                BaseResponseCode.METHODARGUMENTNOTVALIDEXCEPTION.getCode(), msgs[0]);
    }


    @ExceptionHandler(NotRoleException.class)
    public <T> DataResult<T> handlerNotRoleException(NotRoleException nre, HttpServletRequest request, HttpServletResponse response) {
        try {
            BufferedReader reader = request.getReader();
            log.error(
                    "sa-token拦截Ip{}，接口地址{}，请求方式{}，入参：{}",
                    IPUtils.getIpAddr(request),
                    request.getRequestURL(),
                    request.getMethod(),
                    reader.readLine(),
                    nre.getMessage(),
                    nre);
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 返回给前端
        return DataResult.getResult(BaseResponseCode.UNAUTHORIZED_ERROR);
    }


    @ExceptionHandler(NotLoginException.class)
    public <T> DataResult<T> handlerNotLoginException(NotLoginException nre, HttpServletRequest request, HttpServletResponse response) {
        log.error(nre.getMessage());
        // 返回给前端
        return DataResult.getResult(BaseResponseCode.TOKEN_PARSE_ERROR);
    }


    @ExceptionHandler(NotPermissionException.class)
    public <T> DataResult<T> handlerNotPermissionException(NotPermissionException nre, HttpServletRequest request, HttpServletResponse response) {
        try {
            BufferedReader reader = request.getReader();
            log.error(
                    "sa-token拦截Ip{}，接口地址{}，请求方式{}，入参：{}",
                    IPUtils.getIpAddr(request),
                    request.getRequestURL(),
                    request.getMethod(),
                    reader.readLine(),
                    nre.getMessage(),
                    nre);
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 返回给前端
        return DataResult.getResult(BaseResponseCode.UNAUTHORIZED_ERROR);
    }

    @ExceptionHandler(UncategorizedSQLException.class)
    public <T> DataResult<T> UncategorizedSQLException(UncategorizedSQLException nre, HttpServletRequest request, HttpServletResponse response) {
        // 返回给前端
        return new DataResult(BaseResponseCode.SQL_ERROR, nre.getSQLException().getMessage());
    }


}
