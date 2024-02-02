package com.ldd.params_validator;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.job.CompositeJobParametersValidator;
import org.springframework.batch.core.job.DefaultJobParametersValidator;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Arrays;

@SpringBootApplication
@EnableBatchProcessing
public class ParamsValidatorJob {

    //job调度器
    @Autowired
    private JobLauncher jobLauncher;
    //job构造器工厂
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    //step构造器工厂
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    //任务-step执行逻辑由tasklet完成
    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("params-name:"+chunkContext.getStepContext().getJobParameters().get("name"));
                System.out.println("params-age:"+chunkContext.getStepContext().getJobParameters().get("age"));
                return RepeatStatus.FINISHED;
            }
        };
    }
    //作业步骤-不带读/写/处理
    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }

    //配置name参数校验器
    @Bean
    public NameParamsValidator validator(){
        return new NameParamsValidator();
    }


    //配置默认参数校验器
    @Bean
    public DefaultJobParametersValidator defaultJobParametersValidator(){
        DefaultJobParametersValidator validator = new DefaultJobParametersValidator();
        validator.setRequiredKeys(new String[]{"name"}); //必填
        validator.setOptionalKeys(new String[]{"age"}); //可选
        return  validator;
    }

    //配置组合参数校验器
    @Bean
    public CompositeJobParametersValidator compositeJobParametersValidator(){
        CompositeJobParametersValidator validator = new CompositeJobParametersValidator();
        //默认参数校验器
        DefaultJobParametersValidator defaultJobParametersValidator = new DefaultJobParametersValidator();
        defaultJobParametersValidator.setRequiredKeys(new String[]{"name"}); //必填
        defaultJobParametersValidator.setOptionalKeys(new String[]{"age"}); //可选
        //name参数校验器
        NameParamsValidator nameParamsValidator = new NameParamsValidator();//name 不能为空
        //按照传入的顺序，先执行defaultJobParametersValidator 后执行nameParamsValidator
        validator.setValidators(Arrays.asList(defaultJobParametersValidator, nameParamsValidator));
        //判断校验器是否为null
        try {
            validator.afterPropertiesSet();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return validator;
    }


    //定义作业
//    @Bean
//    public Job job(){
//        return jobBuilderFactory.get("params-validator-job")
//                .start(step1())
//                .validator(validator())  //定制参数校验器
//                .build();
//    }


/*        @Bean
    public Job job(){
        return jobBuilderFactory.get("default-params-validator-job")
                .start(step1())
                .validator(defaultJobParametersValidator())  //默认参数校验器
                .build();
    }*/

    @Bean
    public Job job(){
        return jobBuilderFactory.get("composite-param-validator-job")
                .start(step1())
                .validator(compositeJobParametersValidator())  //默认参数校验器
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(ParamsValidatorJob.class, args);
    }

}
