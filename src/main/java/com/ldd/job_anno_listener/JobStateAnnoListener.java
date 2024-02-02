package com.ldd.job_anno_listener;

import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.annotation.AfterJob;
import org.springframework.batch.core.annotation.BeforeJob;

/**
 * @Author ldd
 * @Date 2024/1/31
 * 作业状态：注解方式
 */
public class JobStateAnnoListener {
    //作业执行之前
    @BeforeJob
    public void beforeJob(JobExecution jobExecution) {
        System.err.println("作业执行前的状态："+jobExecution.getStatus());
    }
    //作业执行之后
    @AfterJob
    public void afterJob(JobExecution jobExecution) {
        System.err.println("作业执行后的状态："+jobExecution.getStatus());
    }
}
