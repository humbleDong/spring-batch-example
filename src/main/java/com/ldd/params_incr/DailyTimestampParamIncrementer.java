package com.ldd.params_incr;

import org.springframework.batch.core.JobParameters;
import org.springframework.batch.core.JobParametersBuilder;
import org.springframework.batch.core.JobParametersIncrementer;

import java.util.Date;

/**
 * @Author ldd
 * @Date 2024/1/31
 * //以时间戳为参数增量器
 */
public class DailyTimestampParamIncrementer implements JobParametersIncrementer {
    @Override
    public JobParameters getNext(JobParameters jobParameters) {
        return new JobParametersBuilder()
                .addLong("daily",new Date().getTime())
                .toJobParameters();
    }
}
