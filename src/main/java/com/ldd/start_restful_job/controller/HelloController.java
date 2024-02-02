package com.ldd.start_restful_job.controller;

import org.springframework.batch.core.*;
import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private Job job;
    @Autowired
    private JobExplorer jobExplorer;  //job 展示对象

    @GetMapping("/job/start/{name}")
    public ExitStatus start(@PathVariable String name) throws Exception {
        System.err.println("参数name："+name);
        //启动job作业
        JobParameters jp = new JobParametersBuilder(jobExplorer)
                .getNextJobParameters(job)
                .addString("name", name)
                .toJobParameters();
        JobExecution jobExet = jobLauncher.run(job, jp);
        return jobExet.getExitStatus();
    }

    //http://localhost:8080/job/start
    @GetMapping("/job/start")
    public ExitStatus start() throws Exception {
        System.out.println("------------------");
        //启动job作业
        JobExecution jobExet = jobLauncher.run(job, new JobParameters());
        return jobExet.getExitStatus();
    }

}