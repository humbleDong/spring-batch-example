package com.ldd.job_anno_listener;

/**
 * @Author ldd
 * @Date 2024/1/31
 */
import com.ldd.job_listener.JobStateListener;
import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.listener.JobListenerFactoryBean;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;


@SpringBootApplication
@EnableBatchProcessing
public class StatusListenerAnnoJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                //通过步骤去拿到这个job执行对象然后拿到执行中的状态
                JobExecution jobExecution = contribution.getStepExecution().getJobExecution();
                System.err.println("执行中的状态："+jobExecution.getStatus());
                return RepeatStatus.FINISHED;
            }
        };
    }

//    //创建监听器交给容器管理
//    @Bean
//    public JobStateAnnoListener jobStateAnnoListener(){
//        return new JobStateAnnoListener();
//    }


    @Bean
    public Step step1(){
        return  stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-state-anno-listener-job")
                .start(step1())
                //.listener(jobStateAnnoListener())  //第一种方式，像我们以前的常规套路
                //下面这种方式就是使用beanFactory去创建，无需在上面注入bean
                .listener(JobListenerFactoryBean.getListener(new JobStateAnnoListener()))
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(StatusListenerAnnoJob.class, args);
    }
}
