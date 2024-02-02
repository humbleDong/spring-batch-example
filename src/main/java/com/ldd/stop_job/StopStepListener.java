package com.ldd.stop_job;

import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;

/**
 * @Author ldd
 * @Date 2024/2/1
 */
public class StopStepListener implements StepExecutionListener {
    @Override
    public void beforeStep(StepExecution stepExecution) {

    }

    @Override
    public ExitStatus afterStep(StepExecution stepExecution) {

        if (ResourceCount.readCount != ResourceCount.totalCount) {
            return ExitStatus.STOPPED;
        }

        return stepExecution.getExitStatus();
    }
}
