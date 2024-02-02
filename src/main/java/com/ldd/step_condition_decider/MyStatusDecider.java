package com.ldd.step_condition_decider;

import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.job.flow.FlowExecutionStatus;
import org.springframework.batch.core.job.flow.JobExecutionDecider;

import java.util.Random;

/**
 * @Author ldd
 * @Date 2024/2/1
 */
public class MyStatusDecider implements JobExecutionDecider {
    @Override
    public FlowExecutionStatus decide(JobExecution jobExecution, StepExecution stepExecution) {
        int ret = new Random().nextInt(3);
        if (ret == 0) {
            return new FlowExecutionStatus("A");
        } else if (ret == 1) {
            return new FlowExecutionStatus("B");
        } else {
            return new FlowExecutionStatus("C");
        }
    }
}
