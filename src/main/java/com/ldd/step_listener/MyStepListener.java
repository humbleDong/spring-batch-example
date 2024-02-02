package com.ldd.step_listener;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;

/**
 * @Author ldd
 * @Date 2024/2/1
 */
public class MyStepListener implements StepExecutionListener {
    @Override
    public void beforeStep(StepExecution stepExecution) {
        System.out.println("----------before-step---------");
    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {
        System.out.println("----------after-step---------");
        return stepExecution.getExitStatus();
    }
}
