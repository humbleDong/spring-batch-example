package com.ldd.params_validator;

import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersInvalidException;
import org.springframework.batch.core.JobParametersValidator;
import org.springframework.util.StringUtils;

/**
 * @Author ldd
 * @Date 2024/1/31
 * 进行name参数校验
 * 规则：当name的值为null或者空串""，校验不通过，抛出异常
 */
public class NameParamsValidator implements JobParametersValidator {
    @Override
    public void validate(JobParameters jobParameters) throws JobParametersInvalidException {
        String name = jobParameters.getString("name");
        if (!StringUtils.hasText(name)){
            throw new JobParametersInvalidException("name 参数值不能为null或者空串 ");
        }
    }
}
