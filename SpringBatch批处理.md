# SpringBatch

## SpringBatch简介

### 什么是批处理？

什么是批处理，简单点：就是将数据分批次进行处理的过程，例如：银行对账逻辑，跨系统数据同步等。

常规的批处理操作步骤：**系统A从数据库中导出数据到文件，系统B读取文件数据并写入到数据库。**

![image-20240130153212320](https://s2.loli.net/2024/01/30/csdCGL3m5RA2gbS.png)

典型批处理的特点：

- 自动执行，根据系统设定的工作步骤自动完成
- 数据量大，少则百万，多则上千万甚至上亿。（如果是10亿，100亿那就只能上大数据了）
- 定时执行，比如：每天，每周，每月执行。







### SpringBatch了解

中文官网：(https://springdoc.cn/spring-batch/)

- SpringBatch是一个轻量级的、完善的批处理框架，旨在帮助企业建立健壮、高效的批处理应用。
- SpringBatch是Spring的一个子项目，基于Spring框架为基础的开发的框架
- SpringBatch提供大量可重用的组件，比如：日志，追踪，事务，任务作业统计，任务重启，跳过，重复，资源管理器等。
- SpringBatch是一个批处理应用框架，不提供调度框架，如果需要定时处理需要额外引入调度框架，比如：Quartz。







### SpringBatch优势

SpringBatch框架通过提供丰富的开箱即用的组件和高可靠性，高扩展性的能力，使得开发批处理应用的人员专注于业务处理，提高处理应用的开发能力，下面就是使用SpringBatch后获取到优势：

- 丰富的开箱即用组件
- 面向Chunk的处理
- 事务管理能力
- 元数据管理
- 易监控的批处理应用
- 丰富的流程定义
- 健壮的批处理应用
- 易扩展的批处理应用
- 复用企业现有的IT代码







### SpringBatch架构

SpringBatch核心架构分为三层，应用层，核心层，基础架构层

![image-20240130154317888](https://s2.loli.net/2024/01/30/LY8kS3sGHIiPy1g.png)



Application：应用层，包含所有的批处理作业，程序员自定义代码实现逻辑

Batch Core：核心层，包含SpringBatch启动和控制所需要的核心类，比如：JobLauncher，Job，Step等

Batch Infrastructure：基础架构层，提供通用的读，写与服务处理

三层体系使得SpringBatch架构可以在不同层面进行扩展，避免影响，实现高内聚低耦合设计







## 入门案例

### 批量处理流程

首先了解一下SpringBatch程序运行大纲：

![image-20240130154818643](https://s2.loli.net/2024/01/30/qlsvF6datOH1Po3.png)

**JobLauncher：作业调度器，作业启动主要入口**

**Job：作业，需要执行的任务逻辑**

**Step：作业步骤，一个Job作业由一个或者多个Step组成，完成所有Step操作，一个完整Job才算执行技术**

**ItemReader：Step步骤执行过程中数据输入，可以从数据源（文件系统，数据库，队列等）中读取Item（数据记录）**

**ItemWriter：Step步骤执行过程中数据输出，将Item（数据记录）写入数据源（文件系统，数据库，队列等）**

**ItemProcessor：Item数据加工逻辑（输入），比如：数据清洗，数据转换，数据过滤，数据校验等**

**JobRepository：保存job或者检索job的信息，SpringBatch需要持久化job（可以选择数据库/内存），jobRepository就是持久化的接口。**







### 入门案例-Mysql

**需求：打印一个Hello Spring Batch !不带读/写/处理**

#### 步骤1：导入依赖

```xml
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.6</version>
        <relativePath/> <!-- lookup parent from repository -->
    </parent>
    <groupId>com.ldd</groupId>
    <artifactId>spring-batch-example</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>spring-batch-example</name>
    <description>spring-batch-example</description>
    <properties>
        <java.version>17</java.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-batch</artifactId>
        </dependency>

        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.26</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
```







#### 步骤2：配置数据库和初始化SQL脚本

```yaml
spring:
  datasource:
    username: root
    password: 123456
    url: jdbc:mysql://127.0.0.1:3306/springbatch?serverTimezone=GMT%2B8&useSSL=false&allowPublicKeyRetrieval=true
    driver-class-name: com.mysql.cj.jdbc.Driver
    # 初始化数据库，文件在依赖jar包中
  sql:
    init:
      schema-locations: classpath:org/springframework/batch/core/schema-mysql.sql
      mode: always
      #mode: never
```

这里要注意， sql.init.model 第一次启动为always， 后面启动需要改为never，否则每次执行SQL都会异常。

第一次启动会自动执行指定的脚本，后续不需要再初始化





#### 步骤3：测试

测试代码：

```java
package com.ldd;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableBatchProcessing
public class HelloJob {

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
                System.out.println("Hello SpringBatch!");
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
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("hello-job1")
                .start(step1())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(HelloJob.class, args);
    }

}
```



测试结果：

观测数据库：

![image-20240130164050459](https://s2.loli.net/2024/01/30/ChBeIPUL76SFgn5.png)



观测控制台：

![image-20240130165311518](https://s2.loli.net/2024/01/30/PcWbkOQoXLRetuE.png)



### 入门案列解析

>1.@EnableBatchProcessing

批处理启动注解，要求贴配置类或者启动类上

```java
@SpringBootApplication
@EnableBatchProcessing
public class HelloJob {
    ...
}
```

贴上@EnableBatchProcessing注解后，SpringBoot会自动加载JobLauncher  JobBuilderFactory  StepBuilderFactory 类并创建对象交给容器管理，要使用时，直接@Autowired即可

```java
//job调度器
@Autowired
private JobLauncher jobLauncher;
//job构造器工厂
@Autowired
private JobBuilderFactory jobBuilderFactory;
//step构造器工厂
@Autowired
private StepBuilderFactory stepBuilderFactory;
```





>2.配置数据库四要素

批处理允许重复执行，异常重试，此时需要保存批处理状态与数据，如果要保存在MySQL中，所以需要配置数据库四要素。





>3.创建Tasklet对象

```java
//任务-step执行逻辑由tasklet完成
@Bean
public Tasklet tasklet(){
    return new Tasklet() {
        @Override
        public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
            System.out.println("Hello SpringBatch!");
            return RepeatStatus.FINISHED;
        }
    };
}
```

Tasklet负责批处理step步骤中具体业务执行，它是一个接口，有且只有一个execute方法，用于定制step执行逻辑。

```java
public interface Tasklet {
    @Nullable
    RepeatStatus execute(StepContribution var1, ChunkContext var2) throws Exception;
}
```

execute方法返回值是一个状态枚举类：RepeatStatus，里面有可继续执行态与已经完成态

```java
public enum RepeatStatus {
	/**
	 * 可继续执行的-tasklet返回这个状态会进入死循环
	 */
	CONTINUABLE(true), 
	/**
	 * 已经完成态
	 */
	FINISHED(false);
    ....
}
```





> 4.创建Step对象

```java
//作业步骤-不带读/写/处理
@Bean
public Step step1(){
    return stepBuilderFactory.get("step1")
            .tasklet(tasklet())
            .build();
}
```

Job作业执行靠Step步骤执行，入门案例选用最简单的Tasklet模式，后续再使用Chunk块处理模式。





> 5.创建Job并执行Job

```java
//定义作业
@Bean
public Job job(){
    return jobBuilderFactory.get("hello-job")
        .start(step1())
        .build();
}
```

创建Job对象交给容器管理，当springboot启动之后，会自动去从容器中加载Job对象，并将Job对象交给JobLauncherApplicationRunner类，再借助JobLauncher类实现job执行。

**验证过程：**

打断点，Debug模式启动

![image-20240130165405679](https://s2.loli.net/2024/01/30/ACg9eRYmUy8BzOl.png)

一直走到JobLauncherApplicationRunner类

![image-20240130182815826](https://s2.loli.net/2024/01/30/uTPIpfaqyhSH5bB.png)





## 作业对象-Job

### 作业介绍

#### 作业定义

Job作业可以简单理解为一段业务流程的实现，可以根据业务逻辑拆分一个或者多个逻辑块(step)，然后业务逻辑顺序，逐一执行。

所以作业可以定义为：**能从头到尾独立执行的有序的步骤(Step)列表。**

- 有序的步骤列表

  一次作业由不同的步骤组成，这些步骤顺序是有意义的，如果不按照顺序执行，会引起逻辑混乱，比如购物结算，先点结算，再支付，最后物流，如果反过来那就乱套了，作业也是这么一回事。

- 从头到尾

  一次作业步骤固定了，在没有外部交互情况下，会从头到尾执行，前一个步骤做完才会到后一个步骤执行，不允许随意跳转，但是可以按照一定逻辑跳转。

- 独立

  每一个批处理作业都应该不受外部依赖影响情况下执行。

回到这幅图，批处理作业Job是由一组步骤Step对象组成，每一个作业都有自己名称，可以定义Step执行顺序。

![image-20240130183016006](https://s2.loli.net/2024/01/30/BXYGNuwaLEJpDWt.png)



#### 作业代码设计

前面定义了作业执行时相互独立的，代码该怎么设计才能保证每次作业独立性呢？

答案是：**Job instance**(作业实例) 与 **Job Execution**(作业执行对象)

**Job instance**(作业实例)

当作业运行时，会创建一个Job Instance(作业实例)，它代表作业的一次逻辑运行，可通过作业名称与作业标识参数进行区分。

比如一个业务需求： 每天定期数据同步，**作业名称-daily-sync-job**    **作业标记参数-当天时间**

**Job Execution**(作业执行对象)

当作业运行时，也会创建一个Job Execution(作业执行器)，负责记录Job执行情况(比如：开始执行时间，结束时间，处理状态等)。

![image-20240131094244135](https://s2.loli.net/2024/01/31/4Tav9IgsCKqMhO7.png)

看到旁边的星号（*），也就是表示多个的意思，那为啥会出现上面架构设计呢？原因：批处理执行过程中可能出现两种情况：

- 一种是一次成功

  仅一次就成从头到尾正常执行完毕，在数据库中会记录一条Job Instance 信息， 跟一条 Job Execution 信息

- 另外一种异常执行

  在执行过程因异常导致作业结束，在数据库中会记录一条Job Instance 信息， 跟一条Job Execution 信息。如果此时使用相同识别参数再次启动作业，那么数据库中不会多一条Job Instance 信息， 但是会多了一条Job Execution 信息，这就意味中任务重复执行了。刚刚说每天批处理任务案例，如果当天执行出异常，那么人工干预修复之后，可以再次执行。

总结：

**Job Instance  =  Job名称  +  识别参数**

**Job Instance 一次执行创建一个 Job Execution对象**

**完整的一次Job Instance 执行可能创建一个Job Execution对象，也可能创建多个Job  Execution对象**





### 作业配置

回到测试代码

```java
package com.ldd;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@EnableBatchProcessing
public class HelloJob {

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
                System.out.println("Hello SpringBatch!");
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
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("hello-job1")
                .start(step1())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(HelloJob.class, args);
    }

}
```

在启动类中贴上@EnableBatchProcessing注解，SpringBoot会自动听JobLauncher  JobBuilderFactory  StepBuilderFactory 对象，分别用于执行Jog，创建Job，创建Step逻辑。有了这些逻辑，Job批处理就剩下组装了。





### 作业参数

#### JobParameters

从前面知道，作业的启动条件是作业名称+识别参数，SpringBatch使用JobParameters类来封装了所有传给作业参数。

JobParameters部分源码：

```java
public class JobParameters implements Serializable {

	private final Map<String,JobParameter> parameters;

	public JobParameters() {
		this.parameters = new LinkedHashMap<>();
	}

	public JobParameters(Map<String,JobParameter> parameters) {
		this.parameters = new LinkedHashMap<>(parameters);
	}
    .....
}
```

![image-20240131094946921](https://s2.loli.net/2024/01/31/kjWblKQOaCcPXTe.png)

从上面代码/截图来看，JobParameters 类底层维护了Map<String,JobParameter>，是一个Map集合的封装器，提供了不同类型的get操作。





#### 作业参数设置

Debug时候看到Job作业最终是调用时 **JobLauncher **(job启动器)接口run方法启动。

看下源码：JobLauncher

```java
public interface JobLauncher {
	public JobExecution run(Job job, JobParameters jobParameters) throws JobExecutionAlreadyRunningException,
			JobRestartException, JobInstanceAlreadyCompleteException, JobParametersInvalidException;

}
```

在JobLauncher 启动器执行run方法时，直接传入即可。

```java
jobLauncher.run(job, params);
```



> 1.定义ParamJob类，准备好要执行的job

```java
@SpringBootApplication
@EnableBatchProcessing
public class ParamsJob {

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
                System.out.println("params-job-hello");
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
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("params-job")
                .start(step1())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ParamsJob.class, args);
    }

}
```



> 2.使用idea的命令传值的方式设置job作业参数

![image-20240131100042361](https://s2.loli.net/2024/01/31/fh5XsvRMaHBG7YK.png)**注意：如果不想这么麻烦，其实也可以，先空参数执行一次，然后指定参数后再执行**

在执行之前

请清空数据库中的表，方便测试观察。

还需要开启sql执行规则

```yaml
spring:
  sql:
    init:
      schema-locations: classpath:org/springframework/batch/core/schema-mysql.sql
      #mode: never
      mode: always
```



点击绿色按钮，启动SpringBoot程序，作业运行之后，会在batch_job_execution_params 增加一条记录，用于区分唯一的Job Instance实例

测试结果：

**记得修改回来sql规则**

![image-20240131100451613](https://s2.loli.net/2024/01/31/GLn8xr5R2J1HtX7.png)

观测数据库：

![image-20240131100545657](https://s2.loli.net/2024/01/31/yaVKSsudDTFmBML.png)

![image-20240131100636055](https://s2.loli.net/2024/01/31/3wJezV4765bspkh.png)

**注意：如果不改动JobParameters 参数内容，再执行一次批处理，会直接报错。**

![image-20240131100725393](https://s2.loli.net/2024/01/31/uLXBJFCxy3dmw8b.png)

**原因：Spring Batch 相同Job名与相同标识参数只能成功执行一次。**





#### 作业参数获取

当将作业参数传入到作业流程，该如何获取呢（也就是如何获取`name=xiaodong`这个值）

Spring Batch 提供了2种方案：

**方案1：使用ChunkContext类**

ParamJob类中tasklet写法

```java
@Bean
public Tasklet tasklet(){
    return new Tasklet() {
        @Override
        public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
            Map<String, Object> parameters = chunkContext.getStepContext().getJobParameters();
            System.out.println("params-name:"+parameters.get("name"));
            return RepeatStatus.FINISHED;
        }
    };
}
```

**注意：job名：param-job    job参数：name=dafei 已经执行了，再执行会报错**

**所以要么改名字，要么改参数，这里选择改job名字（拷贝一份job实例方法，然后注释掉，修改Job名称）**

```java
//    @Bean
//    public Job job(){
//        return jobBuilderFactory.get("params-job")
//                .start(step1())
//                .build();
//    }
    @Bean
    public Job job(){
        return jobBuilderFactory.get("params-chunk-job")
                .start(step1())
                .build();
    }
```



**方案2：使用@Value延时获取**

![image-20240131101826694](https://s2.loli.net/2024/01/31/lFvAtaNPoG913UL.png)

step1调用tasklet实例方法时不需要传任何参数，Spring Boot 在加载Tasklet Bean实例时会自动注入。

这里要注意，**必须贴上@StepScope** ，表示在启动项目的时候，不加载该Step步骤bean，等step1()被调用时才加载。这就是所谓延时获取。





#### 作业参数校验

当外部传入的参数进入作业时，如何确保参数符合期望呢？使用Spring Batch 的参数校验器：**JobParametersValidator** 接口。

先来看下JobParametersValidator 接口源码：

```java
public interface JobParametersValidator {
	void validate(@Nullable JobParameters parameters) throws JobParametersInvalidException;
}
```

JobParametersValidator 接口有且仅有唯一的validate方法，参数为JobParameters，没有返回值。这就意味着如果不符合参数要求，需要抛出异常来结束步骤。



##### 定制参数校验器

Spring Batch 提供JobParametersValidator参数校验接口，其目的就是让我们通过实现接口方式定制参数校验逻辑。

**需求：如果传入作业的参数name值 为null 或者 "" 时报错**

```java
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
```

其中的JobParametersInvalidException 异常是Spring Batch 专门提供参数校验失败异常，当然我们也可以自定义或使用其他异常。

```java
package com.ldd.params_validator;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.launch.JobLauncher;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

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




    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("params-validator-job")
                .start(step1())
                .validator(validator())  //参数校验器
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(ParamsValidatorJob.class, args);
    }

}
```

新定义**validator()**实例方法，将定制的参数解析器加到Spring容器中，修改job()实例方法，加上**.validator(validator())**   校验逻辑。

直接启动，没有传任何参数，查看控制台

![image-20240131153030742](https://s2.loli.net/2024/01/31/Isi3cAXeqzYKEyG.png)

加上	`name=xiaodong`参数之后，正常执行

##### 默认参数校验器

除去上面的定制参数校验器外，Spring Batch 也提供2个默认参数校验器：DefaultJobParametersValidator(默认参数校验器) 跟 CompositeJobParametersValidator(组合参数校验器)。

DefaultJobParametersValidator参数校验器

```java
public class DefaultJobParametersValidator implements JobParametersValidator, InitializingBean {
	private Collection<String> requiredKeys;
	private Collection<String> optionalKeys;
    ....
}   
```

默认的参数校验器它功能相对简单，维护2个key集合requiredKeys 跟 optionalKeys,简单理解就是可选参数和必选参数。

- requiredKeys  是一个集合，表示作业参数jobParameters中必须包含集合中指定的keys
- optionalKeys  也是一个集合，该集合中的key 是可选参数



**需求：如果作业参数没有name参数报错，age参数可有可无**

修改上面的代码即可：

```java
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
//配置默认参数校验器
    @Bean
    public DefaultJobParametersValidator defaultJobParametersValidator(){
        DefaultJobParametersValidator validator = new DefaultJobParametersValidator();
        validator.setRequiredKeys(new String[]{"name"}); //必填
        validator.setOptionalKeys(new String[]{"age"}); //可选
        return  validator;
    }


    //定义作业
//    @Bean
//    public Job job(){
//        return jobBuilderFactory.get("params-validator-job")
//                .start(step1())
//                .validator(validator())  //定制参数校验器
//                .build();
//    }
        @Bean
    public Job job(){
        return jobBuilderFactory.get("default-params-validator-job")
                .start(step1())
                .validator(defaultJobParametersValidator())  //默认参数校验器
                .build();
    }
```

新定义defaultValidator() 实例方法，将默认参数解析器加到Spring容器中，修改job实例方法，加上**.validator(defaultValidator())。** 

右键启动，不填name 跟只填age 参数，直接报错

只填name，不填age，正常运行。

报错情况如下：

![image-20240131154630052](https://s2.loli.net/2024/01/31/MPf7XtVBLi9yum8.png)

两个都填，正常运行。

![image-20240131154812680](https://s2.loli.net/2024/01/31/pwFTjOPW5u7EdzU.png)



##### 组合参数校验器

CompositeJobParametersValidator 组合参数校验器，顾名思义就是将多个参数校验器组合在一起。

看源码，大体能看出该校验器逻辑

```java
public class CompositeJobParametersValidator implements JobParametersValidator, InitializingBean {

	private List<JobParametersValidator> validators;

	@Override
	public void validate(@Nullable JobParameters parameters) throws JobParametersInvalidException {
		for (JobParametersValidator validator : validators) {
			validator.validate(parameters);
		}
	}
	
	public void setValidators(List<JobParametersValidator> validators) {
		this.validators = validators;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		Assert.notNull(validators, "The 'validators' may not be null");
		Assert.notEmpty(validators, "The 'validators' may not be empty");
	}
}
```

底层维护一个validators 集合，校验时调用validate 方法，依次执行校验器集合中校验器方法。另外，多了一个afterPropertiesSet方法，用于校验validators 集合中的校验器是否为null。





**需求：要求步骤中必须有name属性，并且不能为空**

分析：必须有，使用DefaultJobParametersValidator 参数校验器， 不能为null，使用指定定义的NameParamValidator参数校验器

```java
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
        return jobBuilderFactory.get("composite-params-validator-job")
                .start(step1())
                .validator(compositeJobParametersValidator())  //默认参数校验器
                .build();
    }
```

新定义compositeValidator() 实例方法，将组合参数解析器加到spring容器中，修改job()实例方法，加上**.validator(compositeValidator())。** 

右键启动，不填name参数，测试报错。如果放开name参数，传null值，一样报错。

![image-20240131170052971](https://s2.loli.net/2024/01/31/UTbQlS8wPO3s56o.png)

![image-20240131170107661](https://s2.loli.net/2024/01/31/kiNDzrvsp2KwtjL.png)





#### 作业增量参数

前面发现有个限制：每次运行作业时，都改动作业名字，或者改动作业的参数。

原因是作业启动有限制：相同标识参数与相同作业名的作业，只能成功运行一次。那如果想每次启动，又不想改动标识参数跟作业名怎么办呢？

答案是：**使用JobParametersIncrementer (作业参数增量器)**

JobParametersIncrementer源码：

```java
public interface JobParametersIncrementer {
	JobParameters getNext(@Nullable JobParameters parameters);

}
```



##### 作业递增run.id参数

Spring Batch 提供一个run.id自增参数增量器：**RunIdIncrementer**，每次启动时，里面维护名为**run.id** 标识参数，每次启动让其自增 1。

RunIdIncrementer源码：

```java
public class RunIdIncrementer implements JobParametersIncrementer {

	private static String RUN_ID_KEY = "run.id";

	private String key = RUN_ID_KEY;

	public void setKey(String key) {
		this.key = key;
	}

	@Override
	public JobParameters getNext(@Nullable JobParameters parameters) {

		JobParameters params = (parameters == null) ? new JobParameters() : parameters;
		JobParameter runIdParameter = params.getParameters().get(this.key);
		long id = 1;
		if (runIdParameter != null) {
			try {
				id = Long.parseLong(runIdParameter.getValue().toString()) + 1;
			}
			catch (NumberFormatException exception) {
				throw new IllegalArgumentException("Invalid value for parameter "
						+ this.key, exception);
			}
		}
		return new JobParametersBuilder(params).addLong(this.key, id).toJobParameters();
	}

}
```

核心getNext方法，在JobParameters 对象维护一个**run.id**，每次作业启动时，都调用getNext方法获取JobParameters，保证其 **run.id** 参数能自增1

用法：

```java
package com.ldd.params_incr;

/**
 * @Author ldd
 * @Date 2024/1/31
 */
import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.Map;

@SpringBootApplication
@EnableBatchProcessing
public class IncrementParamJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                Map<String, Object> parameters = chunkContext.getStepContext().getJobParameters();
                System.out.println("params---run.id:" + parameters.get("run.id"));
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step step1(){
        return  stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("incr-params-job")
                .start(step1())
                .incrementer(new RunIdIncrementer())  //参数增量器(run.id自增)
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(IncrementParamJob.class, args);
    }
}
```

修改tasklet()方法，获取**run.id**参数，修改job实例方法，加上**.incrementer(new RunIdIncrementer())** ，保证参数能自增。

连续执行3次，观察数据库表：

![image-20240131175636239](https://s2.loli.net/2024/01/31/n3EWZ8uH6FGTvgx.png)

![image-20240131175654488](https://s2.loli.net/2024/01/31/rbDCsoi6lkH8jpg.png)

控制台

![image-20240131175708950](https://s2.loli.net/2024/01/31/YXeN8yMFwP5zUB2.png)



##### 作业时间戳参数

run.id 作为标识参数貌似没有具体业务意义，如果将时间戳作为标识参数那就不一样了，比如这种运用场景：每日任务批处理，这时就需要记录每天的执行时间了。那该怎么实现呢？

Spring Batch 中没有现成时间戳增量器，需要自己定义

```java
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
```

定义一个标识参数：daily，记录当前时间戳

```java
package com.ldd.params_incr;

/**
 * @Author ldd
 * @Date 2024/1/31
 */

import java.util.Map;

@SpringBootApplication
@EnableBatchProcessing
public class IncrementParamJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                Map<String, Object> parameters = chunkContext.getStepContext().getJobParameters();
                System.out.println("params---daily:" + parameters.get("daily"));
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public DailyTimestampParamIncrementer dailyTimestampParamIncrementer(){
        return new DailyTimestampParamIncrementer();
    }


    @Bean
    public Step step1(){
        return  stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("incr-params-job")
                .start(step1())
                .incrementer(dailyTimestampParamIncrementer())  //参数增量器(run.id自增)
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(IncrementParamJob.class, args);
    }
}
```

定义实例方法**dailyTimestampParamIncrementer()**将自定义时间戳增量器添加Spring容器中，修改job()实例方法，添加**.incrementer(dailyTimestampParamIncrementer())**  增量器，修改tasklet() 方法，获取 **daily**参数。

连续执行3次，查看**batch_job_execution_params** 表

![image-20240131180654780](https://s2.loli.net/2024/01/31/87hVGyz3e1MuRmn.png)





### 作业监听器

作业监听器：用于监听作业的执行过程逻辑。在作业执行前，执行后2个时间点嵌入业务逻辑。

- 执行前：一般用于初始化操作， 作业执行前需要着手准备工作，比如：各种连接建立，线程池初始化等。
- 执行后：业务执行完后，需要做各种清理动作，比如释放资源等。

Spring Batch 使用**JobExecutionListener** 接口 实现作业监听。

```java
public interface JobExecutionListener {
    //作业执行前
	void beforeJob(JobExecution jobExecution);
    //作业执行后
	void afterJob(JobExecution jobExecution);
}
```

**需求：记录作业执行前，执行中，与执行后的状态**

#### 方式一：接口方式

```java
package com.ldd.job_listener;

import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;

/**
 * @Author ldd
 * @Date 2024/1/31
 * 自定义作业状态监听器
 * 作用：用于记录作业执行前、后状态信息
 */
public class JobStateListener implements JobExecutionListener {

    //作业执行之前
    @Override
    public void beforeJob(JobExecution jobExecution) {
        System.err.println("作业执行前的状态："+jobExecution.getStatus());
    }
    //作业执行之后
    @Override
    public void afterJob(JobExecution jobExecution) {
        System.err.println("作业执行后的状态："+jobExecution.getStatus());
    }
}
```

定义JobStateListener 实现JobExecutionListener 接口，重写beforeJob，afterJob 2个方法。

```java
@SpringBootApplication
@EnableBatchProcessing
public class StatusListenerJob {
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

    //创建监听器交给容器管理
    @Bean
    public JobStateListener jobStateListener(){
        return new JobStateListener();
    }


    @Bean
    public Step step1(){
        return  stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-state-listener-job")
                .start(step1())
                .listener(jobStateListener())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(StatusListenerJob.class, args);
    }
}
```

新加**jobStateListener()**实例方法创建对象交个Spring容器管理，修改job()方法，添加**.listener(jobStateListener())**  状态监听器，直接执行，观察结果

![image-20240131181956667](https://s2.loli.net/2024/01/31/mob8Yg4h3aLAIVd.png)



#### 方式二：注解方式

除去上面通过实现接口方式实现监听之外，也可以使用**@BeforeJob  @AfterJob** 2个注解实现，类似使用切面的方式

```java
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
```

```java
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
```

![image-20240131182936961](https://s2.loli.net/2024/01/31/YKTgho4LmVprAte.png)

`listener(JobListenerFactoryBean.getListener(new JobStateAnnoListener()))`这一长串方法是它能将指定监听器对象（通过BeanFactory）加载到spring容器中。









### 执行上下文

#### 上下文

联系上下文解读一下作者所有表达意思。从这看上下文有环境，语境，氛围的意思。类比到编程，业内也喜欢使用Context表示上下文。比如Spring容器： SpringApplicationContext 。有上下文这个铺垫之后，我们来看下Spring Batch的上下文。

Spring Batch 有2个比较重要的上下文：

- **JobContext**

  JobContext 绑定 JobExecution 执行对象为Job作业执行提供执行环境(上下文)。

  **作用：维护JobExecution 对象，实现作业收尾工作，与处理各种作业回调逻辑**

  源码中这两段：

  ```java
  public class JobContext extends SynchronizedAttributeAccessor {
      private JobExecution jobExecution;
      private Map<String, Set<Runnable>> callbacks = new HashMap();
  
      public JobContext(JobExecution jobExecution) {
          Assert.notNull(jobExecution, "A JobContext must have a non-null JobExecution");
          this.jobExecution = jobExecution;
      }
      .......
  ```

- **StepContext**  

  StepContext 绑定 StepExecution 执行对象为Step步骤执行提供执行环境(上下文)。

  **作用：维护StepExecution 对象，实现步骤收尾工作，与处理各种步骤回调逻辑**

源码中这两段：

```java
public class StepContext extends SynchronizedAttributeAccessor {
    private StepExecution stepExecution;
    private Map<String, Set<Runnable>> callbacks = new HashMap();
    private BatchPropertyContext propertyContext = null;
    .......
```

#### 执行上下文

除了上面讲的**JobContext** 作业上下文，  **StepContext**   步骤上线下文外，还有Spring Batch还维护另外一个上下文：**ExecutionContext** 执行上下文，作用是：**数据共享**

Spring Batch 中 ExecutionContext 分2大类

- **Job ExecutionContext**

  作用域：一次作业运行，所有Step步骤间数据共享。

- **Step ExecutionContext：** 

  作用域：一次步骤运行，单个Step步骤间(ItemReader/ItemProcessor/ItemWrite组件间)数据共享。

![image-20240131183644446](https://s2.loli.net/2024/01/31/x419l5kQDijLCXV.png)



#### 作业与步骤执行链

![image-20240131183821697](https://s2.loli.net/2024/01/31/y4jd9cx3ebifsQA.png)

- **作业线**

  **Job**---**JobInstance**---**JobContext**---**JobExecution**--**ExecutionContext**

- **步骤线**

  **Step**--**StepContext** --**StepExecution**--**ExecutionContext**





#### 作业上下文API

```java
JobContext context = JobSynchronizationManager.getContext();
JobExecution jobExecution = context.getJobExecution();
Map<String, Object> jobParameters = context.getJobParameters();
Map<String, Object> jobExecutionContext = context.getJobExecutionContext();
```

关于获取作业上下文，是通过一个JobSynchronizationManager的同步管理器来获取的，有了这个作业上下文就可获取当前作业执行器或者作业参数，然后通过上面的作业线，获取JobExecution（作业执行器然后拿到这个执行上下文）

JobSynchronizationManager源码：

```java
public class JobSynchronizationManager {
    //这里维护了一个静态方法，就干一件事用于获取这个作业上下文
    private static final SynchronizationManagerSupport<JobExecution, JobContext> manager = new SynchronizationManagerSupport<JobExecution, JobContext>() {
        protected JobContext createNewContext(JobExecution execution, @Nullable BatchPropertyContext args) {
            return new JobContext(execution);
        }

        protected void close(JobContext context) {
            context.close();
        }
    };

    public JobSynchronizationManager() {
    }

    @Nullable
    public static JobContext getContext() {
        return (JobContext)manager.getContext();
    }

    public static JobContext register(JobExecution JobExecution) {
        return (JobContext)manager.register(JobExecution);
    }

    public static void close() {
        manager.close();
    }

    public static void release() {
        manager.release();
    }
}
```



#### 步骤上下文API

```java
ChunkContext chunkContext = xxx;
StepContext stepContext = chunkContext.getStepContext();
StepExecution stepExecution = stepContext.getStepExecution();
Map<String, Object> stepExecutionContext = stepContext.getStepExecutionContext();
Map<String, Object> jobExecutionContext = stepContext.getJobExecutionContext();
```



#### 执行上下文API

```java
ChunkContext chunkContext = xxx;
//步骤
StepContext stepContext = chunkContext.getStepContext();
StepExecution stepExecution = stepContext.getStepExecution();
ExecutionContext executionContext = stepExecution.getExecutionContext();
executionContext.put("key", "value");
//-------------------------------------------------------------------------
//作业
JobExecution jobExecution = stepExecution.getJobExecution();
ExecutionContext executionContext = jobExecution.getExecutionContext();
executionContext.put("key", "value");
```



#### API小案例

**需求：观察作业ExecutionContext与 步骤ExecutionContext数据共享**

分析： 

1>定义step1 与step2 2个步骤

2>在step1中设置数据

​	作业-ExecutionContext  添加： key-step1-job   value-step1-job

​	步骤-ExecutionContext  添加： key-step1-step   value-step1-step

3>在step2中打印观察

​	作业-ExecutionContext      步骤-ExecutionContext  

```java
@SpringBootApplication
@EnableBatchProcessing
public class ExecutionContextJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

                //步骤
                ExecutionContext stepEC = chunkContext.getStepContext().getStepExecution().getExecutionContext();
                stepEC.put("key-step1-step","value-step1-step");
                System.out.println("------------------1---------------------------");
                //作业
                ExecutionContext jobEC = chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext();
                jobEC.put("key-step1-job","value-step1-job");

                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {

                //步骤
                ExecutionContext stepEC = chunkContext.getStepContext().getStepExecution().getExecutionContext();
                System.err.println(stepEC.get("key-step1-step"));
                System.out.println("------------------2---------------------------");
                //作业
                ExecutionContext jobEC = chunkContext.getStepContext().getStepExecution().getJobExecution().getExecutionContext();
                System.err.println(jobEC.get("key-step1-job"));


                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step step1(){
        return  stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .build();
    }
    @Bean
    public Step  step2(){
        return  stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("execution-context-job")
                .start(step1())
                .next(step2())
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ExecutionContextJob.class, args);
    }
}
```

结果：

![image-20240201104941505](https://s2.loli.net/2024/02/01/gOPaNwJc5UxG37T.png)

这里就映证了这张图：

![image-20240201105023352](https://s2.loli.net/2024/02/01/XsxAHkEuPZy5qmr.png)

可以看出，在**stepContext** 设置的参数作用域仅在**StepExecution** 执行范围有效，而**JobContext** 设置参数作用与在所有**StepExcution** 有效，有点局部与全局 的意思。

打开数据库观察表：batch_job_execution_context  跟 batch_step_execution_context 表

![image-20240201105252428](https://s2.loli.net/2024/02/01/o8Rm47zZCbB9auq.png)

![image-20240201105307708](https://s2.loli.net/2024/02/01/2rOqQiRTXSv5ZDH.png)

**JobContext数据保存到：batch_job_execution_context**

**StepContext数据保存到：batch_step_execution_context**



总结：

**步骤数据保存在Step ExecutionContext，只能在Step中使用，作业数据保存在Job ExecutionContext，可以在所有Step中共享**





## 步骤对象-Step

### 步骤简介

![image-20240201101440838](https://s2.loli.net/2024/02/01/xFEJYRjcHmTA1e7.png)

一般认为步骤是一个独立功能组件，因为它包含了一个工作单元需要的所有内容，比如：输入模块，输出模块，数据处理模块等。这种设计的优势在于给开发者带来更自由的操作空间



目前SpringBatch支持两种步骤处理模式

- 简单局域Tasklet处理模式

​			这种模式相对简单，前面的都是使用这个模式进行批处理

```java
@Bean
public Tasklet tasklet(){
    return new Tasklet() {
        @Override
        public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
            System.out.println("Hello SpringBatch....");
            return RepeatStatus.FINISHED;
        }
    };
}
```

只需要实现Tasklet接口，就可以构建一个step代码块。循环执行step逻辑，直到tasklet.execute方法返回RepeatStatus.FINISHED

- 居于块(chunk)的处理模式


​			居于块的步骤一般包含2个或者3个组件：1>ItemReader  			2>ItemProcessor(可选)  3>ItemWriter 。 当用上这些组件			之后，Spring Batch 会按块处理数据。





### 简单Tasklet

之前写过很多简单Tasklet模式步骤，但是都没有深入了解过，这就细致分析一下具有Tasklet 步骤使用。

先看下Tasklet源码：

```java
public interface Tasklet {
	@Nullable
	RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception;
}
```

Tasklet 接口有且仅有一个方法：execute，

参数有2个：

StepContribution：步骤信息对象，用于保存当前步骤执行情况信息，核心用法：设置步骤结果状态**contribution.setExitStatus(ExitStatus status)**

ChunkContext：chuck上下文，跟之前学的StepContext   JobContext一样，区别是它用于记录chunk块执行场景。通过它可以获取前面2个对象。

返回值1个：

RepeatStatus：当前步骤状态， 它是枚举类，有2个值，一个表示execute方法可以循环执行，一个表示已经执行结束

```java
public enum RepeatStatus {

	/**
	 * 当前步骤依然可以执行，如果步骤返回该值，会一直循环执行
	 */
	CONTINUABLE(true), 
	/**
	 * 当前步骤结束，可以为成功也可以表示不成，仅代表当前step执行结束了
	 */
	FINISHED(false);
}    
```



**需求：测试上面RepeatStatus状态**

```java
@SpringBootApplication
@EnableBatchProcessing
public class SimpleTaskletJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;
    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------>" + System.currentTimeMillis());
                //return RepeatStatus.CONTINUABLE;  //循环执行
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
    }
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("step-simple-tasklet-job")
                .start(step1())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(SimpleTaskletJob.class, args);
    }

}
```





### 居于块Tasklet

居于块的Tasklet相对简单Tasklet来说，多了3个模块：ItemReader( 读模块)， ItemProcessor(处理模块)，ItemWriter(写模块)， 跟它们名字一样， 一个负责数据读， 一个负责数据加工，一个负责数据写。

结构图：

![image-20240201103415415](https://s2.loli.net/2024/02/01/Xx7EdbU3yl8N2jn.png)

时序图：

![image-20240201103430581](https://s2.loli.net/2024/02/01/WPLCNJG8U4Qoe6H.png)

**需求：简单的Chunk Tasklet使用**

ItemReader  ItemProcessor   ItemWriter 都是接口，直接使用匿名内部类方式方便创建

```java
@SpringBootApplication
@EnableBatchProcessing
public class ChunkTaskletJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public ItemReader itemReader(){
        return new ItemReader() {
            @Override
            public Object read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
                System.out.println("-------------read------------");
                return "read-ret";
            }
        };
    }

    @Bean
    public ItemProcessor itemProcessor(){
        return new ItemProcessor() {
            @Override
            public Object process(Object item) throws Exception {
                System.out.println("-------------process------------>" + item);
                return "process-ret->" + item;
            }
        };
    }
    @Bean
    public ItemWriter itemWriter(){
        return new ItemWriter() {
            @Override
            public void write(List items) throws Exception {
                System.out.println(items);
            }
        };
    }
    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .chunk(3)  //设置块的size为3次
                .reader(itemReader())
                .processor(itemProcessor())
                .writer(itemWriter())
                .build();
    }
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("step-chunk-tasklet-job")
                .start(step1())
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ChunkTaskletJob.class, args);
    }
}
```

控制台结果：

```java
-------------read------------
-------------read------------
-------------read------------
-------------process------------>read-ret
-------------process------------>read-ret
-------------process------------>read-ret
[process-ret->read-ret, process-ret->read-ret, process-ret->read-ret]
-------------read------------
-------------read------------
-------------read------------
-------------process------------>read-ret
-------------process------------>read-ret
-------------process------------>read-ret
[process-ret->read-ret, process-ret->read-ret, process-ret->read-ret]
.........
```

观察上面打印结果，得出2个得出。

1>程序一直在循环打印，先循环打印3次reader， 再循环打印3次processor，最后一次性输出3个值。

2>死循环重复上面步骤

问题来了，为啥会出现这种效果，该怎么改进？

其实这个是ChunkTasklet 执行特点，**ItemReader会一直循环读，直到返回null**，才停止。而processor也是一样，itemReader读多少次，它处理多少次， itemWriter 一次性输出当前次输入的所有数据。

我们改进一下上面案例，要求只读3次， 只需要改动itemReader方法就行

```java
int timer = 3;

@Bean
public ItemReader itemReader() {
    return new ItemReader() {
        @Override
        public Object read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
            if (timer > 0) {
                System.out.println("-------------read------------");
                return "read-ret-->" + timer--;
            } else {
                return null;
            }
        }
    };
}
```

![image-20240201104223092](https://s2.loli.net/2024/02/01/Q5Lp6FPmBlEtY4e.png)

如果把`timer修改为10`，而`.chunk(3)`不变结果是怎么样的：

![image-20240201104341031](https://s2.loli.net/2024/02/01/NKp3rHbdt1uQyhU.png)

规律就是：

当chunkSize = 3 表示 reader 先读3次，提交给processor处理3次，最后由writer输出3个值

timer =10， 表示数据有10条，一个批次(趟)只能处理3条数据，需要4个批次(趟)来处理。

**到这里就已经有`批处理`味道了**

**结论：chunkSize 表示： 一趟需要ItemReader读多少次，ItemProcessor要处理多少次。**





#### ChunkTasklet泛型

上面案例默认使用的是Object类型读、写、处理数据，如果明确了Item的数据类型，可以明确指定具体操作泛型。

```java
//开启 spring batch 注解--可以让spring容器创建spring batch操作相关类对象
@SpringBootApplication
@EnableBatchProcessing
public class ChunkTaskletJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    int timer = 10;

    @Bean
    public ItemReader<String> itemReader() {
        return new ItemReader<String>() {
            @Override
            public String read() throws Exception, UnexpectedInputException, ParseException, NonTransientResourceException {
                if (timer > 0) {
                    System.out.println("-------------read------------");
                    return "read-ret-->" + timer--;
                } else {
                    return null;
                }
            }
        };
    }

    @Bean
    public ItemProcessor<String, String> itemProcessor(){
        return new ItemProcessor<String, String>() {
            @Override
            public String process(String item) throws Exception {
                System.out.println("-------------process------------>" + item);
                return "process-ret->" + item;
            }
        };
    }

    //写操作
    @Bean
    public ItemWriter<String> itemWriter(){
        return new ItemWriter<String>() {
            @Override
            public void write(List<? extends String> items) throws Exception {
                System.out.println(items);
            }
        };
    }



    //构造一个step对象--chunk
    @Bean
    public Step step1(){
        //tasklet 执行step逻辑， 类似 Thread()--->可以执行runable接口
        return stepBuilderFactory.get("step1")
                .<String, String>chunk(3)  //暂时为3
                .reader(itemReader())
                .processor(itemProcessor())
                .writer(itemWriter())
                .build();
    }

    //定义作业
    @Bean
    public Job job() {
        return jobBuilderFactory.get("step-chunk-tasklet-job")
                .start(step1())
                .incrementer(new RunIdIncrementer())
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(ChunkTaskletJob.class, args);
    }
}
```





### 步骤监听器

前面知道了作业的监听器，步骤也有监听器，也是执行步骤执行前监听，步骤执行后监听。

步骤监听器有2个分别是：StepExecutionListener   ChunkListener  意义很明显，就是step前后，chunk块执行前后监听。

先看下StepExecutionListener接口：

```java
public interface StepExecutionListener extends StepListener {
	void beforeStep(StepExecution stepExecution);
	@Nullable
	ExitStatus afterStep(StepExecution stepExecution);
}
```



**需求：使用StepExecutionListener**

自定义监听接口：

```java
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
```

```java
@SpringBootApplication
@EnableBatchProcessing
public class StepListenerJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;
    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------>" + System.currentTimeMillis());
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public MyStepListener stepListener(){
        return new MyStepListener();
    }
    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .listener(stepListener())  
                .build();
    }
    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("step-listener-job1")
                .start(step1())
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(StepListenerJob.class, args);
    }

}
```

![image-20240201113719435](https://s2.loli.net/2024/02/01/wdXDCqKy9zokS4r.png)

在step1方法中，加入：**.listener(stepListener())**   即可

同理ChunkListener 操作跟上面一样

源码：

```java
public interface ChunkListener extends StepListener {
    String ROLLBACK_EXCEPTION_KEY = "sb_rollback_exception";

    void beforeChunk(ChunkContext var1);

    void afterChunk(ChunkContext var1);

    void afterChunkError(ChunkContext var1);
}
```

唯一的区别是多了一个afterChunkError 方法，表示当chunk执行失败后回调。





### 多步骤执行

到目前为止，我们演示的案例基本上都是一个作业， 一个步骤，那如果有多个步骤会怎样？Spring Batch 支持多步骤执行，以应对复杂业务需要多步骤配合执行的场景。



**需求：定义2个步骤，然后依次执行**

```java
@SpringBootApplication
@EnableBatchProcessing
public class MultiStepJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;
    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------tasklet1---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------tasklet2---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("step-multi-job1")
                .start(step1())
                .next(step2()) //job 使用next 执行下一步骤
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(MultiStepJob.class, args);
    }
}
```

定义2个tasklet： tasklet1  tasklet2， 定义2个step： step1 step2  修改 job方法，**从.start(step1()) 然后执行到 .next(step2())**

Spring Batch 使用next 执行下一步步骤，如果还有第三个step，再加一个next(step3)即可

![image-20240201115740689](https://s2.loli.net/2024/02/01/lLHhqNR93eVrkiu.png)



### 步骤控制

上面多个步骤操作，先执行step1 然后是step2，如果有step3， step4，那执行顺序也是从step1到step4。此时肯定会想，步骤的执行能不能进行条件控制呢？比如：step1执行结束根据业务条件选择执行step2或者执行step3，亦或者直接结束呢？**答案是yes：设置步骤执行条件即可**

Spring Batch 使用 **start**  **next**  **on**   **from**  **to**    **end**  不同的api 改变步骤执行顺序。



#### 条件分支控制-使用默认返回状态

**需求：作业执行firstStep步骤，如果处理成功执行sucessStep，如果处理失败执行failStep**

```java
@SpringBootApplication
@EnableBatchProcessing
public class ConditionStepJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet firstTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------firstTasklet---------------");
                return RepeatStatus.FINISHED;
                //throw new RuntimeException("测试fail结果");
            }
        };
    }

    @Bean
    public Tasklet successTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------successTasklet---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet failTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------failTasklet---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step firstStep(){
        return stepBuilderFactory.get("step1")
                .tasklet(firstTasklet())
                .build();
    }
    @Bean
    public Step successStep(){
        return stepBuilderFactory.get("successStep")
                .tasklet(successTasklet())
                .build();
    }
    @Bean
    public Step failStep(){
        return stepBuilderFactory.get("failStep")
                .tasklet(failTasklet())
                .build();
    }

/*
        有点类似这个if/else语法
        if("FAILED".equals(firstStep())){
              failStep();
        }else{
              successStep();
        }
    */

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("condition-step-job")
                .start(firstStep())
                .on("FAILED").to(failStep())
                .from(firstStep()).on("*").to(successStep())
                .end()
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ConditionStepJob.class, args);
    }
}
```

job方法以 **.start(firstStep())** 开始作业，执行完成之后， 使用**on** 与**from**  2个方法实现流程转向。

**.on("FAILED").to(failStep())**  表示当**firstStep()**返回FAILED时执行。

**.from(firstStep()).on("*").to(successStep())** 另外一个分支，表示当**firstStep()**返回 * 时执行。

![image-20240201152449017](https://s2.loli.net/2024/02/01/sfXxdYmLhiI6ZQ2.png)

测试一下失败的情况

```java
@Bean
public Tasklet firstTasklet(){
    return new Tasklet() {
        @Override
        public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
            System.out.println("--------------firstTasklet---------------");
            throw new RuntimeException("测试fail结果");
            //return RepeatStatus.FINISHED;
        }
    };
}
```

![image-20240201152625594](https://s2.loli.net/2024/02/01/1t7xDLJXh5P6BSM.png)

几个注意点：

-   on 方法表示条件， 上一个步骤返回值，匹配指定的字符串，满足后执行后续 to 步骤


* *为通配符，表示能匹配任意返回值

- from 表示从某个步骤开始进行条件判断

- 分支判断结束，流程以end方法结束，表示if/else逻辑结束


- on 方法中字符串取值于 ExitStatus 类常量，当然也可以自定义。







#### 条件分支控制-使用自定义状态值

从前面了解，on条件的值取值于ExitStatus 类常量，具体值有：UNKNOWN，EXECUTING，COMPLETED，NOOP，FAILED，STOPPED等，如果此时我想自定义返回值呢，是否可行？答案还是yes：Spring Batch 提供JobExecutionDecider 接口实现状态值定制。

**需求：先执行firstStep，如果返回值为A，执行stepA， 返回值为B，执行stepB， 其他执行defaultStep**

分析：先定义一个决策器，随机决定返回A / B / C

```java
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
```



```java
@SpringBootApplication
@EnableBatchProcessing
public class CustomizeStatusStepJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet firstTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------firstTasklet---------------");
                //throw new RuntimeException("测试fail结果");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet taskletA(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------taskletA---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet taskletB(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------taskletB---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet taskletDefault(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------taskletDefault---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step firstStep(){
        return stepBuilderFactory.get("firstStep")
                .tasklet(firstTasklet())
                .build();
    }
    @Bean
    public Step StepA(){
        return stepBuilderFactory.get("stepA")
                .tasklet(taskletA())
                .build();
    }
    @Bean
    public Step StepB(){
        return stepBuilderFactory.get("StepB")
                .tasklet(taskletB())
                .build();
    }
    @Bean
    public Step StepDefault(){
        return stepBuilderFactory.get("StepDefault")
                .tasklet(taskletDefault())
                .build();
    }

    //注入决策器
    @Bean
    public MyStatusDecider myStatusDecider(){
        return new MyStatusDecider();
    }


    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("customize-step-job")
                .start(firstStep())
                .next(myStatusDecider())
                .from(myStatusDecider()).on("A").to(StepA())
                .from(myStatusDecider()).on("B").to(StepA())
                .from(myStatusDecider()).on("*").to(StepA())
                .end()
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(CustomizeStatusStepJob.class, args);
    }
}
```

反复执行，会返回打印的就是：

```tex
--------------taskletA---------------
--------------taskletB---------------
--------------taskletDafault---------------
```

**注意**，并不是**firstStep()** 执行返回值为A/B/C控制流程跳转，而是由后面**.next(statusDecider())**  决策器。







### 步骤状态

Spring Batch 使用ExitStatus 类表示步骤、块、作业执行状态，大体上有以下几种：

源码：

```java
public class ExitStatus implements Serializable, Comparable<ExitStatus> {

    //未知状态
	public static final ExitStatus UNKNOWN = new ExitStatus("UNKNOWN");

    //执行中
	public static final ExitStatus EXECUTING = new ExitStatus("EXECUTING");

    //执行完成
	public static final ExitStatus COMPLETED = new ExitStatus("COMPLETED");

    //无效执行
	public static final ExitStatus NOOP = new ExitStatus("NOOP");

    //执行失败
	public static final ExitStatus FAILED = new ExitStatus("FAILED");

    //执行中断
	public static final ExitStatus STOPPED = new ExitStatus("STOPPED");
    ...
}   
```

一般来说，作业启动之后，这些状态皆为流程自行控制。顺利结束返回：**COMPLETED**， 异常结束返回：**FAILED**，无效执行返回：**NOOP**， 但是这些状态也是可以经过**编程控制的**。

Spring Batch 提供 3个方法决定作业流程走向：

end()：作业流程直接成功结束，返回状态为：**COMPLETED**

fail()：作业流程直接失败结束，返回状态为：**FAILED**

stopAndRestart(step) ：作业流程中断结束，返回状态：**STOPPED**   再次启动时，从step位置开始执行 (注意：前提是参数与Job Name一样)



**需求：当步骤firstStep执行抛出异常时，通过end， fail，stopAndRestart改变步骤执行状态 **

```java
@SpringBootApplication
@EnableBatchProcessing
public class StepStatusJob {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet firstTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------firstTasklet---------------");
                throw new RuntimeException("测试fail结果");
                //return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet successTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------successTasklet---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet failTasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("--------------failTasklet---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step firstStep(){
        return stepBuilderFactory.get("step1")
                .tasklet(firstTasklet())
                .build();
    }
    @Bean
    public Step successStep(){
        return stepBuilderFactory.get("successStep")
                .tasklet(successTasklet())
                .build();
    }
    @Bean
    public Step failStep(){
        return stepBuilderFactory.get("failStep")
                .tasklet(failTasklet())
                .build();
    }

/*
        有点类似这个if/else语法
        if("FAILED".equals(firstStep())){
              failStep();
        }else{
              successStep();
        }
    */

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("condition-step-job")
                .start(firstStep())
                .on("FAILED").end()
                .from(firstStep()).on("*").to(successStep())
                .end()
                .incrementer(new RunIdIncrementer())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(StepStatusJob.class, args);
    }
}
```

```java
//定义作业
@Bean
public Job job(){
    return jobBuilderFactory.get("condition-step-job")
            .start(firstStep())
            //.on("FAILED").end()//表示将当前本应该是失败结束的步骤直接转成正常结束--COMPLETED
            //.on("FAILED").fail()//表示将当前本应该是失败结束的步骤直接转成失败结束：FAILED
            .on("FAILED").stopAndRestart(successStep())//表示将当前本应该是失败结束的步骤直接转成停止结束：STOPPED   里面参数表示后续要重启时， 从successStep位置开始
            .from(firstStep()).on("*").to(successStep())
            .end()
            .incrementer(new RunIdIncrementer())
            .build();
}
```

三次执行不同的情况观测数据库中的Status：

![image-20240201161135563](https://s2.loli.net/2024/02/01/FV9YW4mqDKPtiu5.png)





### 流式步骤

FlowStep 流式步骤，也可以理解为步骤集合，由多个子步骤组成。作业执行时，将它当做一个普通步骤执行。一般用于较为复杂的业务，比如：一个业务逻辑需要拆分成按顺序执行的子步骤。



**需求：先后执行stepA，stepB，stepC， 其中stepB中包含stepB1， stepB2，stepB3。**

```java
@SpringBootApplication
@EnableBatchProcessing
public class FlowStepJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet taskletA(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------------stepA--taskletA---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet taskletB1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------------stepB--taskletB1---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet taskletB2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------------stepB--taskletB2---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet taskletB3(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------------stepB--taskletB3---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }
    @Bean
    public Tasklet taskletC(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("------------stepC--taskletC---------------");
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public Step stepA(){
        return stepBuilderFactory.get("stepA")
                .tasklet(taskletA())
                .build();
    }


    @Bean
    public Step stepB1(){
        return stepBuilderFactory.get("stepB1")
                .tasklet(taskletB1())
                .build();
    }
    @Bean
    public Step stepB2(){
        return stepBuilderFactory.get("stepB2")
                .tasklet(taskletB2())
                .build();
    }
    @Bean
    public Step stepB3(){
        return stepBuilderFactory.get("stepB3")
                .tasklet(taskletB3())
                .build();
    }
    
    //构造一个流式步骤
    @Bean
    public Flow flowB(){
        return new FlowBuilder<Flow>("flowB")
                .start(stepB1())
                .next(stepB2())
                .next(stepB3())
                .build();
    }
    @Bean
    public Step stepB(){
        return stepBuilderFactory.get("stepB")
                .flow(flowB())
                .build();
    }

    @Bean
    public Step stepC(){
        return stepBuilderFactory.get("stepC")
                .tasklet(taskletC())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("flow-step-job")
                .start(stepA())
                .next(stepB())
                .next(stepC())
                .incrementer(new RunIdIncrementer())
                .build();
    }

    public static void main(String[] args) {
        SpringApplication.run(FlowStepJob.class, args);
    }
}
```

此时的flowB()就是一个FlowStep，包含了stepB1, stepB2, stepB3  3个子step，他们全部执行完后， stepB才能算执行完成。下面执行结果也验证了这点。

执行结果：

![image-20240201163510376](https://s2.loli.net/2024/02/01/1aFrWj6vNsg2PpO.png)

使用FlowStep的好处在于，在处理复杂额批处理逻辑中，flowStep可以单独实现一个子步骤流程，为批处理提供更高的灵活性。







## 批处理数据表（了解）

如果选择数据库方式存储批处理数据，Spring Batch 在启动时会自动创建9张表，分别存储： JobExecution、JobContext、JobParameters、JobInstance、JobExecution id序列、Job id序列、StepExecution、StepContext/ChunkContext、StepExecution id序列 等对象。Spring Batch 提供 JobRepository 组件来实现这些表的CRUD操作，并且这些操作基本上封装在步骤，块，作业api操作中，并不需要我们太多干预，了解即可。

![image-20240201163848091](https://s2.loli.net/2024/02/01/XrCBhAqSfOReNg1.png)

###  batch_job_instance表

当作业第一次执行时，会根据作业名，标识参数生成一个唯一JobInstance对象，batch_job_instance表会记录一条信息代表这个作业实例。

![image-20240201164017632](https://s2.loli.net/2024/02/01/kdmp9swxBCh7uXY.png)

| 字段            | 描述                                              |
| --------------- | ------------------------------------------------- |
| JOB_INSTANCE_ID | 作业实例主键                                      |
| VERSION         | 乐观锁控制的版本号                                |
| JOB_NAME        | 作业名称                                          |
| JOB_KEY         | 作业名与标识性参数的哈希值，能唯一标识一个job实例 |



### batch_job_execution表

每次启动作业时，都会创建一个JobExecution对象，代表一次作业执行，该对象记录存放于batch_job_execution 表。

![image-20240201164306841](https://s2.loli.net/2024/02/01/2WRwod4YEQL3BJS.png)



| JOB_EXECUTION_ID | job执行对象主键                      |
| ---------------- | ------------------------------------ |
| VERSION          | 乐观锁控制的版本号                   |
| JOB_INSTANCE_ID  | JobInstanceId(归属于哪个JobInstance) |
| CREATE_TIME      | 记录创建时间                         |
| START_TIME       | 作业执行开始时间                     |
| 字段             | 描述                                 |
| END_TIME         | 作业执行结束时间                     |
| STATUS           | 作业执行的批处理状态                 |
| EXIT_CODE        | 作业执行的退出码                     |
| EXIT_MESSAGE     | 作业执行的退出信息                   |
| LAST_UPDATED     | 最后一次更新记录的时间               |





### batch_job_execution_context表

batch_job_execution_context用于保存JobContext对应的ExecutionContext对象数据。

![image-20240201164407486](https://s2.loli.net/2024/02/01/RxLMGcSE4lBhnQg.png)

| 字段               | 描述                                 |
| ------------------ | ------------------------------------ |
| JOB_EXECUTION_ID   | job执行对象主键                      |
| SHORT_CONTEXT      | ExecutionContext系列化后字符串缩减版 |
| SERIALIZED_CONTEXT | ExecutionContext系列化后字符串       |



### batch_job_execution_params表

作业启动时使用标识性参数保存的位置：batch_job_execution_params， 一个参数一个记录

![image-20240201164449786](https://s2.loli.net/2024/02/01/U2clMxu13zAIghk.png)

| 字段             | 描述                           |
| ---------------- | ------------------------------ |
| JOB_EXECUTION_ID | job执行对象主键                |
| TYPE_CODE        | 标记参数类型                   |
| KEY_NAME         | 参数名                         |
| STRING_VALUE     | 当参数类型为String时有值       |
| DATE_VALUE       | 当参数类型为Date时有值         |
| LONG_VAL         | 当参数类型为LONG时有值         |
| DOUBLE_VAL       | 当参数类型为DOUBLE时有值       |
| IDENTIFYING      | 用于标记该参数是否为标识性参数 |





### batch_step_execution表

作业启动，执行步骤，每个步骤执行信息保存在tch_step_execution表中

![image-20240201164602477](https://s2.loli.net/2024/02/01/1ZBiUeIFWVd7xzg.png)

| 字段               | 描述                                        |
| ------------------ | ------------------------------------------- |
| STEP_EXECUTION_ID  | 步骤执行对象id                              |
| VERSION            | 乐观锁控制版本号                            |
| STEP_NAME          | 步骤名称                                    |
| JOB_EXECUTION_ID   | 作业执行对象id                              |
| START_TIME         | 步骤执行的开始时间                          |
| END_TIME           | 步骤执行的结束时间                          |
| STATUS             | 步骤批处理状态                              |
| COMMIT_COUNT       | 在步骤执行中提交的事务次数                  |
| READ_COUNT         | 读入的条目数量                              |
| FILTER_COUNT       | 由于ItemProcessor返回null而过滤掉的条目数   |
| WRITE_COUNT        | 写入条目数量                                |
| READ_SKIP_COUNT    | 由于ItemReader中抛出异常而跳过的条目数量    |
| PROCESS_SKIP_COUNT | 由于ItemProcessor中抛出异常而跳过的条目数量 |
| WRITE_SKIP_COUNT   | 由于ItemWriter中抛出异常而跳过的条目数量    |
| ROLLBACK_COUNT     | 在步骤执行中被回滚的事务数量                |
| EXIT_CODE          | 步骤的退出码                                |
| EXT_MESSAGE        | 步骤执行返回的信息                          |
| LAST_UPDATE        | 最后一次更新记录时间                        |





### batch_step_execution_context表

StepContext对象对应的ExecutionContext 保存的数据表：batch_step_execution_context

![image-20240201164706783](https://s2.loli.net/2024/02/01/ytIU27RL3NsVJlg.png)



| 字段               | 描述                                 |
| ------------------ | ------------------------------------ |
| STEP_EXECUTION_ID  | 步骤执行对象id                       |
| SHORT_CONTEXT      | ExecutionContext系列化后字符串缩减版 |
| SERIALIZED_CONTEXT | ExecutionContext系列化后字符串       |



> 注意：除了关系型数据库保存的数据外，Spring Batch 也执行内存数据库，比如H2，HSQLDB，这些数据库将数据缓存在内存中，当批处理结束后，数据会被清除，一般用于进行单元测试，不建议在生产环境中使用。







## 作业控制

作业的运行指的是对作业的控制，包括作业启动，作业停止，作业异常处理，作业重启处理等。

### 作业启动

#### SpringBoot启动

目前为止，上面所有的案例都是使用Spring Boot 原生功能来启动作业的，其核心类：**JobLauncherApplicationRunner** ， Spring Boot启动之后，马上调用该类run方法，然后将操作委托给SimpleJobLauncher类run方法执行。默认情况下，Spring Boot一启动马上执行作业。

如果不想Spring Boot启动就执行，可以通过配置进行修改

```yaml
spring:
  batch:
    job:
      enabled: false   #false表示不启动
```





#### Spring单元测试启动

开发中如果想简单验证批处理逻辑是否能运行，可以使用单元测试方式启动作业

先引入spring-test测试依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
</dependency>
```



启动类创建：

```java
@SpringBootApplication
@EnableBatchProcessing
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}
```



测试类创建：

```java
@SpringBootTest(classes = App.class)
public class StartJobTest {
    //job调度器
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("Hello SpringBatch....");
                return RepeatStatus.FINISHED;
            }
        };
    }

    public Step step1(){
        TaskletStep step1 = stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
        return step1;
    }

    //定义作业
    public Job job(){
        Job job = jobBuilderFactory.get("start-test-job")
                .start(step1())
                .build();
        return job;
    }

    @Test
    public void testStart() throws Exception{
        //job作业启动
        //参数1：作业实例，参数2：作业运行携带参数
        jobLauncher.run(job(), new JobParameters());
    }
}
```

![image-20240201165815334](https://s2.loli.net/2024/02/01/EHiqUCBj24Lu61O.png)

跟之前的SpringBoot启动区别在于多了JobLauncher 对象的获取，再由这个对象调用run方法启动。

注意：单元测试无法使用**@Bean**注入的方式





#### RESTful API启动

如果批处理不是SpringBoot启动就启动，而是通过web请求控制，那么引入web环境即可



1.首先，关闭SpringBoot启动的方式，不跟随SpringBoot的启动而启动

```yaml
spring:
  batch:
    job:
      enabled: false  #false表示不跟随SpringBoot启动
```



2.引入web环境依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```



3.编写启动类：

```java
@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}
```



4.编写Config配置类

```java
@EnableBatchProcessing
@Configuration
public class BatchConfig {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.out.println("Hello SpringBatch....");
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Step step1(){
        TaskletStep step1 = stepBuilderFactory.get("step1")
                .tasklet(tasklet())
                .build();
        return step1;
    }
    //定义作业
    @Bean
    public Job job(){
        Job job = jobBuilderFactory.get("hello-restful-job")
                .start(step1())
                .build();
        return job;
    }
}
```



5.编写Controller类

```java
@RestController
public class HelloController {
    @Autowired
    private JobLauncher jobLauncher;
    @Autowired
    private Job job;
    //http://localhost:8080/job/start
    @GetMapping("/job/start")
    public ExitStatus start() throws Exception {
        System.out.println("------------------");
         //启动job作业
        JobExecution jobExet = jobLauncher.run(job, new JobParameters());
        return jobExet.getExitStatus();
    }
}
```



6.测试：

![image-20240201171317854](https://s2.loli.net/2024/02/01/PlCqvowJjg7ruef.png)

查看控制台：

![image-20240201171338708](https://s2.loli.net/2024/02/01/b4YcStOLqrhRzQ5.png)



7.这时候突然想要增加一个需求，需要接收参数

`localhost:8080/job/start/xiaodong`

作业使用run.id自增

构造一个job对象

```java
@Bean
public Job job(){
    Job job = jobBuilderFactory.get("hello-restful-job")
            .start(step1())
            .incrementer(new RunIdIncrementer())
            .build();
    return job;
}
```

新增一个接口：

```java
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
```

重启项目测试并且查看数据库

![image-20240201172941065](https://s2.loli.net/2024/02/01/GJT8qPrEXUdtLo4.png)

![image-20240201173022718](https://s2.loli.net/2024/02/01/HP2VtFRXQUjCG6K.png)





### 作业停止

作业的停止，存在有3种情况：

- 一种自然结束

  作业成功执行，正常停止，此时作业返回状态为：**COMPLETED**

- 一种异常结束

  作业执行过程因为各种意外导致作业中断而停止，大多数作业返回状态为：**FAILED**

- 一种编程结束

 某个步骤处理数据结果不满足下一步骤执行前提，手动让其停止，一般设置返回状态为：**STOPED**

上面1,2种情况相对简单，主要是关于第三种：以编程方式让作业停止。



模拟场景：

1>有一个资源类，里面有2个属性：总数：totalCount = 100， 读取数：readCount = 0

2>设计2个步骤，step1 用于叠加readCount 模拟从数据库中读取资源， step2 用于执行逻辑

3>当totalCount  == readCount  时，为正常情况，正常结束。如果不等时，为异常状态。此时不执行step2，直接停止作业。

4>修复数据，在从step1开始执行，并完成作业

模拟数据：

```java
public class ResouceCount {
    public static int totalCount = 100;  //总数
    public static int  readCount = 0;    //读取数
}
```



#### 方案1：Step步骤监听器方式

创建监听器

```java
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
```



```java
@SpringBootApplication
@EnableBatchProcessing
public class ListenerJobStopJob {

    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    //模拟从数据库中查询数据
    private int readCount = 50; //模拟只读取50个
    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                for (int i = 1; i <= readCount; i++) {
                    System.out.println("---------------step1执行-"+i+"------------------");
                    ResourceCount.readCount ++;
                }
                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("step2执行了.......");
                System.err.println("readCount:" + ResourceCount.readCount + ", totalCount:" + ResourceCount.totalCount);
                return RepeatStatus.FINISHED;
            }
        };
    }

    //注入监听器
    @Bean
    public StopStepListener stopStepListener(){
        return new StopStepListener();
    }

    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .listener(stopStepListener())
                .allowStartIfComplete(true)  //允许step重新执行
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-stop-job")
                .start(step1())
                .on("STOPPED").stopAndRestart(step1())//step1 返回的是STOPPED状态码，马上结束作业流程，设置流程改为：STOPPED，并重新启动step1
                .from(step1()).on("*").to(step2()).end()//如果step1是其他条件，表示满足条件，执行step2步骤
                .build();

    }
    public static void main(String[] args) {
        SpringApplication.run(ListenerJobStopJob.class, args);
    }
}
```

执行结果：

![image-20240201182239383](https://s2.loli.net/2024/02/01/GDIHiyaUfQb7T2O.png)

第一次执行：tasklet1 中readCount 默认执行50次，不满足条件， stopStepListener() afterStep 返回STOPPED, job进行条件控制走**.on("STOPPED").stopAndRestart(step1())**  分支，停止并允许重启--下次重启，从step1步骤开始执行，可以看到step并没有执行

第二次执行， 修改readCount = 100， 再次启动作业，task1遍历100次，满足条件， stopStepListener() afterStep 正常返回，job条件控制走**.from(step1()).on("*").to(step2()).end()**分支，正常结束。

```java
//模拟从数据库中查询数据
private int readCount = 100; 
```

![image-20240201182353386](https://s2.loli.net/2024/02/01/NbzIhBQ2ieGw4pX.png)

注意：step1() 方法中**.allowStartIfComplete(true)**  代码必须添加，因为第一次执行step1步骤，虽然不满足条件，但是它仍属于正常结束(正常执行完tasklet1的流程)，状态码：COMPLETED， 第二次重启，默认情况下正常结束的step1步骤是不允许再执行的，所以必须设置：**.allowStartIfComplete(true)**  允许step1即使完成也可以重启。

查看数据库：

![image-20240201182500228](https://s2.loli.net/2024/02/01/Nz3nUGlvIstp5ey.png)





#### 方案2：StepExecution停止标记



```java
@SpringBootApplication
@EnableBatchProcessing
public class SignJobStopJob {

    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    private int readCount = 50; //模拟只读取50个
    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                for (int i = 1; i <= readCount; i++) {
                    System.out.println("---------------step1执行-"+i+"------------------");
                    ResourceCount.readCount ++;
                }

                if(ResourceCount.readCount != ResourceCount.totalCount){
                    chunkContext.getStepContext().getStepExecution().setTerminateOnly();
                }

                return RepeatStatus.FINISHED;
            }
        };
    }

    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("step2执行了.......");
                System.err.println("readCount:" + ResourceCount.readCount + ", totalCount:" + ResourceCount.totalCount);
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .allowStartIfComplete(true)
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
         return jobBuilderFactory.get("job-stop-job")
                .start(step1())
                //.on("STOPPED").stopAndRestart(step1())
                //.from(step1()).on("*").to(step2()).end()
                .next(step2())
                .build();

    }
    public static void main(String[] args) {
        SpringApplication.run(SignJobStopJob.class, args);
    }
}
```

变动的代码有2处

tasket1(), 多了下面判断

```java
if(ResourceCount.readCount != ResourceCount.totalCount){
    chunkContext.getStepContext().getStepExecution().setTerminateOnly();
}
```

其中的StepExecution#setTerminateOnly() 给运行中的stepExecution设置停止标记，Spring Batch 识别后直接停止步骤，进而停止流程

job() 改动

```java
return jobBuilderFactory.get("job-stop-sign-job")
    .start(step1())
    .next(step2())
    .build();
```

测试50和100即可，跟方案1的结果是一样的。







### 作业重启

前面作业停止方案一种有提到作业重启的概念，现在具体描述一下：

作业重启，表示允许作业步骤重新执行，默认情况下，只允许异常或终止状态的步骤重启，但有时存在特殊场景，要求需要其他状态步骤重启，为应付各种复杂的情形，Spring Batch 提供3种重启控制操作。



#### 禁止重启

这种适用一次性执行场景，如果执行失败，就不允许再次执行。可以使用作业的禁止重启逻辑

```java
@SpringBootApplication
@EnableBatchProcessing
public class JobForBidRestartJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet1-------------");

                chunkContext.getStepContext().getStepExecution().setTerminateOnly(); //停止步骤
                return RepeatStatus.FINISHED;

            }
        };
    }

    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet2-------------");
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-forbid-restart-job")
                .preventRestart()  //禁止重启
                .start(step1())
                .next(step2())
                .build();

    }
    public static void main(String[] args) {
        SpringApplication.run(JobForBidRestartJob.class, args);
    }
}
```

tasklet1()   加了setTerminateOnly 设置，表示让步骤退出

```java
chunkContext.getStepContext().getStepExecution().setTerminateOnly();
```

job()  多了**.preventRestart()** 逻辑，表示步骤不允许重启

第一次按上面的代码执行一次， step1()  状态为 **STOPPED**

![image-20240202110827523](https://s2.loli.net/2024/02/02/yn2pNUMK9wclCWA.png)

程序将会卡在这里不会继续执行下去。

第二次去掉setTerminateOnly逻辑，重新启动步骤，观察结果，直接报错

![image-20240202110945386](https://s2.loli.net/2024/02/02/UhfLT9Vvu3oX2Zp.png)





#### 限制重启次数

适用于重启次数有限的场景，比如下载/读取操作，可能因为网络原因导致下载/读取失败，运行重试几次，但是不能无限重试。这时可以对步骤执行进行重启次数限制。

```java
@SpringBootApplication
@EnableBatchProcessing
public class JobLimitRestartJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet1-------------");

                chunkContext.getStepContext().getStepExecution().setTerminateOnly(); //停止步骤
                return RepeatStatus.FINISHED;

            }
        };
    }

    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet2-------------");
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .startLimit(2)
                .tasklet(tasklet1())
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-restart-limit-job")
                .start(step1())
                .next(step2())
                .build();

    }
    public static void main(String[] args) {
        SpringApplication.run(JobLimitRestartJob.class, args);
    }
}
```

变动：

step1() 添加了**.startLimit(2)**  表示运行重启2次，注意，第一次启动也算一次

tasklet1()  设置setTerminateOnly  第一次先让step1 状态为**STOPPED**  

第一次执行， step1 为 **STOPPED**   状态

![image-20240202111645911](https://s2.loli.net/2024/02/02/TIYcloKF1JbXLOi.png)

第二次执行，不做任何操作，第二次执行，step1 还是STOPPED状态

第三次执行， 注释掉tasklet1() 中setTerminateOnly ， 查询结果

![image-20240202111935738](https://s2.loli.net/2024/02/02/x6sMgn5ud9OLY2F.png)





#### 无限重启

Spring Batch 限制同job名跟同标识参数作业只能成功执行一次，这是Spring Batch 定理，无法改变的。但是，对于步骤不一定适用，可以通过步骤的allowStartIfComplete(true) 实现步骤的无限重启。

```java
@SpringBootApplication
@EnableBatchProcessing
public class JobAllowRestartJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public Tasklet tasklet1(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet1-------------");
                return RepeatStatus.FINISHED;

            }
        };
    }

    @Bean
    public Tasklet tasklet2(){
        return new Tasklet() {
            @Override
            public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
                System.err.println("-------------tasklet2-------------");
                return RepeatStatus.FINISHED;
            }
        };
    }


    @Bean
    public Step step1(){
        return stepBuilderFactory.get("step1")
                .tasklet(tasklet1())
                .build();
    }

    @Bean
    public Step step2(){
        return stepBuilderFactory.get("step2")
                .tasklet(tasklet2())
                .build();
    }

    //定义作业
    @Bean
    public Job job(){
        return jobBuilderFactory.get("job-allow-restart-job")
                .start(step1())
                .next(step2())
                .build();

    }
    public static void main(String[] args) {
        SpringApplication.run(JobAllowRestartJob.class, args);
    }
}
```



观察上面代码，很正常逻辑

第一次启动：step1 step2正常执行，整个Job 成功执行完成

![image-20240202112408730](https://s2.loli.net/2024/02/02/WGhUJmNOtg38V1C.png)

第二次启动：不做任何改动时，再次启动job，没有报错，但是观察数据库表batch_job_execution 状态为 **NOOP** 无效执行，step1 step2 不会执行。

![image-20240202112438429](https://s2.loli.net/2024/02/02/jxmXNAd54EJHnGL.png)

![image-20240202112607827](https://s2.loli.net/2024/02/02/d9uFqy8Goce7VzC.png)

第三次启动：给step1  step2 添加上**.allowStartIfComplete(true)**， 再次启动，一切正常，并且可以无限启动

![image-20240202112548561](https://s2.loli.net/2024/02/02/PnXjZY4NV2Rpyr9.png)







## ItemReader

### 读取平面文件

平面文件一般指的都是简单行/多行结构的纯文本文件，比如记事本记录文件。与xml这种区别在于没有结构，没有标签的限制。Spring Batch默认使用 FlatFileItemReader 实现平面文件的输入。

#### 方式1：delimited-字符串截取

**需求：读取user.txt文件，解析出所有用户信息**

user.txt

```tex
1#xiaodong#18
2#xiaojia#16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```



User实体类：

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



作业代码：

```java
@SpringBootApplication
@EnableBatchProcessing
public class FlatReaderJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    //FlatFileItemReader spring batch 平面文件读入类
    //这个类操作特点：一行一行的读数据
    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
               .resource(new ClassPathResource("user.txt"))//指定读取的文件
                .delimited().delimiter("#")//读取出了一行数据，如何分隔数据，默认以,分隔，当前使用#号分隔
                .names("id", "name", "age")//给分割后数据打name标记，后续跟User对象属性进行映射
                .targetType(User.class)//读取出的数据分割成什么对象
                
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("flat-reader-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(FlatReaderJob.class, args);
    }
}
```

这段代码的核心就在这里：

```java
//FlatFileItemReader spring batch 平面文件读入类
//这个类操作特点：一行一行的读数据
@Bean
public FlatFileItemReader<User> userItemReader(){
    return new FlatFileItemReaderBuilder<User>()
            .name("userItemReader")
           .resource(new ClassPathResource("user.txt"))//指定读取的文件
            .delimited().delimiter("#")//读取出了一行数据，如何分隔数据，默认以,分隔，当前使用#号分隔
            .names("id", "name", "age")//给分割后数据打name标记，后续跟User对象属性进行映射
            .targetType(User.class)//读取出的数据分割成什么对象
            
            .build();
}
```

FlatFileItemReaderBuilder还提供.**fieldSetMapper  .lineTokenizer**  2个方法，用于定制文件解析与数据映射。

![image-20240202151414311](https://s2.loli.net/2024/02/02/HmZ1eibxRtr5c3A.png)



#### 方式2：FieldSetMapper-字段映射

FlatFileItemReaderBuilder 提供的方法，用于字段映射，方法参数是一个FieldSetMapper接口对象

```java
public interface FieldSetMapper<T> {
	T mapFieldSet(FieldSet fieldSet) throws BindException;
}
```



FieldSet 字段集合，FlatFileItemReader 解析出一行数据，会将这行数据封装到FieldSet对象中。

编写users2.txt文件

```tex
1#xiaodong#18#江苏#南通#海门区
2#xiaojia#16#四川#成都#青羊区
3#xiaoxue#20#四川#南充#南部县
4#xiaoming#19#广东#广州#白云区
5#xiaogang#15#广东#广州#越秀区
```



用户对象：

```java
@Getter
@Setter
@ToString
public class User2 {
    private Long id;
    private String name;
    private int age;
    private String address;
}
```

观察，user2.txt文件中有 id  name   age  province   city    area   按理用户对象属性应该一一对应，但是此时User只有address，也就是说，后续要将 province   ，  city  ， area 合并成 address 地址值。此时就需要自定义FieldSetMapper 。

```java
/**
 * @Author ldd
 * @Date 2024/2/2
 */
public class UserFieldMapper implements FieldSetMapper<User2> {
    @Override
    public User2 mapFieldSet(FieldSet fieldSet) throws BindException {
        //定义自己的映射逻辑
        User2 user = new User2();
        user.setId(fieldSet.readLong("id"));
        user.setAge(fieldSet.readInt("age"));
        user.setName(fieldSet.readString("name"));
        String address= fieldSet.readString("province")+""+fieldSet.readString("city")+""+fieldSet.readString("area");
        user.setAddress(address);
        return user;
    }
}
```

上面代码实现FieldSet与User对象映射，将province  city   area 合并成一个属性address。另外readXxx 是FieldSet 独有的方法，Xxx是java基本类型。

```java
@SpringBootApplication
@EnableBatchProcessing
public class MapperFlatReaderJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    //注入自己的字段映射器
    @Bean
    public UserFieldMapper userFieldMapper(){
        return new UserFieldMapper();
    }


    @Bean
    public FlatFileItemReader<User2> userItemReader(){
        return new FlatFileItemReaderBuilder<User2>()
                .name("userMapperItemReader")
                .resource(new ClassPathResource("user2.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age", "province", "city", "area")//将其封装到FieldSet对象中
                .fieldSetMapper(userFieldMapper())//使用了fieldSetMapper 之后，不需要.targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User2> itemWriter(){
        return new ItemWriter<User2>() {
            @Override
            public void write(List<? extends User2> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User2, User2>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("mapper-flat-reader-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(MapperFlatReaderJob.class, args);
    }
}
```

核心部分：

```java
    //注入自己的字段映射器
    @Bean
    public UserFieldMapper userFieldMapper(){
        return new UserFieldMapper();
    }


    @Bean
    public FlatFileItemReader<User2> userItemReader(){
        return new FlatFileItemReaderBuilder<User2>()
                .name("userMapperItemReader")
                .resource(new ClassPathResource("user2.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age", "province", "city", "area")//将其封装到FieldSet对象中
                .fieldSetMapper(userFieldMapper())//使用了fieldSetMapper 之后，不需要.targetType(User.class)
                .build();
    }
```

![image-20240202151433687](https://s2.loli.net/2024/02/02/s9NbQtM82mqVkeZ.png)



### 读取JSON文件

Spring Batch 也提供专门操作Json文档的API ： JsonItemReader

**需求：读取下面json格式文档**

```json
[
  {"id":1, "name":"xiaodong", "age":18},
  {"id":2, "name":"xiaojia", "age":17},
  {"id":3, "name":"xiaoxue", "age":16},
  {"id":4, "name":"xiaoming", "age":15},
  {"id":5, "name":"xiaogang", "age":14}
]
```

User对象

```java
/**
 * @Author ldd
 * @Date 2024/2/2
 */
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



```java
@SpringBootApplication
@EnableBatchProcessing
public class JsonFlatReaderJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    //指定JsonItemReader
    @Bean
    public JsonItemReader<User> userItemReader(){


        //当前读取json使用的是Jackson（阿里的）
        //参数：读取json格式的文件转换为具体的类型
    	JacksonJsonObjectReader<User> jsonObjectReader = new JacksonJsonObjectReader<>(User.class);

        ObjectMapper objectMapper = new ObjectMapper();
        jsonObjectReader.setMapper(objectMapper);

        return new JsonItemReaderBuilder<User>()
                .name("userJsonItemReader")
                .jsonObjectReader(jsonObjectReader)
                .resource(new ClassPathResource("user.json"))
            .build();
	}

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User,User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("json-flat-reader-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(JsonFlatReaderJob.class, args);
    }
}
```

核心就是：userItemReader() 实例方法，明确指定转换成json格式需要使用转换器，本次使用的Jackson

![image-20240202153136480](https://s2.loli.net/2024/02/02/mc6vzAy5xM8fSlG.png)



### 读数据库

下面是一张数据库user表，如何获取

```sql
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `age` int DEFAULT NULL COMMENT '年龄',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
```

```sql
INSERT INTO `user` VALUES (1, 'xiaodong', 18);
INSERT INTO `user` VALUES (2, 'xiaojia', 17);
INSERT INTO `user` VALUES (3, 'xiaoxue', 16);
INSERT INTO `user` VALUES (4, 'xiaoming', 15);
INSERT INTO `user` VALUES (5, 'xiaogang', 14);
```

Spring Batch 提供2种从数据库中读取数据的方式：

#### 根据游标方式

![image-20240202153805348](https://s2.loli.net/2024/02/02/v73ONkzlqyCUnPL.png)

游标是数据库中概念，可以简单理解为一个指针

![image-20240202153841021](https://s2.loli.net/2024/02/02/BgiYqN3oD8LT7Oh.png)

游标遍历时，获取数据表中某一条数据，如果使用JDBC操作，游标指向的那条数据会被封装到ResultSet中，如果想将数据从ResultSet读取出来，需要借助Spring Batch 提供RowMapper 实现表数据与实体对象的映射

```java
user表数据---->User对象
```

Spring Batch JDBC 实现数据表读取

User对象：

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```

RowMapper   表与实体对象映射实现类：

```java
public class UserRowMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("id"));
        user.setName(rs.getString("name"));
        user.setAge(rs.getInt("age"));
        return user;
    }
}
```

JdbcCursorItemReader：

```java
@SpringBootApplication
@EnableBatchProcessing
public class CursorDBReaderJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Autowired
    private DataSource dataSource;

    //注入UserRowMapper
    @Bean
    public UserRowMapper userRowMapper(){
        return new UserRowMapper();
    }

    @Bean
    public JdbcCursorItemReader<User> userItemReader(){

        return new JdbcCursorItemReaderBuilder<User>()
                .name("userCursorItemReader")
                //连接数据库
                .dataSource(dataSource)
                //执行sql语句将返回的数据以游标的方式一条条读取
                .sql("select * from user")
                .rowMapper(userRowMapper())
                .build();
   }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("cursor-db-reader-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(CursorDBReaderJob.class, args);
    }
}
```

![image-20240202154440199](https://s2.loli.net/2024/02/02/yD5NHU2auex7FBj.png)

分析：

1>操作数据库，需要引入DataSource

2>userItemReader() 方法，需要明确指定操作数据库sql

3>userItemReader() 方法，需要明确指定游标回来之后，数据映射规则：rowMapper

这里要注意，如果sql需要where 条件，需要额外定义

比如： 查询 age > 16的用户

```java
@Bean
public JdbcCursorItemReader<User> userItemReader(){

    return new JdbcCursorItemReaderBuilder<User>()
        .name("userCursorItemReader")
        .dataSource(dataSource)
        .sql("select * from user where age > ?")
        .rowMapper(userRowMapper())
        //拼接参数
        .preparedStatementSetter(new ArgumentPreparedStatementSetter(new Object[]{16}))
        .build();
}
```

```java
@Bean
public Job job(){
    return jobBuilderFactory.get("cursor-db-reader-job-age>16")
            .start(step())
            .build();
}
```

![image-20240202154958795](https://s2.loli.net/2024/02/02/CIjPwylRm9SFTn6.png)

#### 根据分页方式

![image-20240202155040577](https://s2.loli.net/2024/02/02/W1BO63pvk9C4Yr2.png)

游标的方式是查询出所有满足条件的数据，然后一条一条读取，而分页是按照指定设置的pageSize数，一次性读取pageSize条。

**分页查询方式需要几个要素**

**1>实体对象，跟游标方式一样**

**2>RowMapper映射对象，跟游标方式一样**

**3>数据源，跟游标方式一样**

**4>PagingQueryProvider 分页逻辑提供者**

```java
@SpringBootApplication
@EnableBatchProcessing
public class PageDBReaderJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Autowired
    private DataSource dataSource;

    @Bean
    public UserRowMapper userRowMapper(){
        return new UserRowMapper();
    }


    //注入分页逻辑
    @Bean
    public PagingQueryProvider pagingQueryProvider() throws Exception {
        SqlPagingQueryProviderFactoryBean factoryBean = new SqlPagingQueryProviderFactoryBean();
        factoryBean.setDataSource(dataSource);
        factoryBean.setSelectClause("select *");   //查询列
        factoryBean.setFromClause("from user");    //查询的表
        factoryBean.setWhereClause("where age > :age"); //where 条件
        factoryBean.setSortKey("id");   //结果排序
        return factoryBean.getObject();
    }

    @Bean
    public JdbcPagingItemReader<User> userItemReader() throws Exception {
        HashMap<String, Object> param = new HashMap<>();
        param.put("age", 16);
        return new JdbcPagingItemReaderBuilder<User>()
                .name("userPagingItemReader")
                .dataSource(dataSource)  //数据源
                .queryProvider(pagingQueryProvider())  //分页逻辑
                .parameterValues(param)   //条件
                .pageSize(10) //每页显示条数
                .rowMapper(userRowMapper())  //映射规则
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step() throws Exception {
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job() throws Exception {
        return jobBuilderFactory.get("page-db-reader-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(PageDBReaderJob.class, args);
    }
}
```

现在把user表中的数据增加到30条

```sql
INSERT INTO `user` VALUES (6, 'xiaodong2', 18);
INSERT INTO `user` VALUES (7, 'xiaojia2', 17);
INSERT INTO `user` VALUES (8, 'xiaoxue2', 16);
INSERT INTO `user` VALUES (9, 'xiaoming2', 15);
INSERT INTO `user` VALUES (10, 'xiaogang2', 14);
INSERT INTO `user` VALUES (11, 'xiaodong3', 18);
INSERT INTO `user` VALUES (12, 'xiaojia3', 17);
INSERT INTO `user` VALUES (13, 'xiaoxue3', 16);
INSERT INTO `user` VALUES (14, 'xiaoming3', 15);
INSERT INTO `user` VALUES (15, 'xiaogang3', 14);
INSERT INTO `user` VALUES (16, 'xiaodong4', 18);
INSERT INTO `user` VALUES (17, 'xiaojia4', 17);
INSERT INTO `user` VALUES (18, 'xiaoxue4', 16);
INSERT INTO `user` VALUES (19, 'xiaoming4', 15);
INSERT INTO `user` VALUES (20, 'xiaogang4', 14);
INSERT INTO `user` VALUES (21, 'xiaodong5', 18);
INSERT INTO `user` VALUES (22, 'xiaojia5', 17);
INSERT INTO `user` VALUES (23, 'xiaoxue5', 16);
INSERT INTO `user` VALUES (24, 'xiaoming5', 15);
INSERT INTO `user` VALUES (25, 'xiaogang5', 14);
INSERT INTO `user` VALUES (26, 'xiaodong6', 18);
INSERT INTO `user` VALUES (27, 'xiaojia6', 17);
INSERT INTO `user` VALUES (28, 'xiaoxue6', 16);
INSERT INTO `user` VALUES (29, 'xiaoming6', 15);
INSERT INTO `user` VALUES (30, 'xiaogang6', 14);
```

启动测试：

![image-20240202160214487](https://s2.loli.net/2024/02/02/ZhAu2Cxsl8Eiwev.png)

1>需要提供pagingQueryProvider 用于拼接分页SQL

2>userItemReader() 组装分页查询逻辑。



### 读取异常

任何输入都有可能存在异常情况，那Spring Batch 应对异常的方式有3种操作逻辑：

> 1.跳过异常记录

这里逻辑是当Spring Batch 在读取数据时，根据各种意外情况抛出不同异常，ItemReader 可以按照约定跳过指定的异常，同时也可以限制跳过次数。

```java
@Bean
public Step step() throws Exception {
    return stepBuilderFactory.get("step1")
        .<User, User>chunk(1)
        .reader(userItemReader())
        .writer(itemWriter())
        .faultTolerant() //容错
        .skip(Exception.class)  //跳过啥异常
        .noSkip(RuntimeException.class)  //不能跳过啥异常
        .skipLimit(10)  //跳过异常次数
        .skipPolicy(new SkipPolicy() {
            @Override
            public boolean shouldSkip(Throwable t, int skipCount) throws SkipLimitExceededException {
                //定制跳过异常与异常次数
                return false;
            }
        })
        .build();

}
```

如果出错直接跳过去，并不是优雅的解决方案。开发可选下面这种。



> 2.异常记录写进日志

所谓记录日志，就是当ItemReader 读取数据抛出异常时，将具体数据信息记录下来，方便后续人工接入。

具体实现使用ItemReader监听器。

```java
public class ErrorItemReaderListener implements ItemReadListener {
    @Override
    public void beforeRead() {

    }

    @Override
    public void afterRead(Object item) {

    }

    @Override
    public void onReadError(Exception ex) {
        System.out.println("记录读数据相关信息...");
    }
}
```





> 3.放弃处理



这种异常在处理不是很重要数据时候使用。





## ItemProcessor

根据前面知道，居于块的读与写，中间还夹着一个ItemProcessor  条目处理。当我们通过ItemReader 将数据读取出来之后，你面临2个选择：

1>直接将数据转向输出  

 2>对读入的数据进行再加工。

如果选择第一种，那ItemProcessor 可以不用出现，如果选择第二种，就需要引入ItemProcessor 条目处理组件。

Spring Batch 为Processor 提供**默认的处理器**与**自定义处理器**2种模式以满足各种需求。



### 默认ItemProcessor

Spring Batch 提供现成的ItemProcessor 组件有4种：

####  ValidatingItemProcessor：校验处理器

很多时候ItemReader读出来的数据是相对原始的数据，并没有做过多的校验

数据文件user-validate.txt

```tex
1##18
2##16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```

比如上面文本数据，第一条，第二条name数值没有指定，在ItemReader 读取之后，必定将 "" 空串封装到User name属性中，语法上没有错，但逻辑上可以做文章，比如：用户名不为空。

解决上述问题，可以使用Spring Batch 提供ValidatingItemProcessor 校验器处理。



> 1.导入校验依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-validation</artifactId>
</dependency>
```



> 2.定义实体对象

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    @NotBlank(message = "用户名不能为null或空串")
    private String name;
    private int age;
}
```



> 3.实现

```java
/**
 * @Author ldd
 * @Date 2024/2/5
 */

@SpringBootApplication
@EnableBatchProcessing
public class ValidationProcessorJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-validate.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }


    @Bean
    public BeanValidatingItemProcessor<User> beanValidatingItemProcessor(){
        BeanValidatingItemProcessor<User> beanValidatingItemProcessor = new BeanValidatingItemProcessor<>();
        beanValidatingItemProcessor.setFilter(true);  //不满足条件丢弃数据

        return beanValidatingItemProcessor;
    }


    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .processor(beanValidatingItemProcessor())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("validate-processor-job4")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ValidationProcessorJob.class, args);
    }
}
```

核心BeanValidatingItemProcessor 类是Spring Batch 提供现成的Validator校验类，这里直接使用即可,BeanValidatingItemProcessor 是 ValidatingItemProcessor 子类。

![image-20240205095745607](https://s2.loli.net/2024/02/05/61POecu7UlbxyRW.png)



####  ItemProcessorAdapter：适配器处理器

很多的校验逻辑已经有现成的，做ItemProcessor处理时候，如何使用现成逻辑？

**需求：现有处理逻辑：将User对象中name转换成大写**

```java
public class UserServiceImpl{
    public User toUpperCaseTest(User user){
        user.setName(user.getName().toUpperCase());
        return user;
    }
}
```

user-adapter.txt

```tex
1#xiaodong#18
2#xiaojia#16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```

逻辑代码

```java
@SpringBootApplication
@EnableBatchProcessing
public class AdapterProcessorJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-adapter.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public UserServiceImpl userService(){
        return new UserServiceImpl();
    }
    @Bean
    public ItemProcessorAdapter<User, User> itemProcessorAdapter(){
        ItemProcessorAdapter<User, User> adapter = new ItemProcessorAdapter<>();
        adapter.setTargetObject(userService());
        adapter.setTargetMethod("toUpperCaseTest");

        return adapter;
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .processor(itemProcessorAdapter())
                .writer(itemWriter())
                .build();

    }
    @Bean
    public Job job(){
        return jobBuilderFactory.get("adapter-processor-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(AdapterProcessorJob.class, args);
    }
}
```

itemProcessorAdapter()实例方法，引入ItemProcessorAdapter 适配器类，绑定自定义的UserServiceImpl 类与toUppeCase方法，当ItemReader 读完之后，马上调用UserServiceImpl  类的toUppeCase 方法处理逻辑。方法传参数会被忽略，ItemProcessor会自动处理。

![image-20240205100907863](https://s2.loli.net/2024/02/05/Naf1WIHTJKh74FY.png)





####  ScriptItemProcessor：脚本处理器

就拿前面User的name转换为大写来举例子，SpringBatch也提供了js脚本的形式，将上面的逻辑写到js文件中，加载这个脚本文件一样能实现。**好处就是：省去定义类，定义方法的麻烦。**

**需求：使用js脚本方式实现用户名大写处理**

userScript.js

```javascript
item.setName(item.getName().toUpperCase());
item;
```

item是约定的单词，表示ItemReader读除来每个条目

userScript.js文件放置到resource资源文件中

```java
@SpringBootApplication
@EnableBatchProcessing
public class ScriptProcessorJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-adapter.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }


    @Bean
    public ScriptItemProcessor<User, User> scriptItemProcessor(){
        ScriptItemProcessor scriptItemProcessor = new ScriptItemProcessor();
        scriptItemProcessor.setScript(new ClassPathResource("js/userScript.js"));
        return scriptItemProcessor;
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .processor(scriptItemProcessor())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("script-processor-job2")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ScriptProcessorJob.class, args);
    }
}
```

核心还是scriptItemProcessor() 实例方法，ScriptItemProcessor 类用于加载js 脚本并处理js脚本。

CompositeItemProcessor是一个ItemProcessor处理组合，类似于过滤器链，数据先经过第一个处理器，然后再经过第二个处理器，直到最后。前一个处理器处理的结果，是后一个处理器的输出。



![image-20240205110916134](https://s2.loli.net/2024/02/05/95Y48RaSK6owGlc.png)





#### CompositeItemProcessor：组合处理器

**需求：将解析出来用户name进行判空处理，并将name属性转换成大写**



user-validate.txt

```tex
1##18
2##16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```



User:

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    @NotBlank(message = "用户名不能为null或空串")
    private String name;
    private int age;
}
```



大小写转换实现类：

```java
public class UserServiceImpl {
    public com.ldd.itemprocessor_adapter.User toUpperCaseTest(User user){
        user.setName(user.getName().toUpperCase());
        return user;
    }
}
```



完整逻辑：

```java
@SpringBootApplication
@EnableBatchProcessing
public class CompositeProcessorJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-validate.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public UserServiceImpl userService(){
        return new UserServiceImpl();
    }
    @Bean
    public BeanValidatingItemProcessor<User> beanValidatingItemProcessor(){
        BeanValidatingItemProcessor<User> beanValidatingItemProcessor = new BeanValidatingItemProcessor<>();
        beanValidatingItemProcessor.setFilter(true);  //不满足条件丢弃数据
        return beanValidatingItemProcessor;
    }

    @Bean
    public ItemProcessorAdapter<User, User> itemProcessorAdapter(){
        ItemProcessorAdapter<User, User> adapter = new ItemProcessorAdapter<>();
        adapter.setTargetObject(userService());
        adapter.setTargetMethod("toUpperCaseTest");

        return adapter;
    }

    @Bean
    public CompositeItemProcessor<User, User> compositeItemProcessor(){
        CompositeItemProcessor<User, User> compositeItemProcessor = new CompositeItemProcessor<>();
        compositeItemProcessor.setDelegates(Arrays.asList(
                beanValidatingItemProcessor(), itemProcessorAdapter()
        ));
        return  compositeItemProcessor;
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .processor(compositeItemProcessor())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("composite-processor-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(CompositeProcessorJob.class, args);
    }
}
```

核心：compositeItemProcessor() 实例方法，使用setDelegates 操作将其他ItemProcessor 处理合并成一个。

![image-20240205112950189](./image/dJKchak7tpxzjq1.png)





### 自定义ItemProcessor处理器

Spring Batch 允许自定义，具体做法只需要实现ItemProcessor接口即可

**需求：自定义处理器，筛选出id为偶数的用户**

user.txt

```tex
1#xiaodong#18
2#xiaojia#16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```



User：

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



自定义处理器：

```java
public class CustomizeItemProcessor implements ItemProcessor<User, User> {
    @Override
    public User process(User item) throws Exception {
        //id为偶数的直接抛弃
        //返回null时候，读入的item会被抛弃，不会进入itemWriter
        return item.getId() % 2 != 0 ? item : null;
    }
}
```

作业逻辑：

```java
@SpringBootApplication
@EnableBatchProcessing
public class CustomizeProcessorJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }
    @Bean
    public CustomizeItemProcessor customizeItemProcessor(){
        return new CustomizeItemProcessor();
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .processor(customizeItemProcessor())
                .writer(itemWriter())
                .build();

    }
    @Bean
    public Job job(){
        return jobBuilderFactory.get("customize-processor-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(CustomizeProcessorJob.class, args);
    }
}
```

![image-20240205113722628](https://s2.loli.net/2024/02/05/mdCPAROxviuon91.png)

## ItemWriter

ItemWriter， Spring Batch提供的数据输出组件与数据输入组件是成对，也就是说有啥样子的输入组件，就有啥样子的输出组件。



### 输出平面文件

当将读入的数据输出到纯文本文件时，可以通过FlatFileItemWriter 输出器实现。

**需求：将user.txt中数据读取出来，输出到outUser.txt文件中**

user.txt:

```tex
1#xiaodong#18
2#xiaojia#16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
```



User:

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



实现逻辑：

```java
@SpringBootApplication
@EnableBatchProcessing
public class FlatWriteJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public FlatFileItemWriter<User> itemWriter(){
        return new FlatFileItemWriterBuilder<User>()
                .name("userItemWriter")
                .resource(new PathResource("D:\\DevelopSpace\\IdeaSpace\\spring-batch-example\\src\\main\\resources\\outUser.txt"))  //输出的文件
                .formatted()  //数据格式指定
                .format("id: %s,姓名：%s,年龄：%s")  //输出数据格式
                .names("id", "name", "age")  //需要输出属性
                .build();
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("flat-writer-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(FlatWriteJob.class, args);
    }
}
```

核心代码具体：

```java
@Bean
public FlatFileItemWriter<User> itemWriter(){
    return new FlatFileItemWriterBuilder<User>()
        .name("userItemWriter")
        .resource(new PathResource("c:/outUser.txt"))  //输出的文件
        .formatted()  //数据格式指定
        .format("id: %s,姓名：%s,年龄：%s")  //输出数据格式
        .names("id", "name", "age")  //需要输出属性
        .shouldDeleteIfEmpty(true)   //如果读入数据为空，输出时创建文件直接删除
        .shouldDeleteIfExists(true) //如果输出文件已经存在，则删除
        .append(true)  //如果输出文件已经存在， 不删除，直接追加到现有文件中
        .build();
}
```

![image-20240205114449593](https://s2.loli.net/2024/02/05/6OhkSMlbUYILwzZ.png)

### 输出Json文件

当将读入的数据输出到Json文件时，可以通过JsonFileItemWriter输出器实现。

**需求：将user.txt中数据读取出来，输出到outUser.json文件中**

user.txt和User不变

```java
@SpringBootApplication
@EnableBatchProcessing
public class JsonWriteJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }


    @Bean
    public JacksonJsonObjectMarshaller<User> objectMarshaller(){
        JacksonJsonObjectMarshaller marshaller = new JacksonJsonObjectMarshaller();
        return marshaller;
    }

    @Bean
    public JsonFileItemWriter<User> itemWriter(){
        return new JsonFileItemWriterBuilder<User>()
                .name("jsonUserItemWriter")
                .resource(new PathResource("D:\\DevelopSpace\\IdeaSpace\\spring-batch-example\\src\\main\\resources\\outUser.json"))
                .jsonObjectMarshaller(objectMarshaller())
                .build();
    }


    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("json-writer-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(JsonWriteJob.class, args);
    }
}
```

itemWriter() 实例方法构建JsonFileItemWriter 实例，需要明确指定Json格式装配器

Spring Batch默认提供装配器有2个：JacksonJsonObjectMarshaller   GsonJsonObjectMarshaller 分别对应Jackson 跟 Gson 2种json格式解析逻辑，本次用的是Jackson

![image-20240205115011927](https://s2.loli.net/2024/02/05/ui3MYgC87FGhktZ.png)

### 输出数据库

当将读入的数据需要输出到数据库时，可以通过JdbcBatchItemWriter输出器实现。

**需求：将user.txt中数据读取出来，输出到数据库user表中**

因为之前的案例中把User表的数量增加到了id=30个数据，所以user.txt进行一些修改

user-db.txt

```tex
31#xiaotian#18
32#xiaocheng#16
33#xiaoli#20
34#xiaobai#19
35#xiaona#15
```

沿用上面的user对象将数据输出到user表中



完整代码：

```java
@SpringBootApplication
@EnableBatchProcessing
public class JdbcWriteJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Autowired
    private DataSource dataSource;

    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-db.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }
    @Bean
    public UserPreStatementSetter preStatementSetter(){
        return new UserPreStatementSetter();
    }
    @Bean
    public JdbcBatchItemWriter<User> itemWriter(){
        return new JdbcBatchItemWriterBuilder<User>()
                .dataSource(dataSource)
                .sql("insert into user(id, name, age) values(?,?,?)")
                .itemPreparedStatementSetter(preStatementSetter())
                .build();
    }
    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(itemWriter())
                .build();
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("jdbc-writer-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(JdbcWriteJob.class, args);
    }
}
```

itemWriter() 实例方法中， 需要1>准备构建JdbcBatchItemWriter实例  2>提前准备数据， 3>准备sql语句  4>准备参数绑定器

![image-20240205115756976](https://s2.loli.net/2024/02/05/Ak3LajzcgE5Twh4.png)





### 输出多终端

上面几种输出方法都是一对一，可能存在一对多，多个终端输出，此时使用Spring Batch 提供的CompositeItemWriter 组合输出器。

**需求：将user-mult.txt中数据读取出来，输出到outUser.txt/outUser.json/数据库user表中**

user-multi.txt

```tex
36#xiaotian2#18
37#xiaocheng2#16
38#xiaoli2#20
39#xiaobai2#19
40#xiaona2#15
```

```java
@SpringBootApplication
@EnableBatchProcessing
public class CompositeWriteJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Autowired
    public DataSource dataSource;

    @Bean
    public FlatFileItemReader<User> userItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-multi.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public FlatFileItemWriter<User> flatFileItemWriter(){
        return new FlatFileItemWriterBuilder<User>()
                .name("userItemWriter")
                .resource(new PathResource("D:\\DevelopSpace\\IdeaSpace\\spring-batch-example\\src\\main\\resources\\outUser.txt"))
                .formatted()  //数据格式指定
                .format("id: %s,姓名：%s,年龄：%s")  //输出数据格式
                .names("id", "name", "age")  //需要输出属性
                .build();
    }

    @Bean
    public JacksonJsonObjectMarshaller<User> objectMarshaller(){
        JacksonJsonObjectMarshaller marshaller = new JacksonJsonObjectMarshaller();
        return marshaller;
    }

    @Bean
    public JsonFileItemWriter<User> jsonFileItemWriter(){
        return new JsonFileItemWriterBuilder<User>()
                .name("jsonUserItemWriter")
                .resource(new PathResource("D:\\DevelopSpace\\IdeaSpace\\spring-batch-example\\src\\main\\resources\\outUser.json"))
                .jsonObjectMarshaller(objectMarshaller())
                .build();
    }

    @Bean
    public UserPreStatementSetter preStatementSetter(){
        return new UserPreStatementSetter();
    }


    @Bean
    public JdbcBatchItemWriter<User> jdbcBatchItemWriter(){
        return new JdbcBatchItemWriterBuilder<User>()
                .dataSource(dataSource)
                .sql("insert into user(id, name, age) values(?,?,?)")
                .itemPreparedStatementSetter(preStatementSetter())
                .build();
    }

    @Bean
    public CompositeItemWriter<User> compositeItemWriter(){
        return new CompositeItemWriterBuilder<User>()
                .delegates(Arrays.asList(flatFileItemWriter(), jsonFileItemWriter(), jdbcBatchItemWriter()))
                .build();
    }


    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(1)
                .reader(userItemReader())
                .writer(compositeItemWriter())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("composite-writer-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(CompositeWriteJob.class, args);
    }
}
```

将前面的几种方式通过CompositeItemWriter 类整合在一起

```java
@Bean
public CompositeItemWriter<User> compositeItemWriter(){
    return new CompositeItemWriterBuilder<User>()
        .delegates(Arrays.asList(flatFileItemWriter(), jsonFileItemWriter(), jdbcBatchItemWriter()))
        .build();
}
```







## SpringBatch拓展

Spring Batch 基本上能满足日常批处理了，下面则是Spring Batch 拓展

### 多线程步骤

默认的情况下，步骤基本上在单线程中执行，**在多线程环境执行，步骤是要设置不可重启**

Spring Batch 的多线程步骤是使用Spring 的 **TaskExecutor**(任务执行器)实现的。约定每一个块开启一个线程独立执行。

![image-20240205131314269](https://s2.loli.net/2024/02/05/L5e89BrWUNQvDnS.png)



**需求：分5个块处理user-thread.txt文件**

user-thread.txt：

```tex
1#xiaodong#18
2#xiaojia#16
3#xiaoxue#20
4#xiaoming#19
5#xiaogang#15
6#zhangsan#14
7#lisi#13
8#wangwu#12
9#zhaoliu#11
10#tianqi#10
```



User:

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



```java
@SpringBootApplication
@EnableBatchProcessing
public class ThreadStepJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;

    @Bean
    public FlatFileItemReader<User> userItemReader(){

        System.out.println(Thread.currentThread());

        FlatFileItemReader<User> reader = new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .saveState(false) //防止状态被覆盖
                .resource(new ClassPathResource("user-thread.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();

        return reader;
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step step(){
        return stepBuilderFactory.get("step1")
                .<User, User>chunk(2)
                .reader(userItemReader())
                .writer(itemWriter())
                .taskExecutor(new SimpleAsyncTaskExecutor())
                .build();

    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get("thread-step-job")
                .start(step())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ThreadStepJob.class, args);
    }
}
```

结果：

![image-20240205143121380](https://s2.loli.net/2024/02/05/cNsg7hb21jFo4GS.png)

**userItemReader()** 加上**saveState(false)** Spring Batch 提供大部分的ItemReader是有状态的，作业重启基本通过状态来确定作业停止位置，而在多线程环境中，如果对象维护状态被多个线程访问，可能存在线程间状态相互覆盖问题。所以设置为false表示关闭状态，但这也意味着作业不能重启了。

**step()** 方法加上**.taskExecutor(new SimpleAsyncTaskExecutor())** 为作业步骤添加了多线程处理能力，以块为单位，一个块一个线程，观察上面的结果，很明显能看出**输出的顺序是乱序的**。改变 job 的名字再执行，会发现输出数据每次都不一样。





### 并行步骤

并行步骤，指的是某2个或者多个步骤同时执行。

![image-20240205143318027](https://s2.loli.net/2024/02/05/8CzSj6LFl1rxUiM.png)

图中，流程从步骤1执行，然后执行步骤2， 步骤3，当步骤2/3执行结束之后，在执行步骤4.

**当读取2个或者多个互不关联的文件时，可以多个文件同时读取，这个就是并行步骤。**

**需求：现有user-parallel.txt, user-parallel.json  2个文件将它们中数据读入内存**

user-parallel.txt, user-parallel.json 

```tex
6#xiaotian#18
7#xiaocheng#16
8#xiaoli#20
9#xiaobai#19
10#xiaona#15
```

```json
[
  {"id":1, "name":"xiaodong", "age":18},
  {"id":2, "name":"xiaojia", "age":17},
  {"id":3, "name":"xiaoxue", "age":16},
  {"id":4, "name":"xiaoming", "age":15},
  {"id":5, "name":"xiaogang", "age":14}
]
```



User:

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```

实现：

```java
@SpringBootApplication
@EnableBatchProcessing
public class ParallelStepJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;


    @Bean
    public JsonItemReader<User> jsonItemReader(){
        ObjectMapper objectMapper = new ObjectMapper();
        JacksonJsonObjectReader<User> jsonObjectReader = new JacksonJsonObjectReader<>(User.class);
        jsonObjectReader.setMapper(objectMapper);

        return new JsonItemReaderBuilder<User>()
                .name("userJsonItemReader")
                .jsonObjectReader(jsonObjectReader)
                .resource(new ClassPathResource("user-parallel.json"))
                .build();
    }

    @Bean
    public FlatFileItemReader<User> flatItemReader(){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(new ClassPathResource("user-parallel.txt"))
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }
    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }

    @Bean
    public Step jsonStep(){
        return stepBuilderFactory.get("jsonStep")
                .<User, User>chunk(2)
                .reader(jsonItemReader())
                .writer(itemWriter())
                .build();
    }

    @Bean
    public Step flatStep(){
        return stepBuilderFactory.get("step2")
                .<User, User>chunk(2)
                .reader(flatItemReader())
                .writer(itemWriter())
                .build();
    }

    @Bean
    public Job parallelJob(){

        //线程1-读user-parallel.txt
        Flow parallelFlow1 = new FlowBuilder<Flow>("parallelFlow1")
                .start(flatStep())
                .build();

        //线程2-读user-parallel.json
        Flow parallelFlow2 = new FlowBuilder<Flow>("parallelFlow2")
                .start(jsonStep())
                .split(new SimpleAsyncTaskExecutor())
                .add(parallelFlow1)
                .build();


        return jobBuilderFactory.get("parallel-step-job")
                .start(parallelFlow2)
                .end()
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(ParallelStepJob.class, args);
    }
}
```

结果：

![image-20240205144107476](https://s2.loli.net/2024/02/05/fyrDlLoH1a29vCc.png)

jsonItemReader()  flatItemReader()  定义2个读入操作，分别读json格式跟普通文本格式

parallelJob()  配置job，需要指定并行的flow步骤，先是parallelFlow1然后是parallelFlow2 ， 2个步骤间使用**.split(new SimpleAsyncTaskExecutor())** 隔开，表示线程池开启2个线程，分别处理parallelFlow1， parallelFlow2  2个步骤。





### 分区步骤

在SpringBatch 分区步骤讲的是给执行步骤区分上下级。

上级： 主步骤(Master Step)  

下级： 从步骤--工作步骤(Work Step)

主步骤是领导，不用干活，负责管理从步骤，从步骤是下属，必须干活。

一个主步骤下辖管理多个从步骤。

注意： 从步骤，不管多小，它也一个完整的Spring Batch 步骤，负责各自的读入、处理、写入等。

大致结构图：


![image-20240205144351966](https://s2.loli.net/2024/02/05/NzycvS1rxlUjV4A.png)

分区步骤一般用于海量数据的处理上，其采用是分治思想。主步骤将大的数据划分多个小的数据集，然后开启多个从步骤，要求每个从步骤负责一个数据集。当所有从步骤处理结束，整作业流程才算结束。



**分区器（Partitioner）**

主步骤核心组件，负责数据分区，将完整的数据拆解成多个数据集，然后指派给从步骤，让其执行。

拆分规则由Partitioner分区器接口定制，默认的实现类：**MultiResourcePartitioner**

```java
public interface Partitioner {
	Map<String, ExecutionContext> partition(int gridSize);
}
```

Partitioner 接口只有唯一的方法：partition  参数gridSize表示要**分区的大小**，可以理解为要**开启多个worker步骤**，返回值是一个Map， 其中**key：worker步骤名称**， **value：worker步骤启动需要参数值**，一般包含**分区元数据，比如起始位置，数据量**等。



**分区处理器（PartitionHandler）**

主步骤核心组件，统一管理work 步骤， 并给work步骤指派任务。

管理规则由PartitionHandler 接口定义，默认的实现类：**TaskExecutorPartitionHandler** 

**需求：将下面几个文件将数据读入内存**

数据准备：

user1-10.txt

```txt
1#xiaodong#18
2#xiaodong#18
3#xiaodong#18
4#xiaodong#18
5#xiaodong#18
6#xiaodong#18
7#xiaodong#18
8#xiaodong#18
9#xiaodong#18
10#xiaodong#18
```

user11-20.txt

```txt
11#xiaodong#18
12#xiaodong#18
13#xiaodong#18
14#xiaodong#18
15#xiaodong#18
16#xiaodong#18
17#xiaodong#18
18#xiaodong#18
19#xiaodong#18
20#xiaodong#18
```

user21-30.txt

```
21#xiaodong#18
22#xiaodong#18
23#xiaodong#18
24#xiaodong#18
25#xiaodong#18
26#xiaodong#18
27#xiaodong#18
28#xiaodong#18
29#xiaodong#18
30#xiaodong#18
```

user31-40.txt

```txt
31#xiaodong#18
32#xiaodong#18
33#xiaodong#18
34#xiaodong#18
35#xiaodong#18
36#xiaodong#18
37#xiaodong#18
38#xiaodong#18
39#xiaodong#18
40#xiaodong#18
```

user41-50.txt

```txt
41#xiaodong#18
42#xiaodong#18
43#xiaodong#18
44#xiaodong#18
45#xiaodong#18
46#xiaodong#18
47#xiaodong#18
48#xiaodong#18
49#xiaodong#18
50#xiaodong#18
```

操作分析：

![image-20240205145005953](https://s2.loli.net/2024/02/05/ApnP2wsmBaJuIl6.png)



User:

```java
@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}
```



配置分区逻辑：

也就是配置分区器

```java
public class UserPartitioner  implements Partitioner {
    @Override
    public Map<String, ExecutionContext> partition(int gridSize) {
        Map<String, ExecutionContext> result = new HashMap<>(gridSize);

        int range = 10; //文件间隔
        int start = 1; //开始位置
        int end = 10;  //结束位置
        String text = "user%s-%s.txt";

        for (int i = 0; i < gridSize; i++) {
            ExecutionContext value = new ExecutionContext();
            Resource resource = new ClassPathResource(String.format(text, start, end));
            try {
                value.putString("file", resource.getURL().toExternalForm());
            } catch (IOException e) {
                e.printStackTrace();
            }
            start += range;
            end += range;

            result.put("user_partition_" + i, value);
        }
        return result;
    }
}
```



完整：

```java
@SpringBootApplication
@EnableBatchProcessing
public class PartStepJob {
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    @Autowired
    private StepBuilderFactory stepBuilderFactory;



    //每个分区文件读取
    @Bean
    @StepScope
    public FlatFileItemReader<User> flatItemReader(@Value("#{stepExecutionContext['file']}") Resource resource){
        return new FlatFileItemReaderBuilder<User>()
                .name("userItemReader")
                .resource(resource)
                .delimited().delimiter("#")
                .names("id", "name", "age")
                .targetType(User.class)
                .build();
    }

    @Bean
    public ItemWriter<User> itemWriter(){
        return new ItemWriter<User>() {
            @Override
            public void write(List<? extends User> items) throws Exception {
                items.forEach(System.err::println);
            }
        };
    }


    //文件分区器-设置分区规则
    @Bean
    public UserPartitioner userPartitioner(){
        return new UserPartitioner();
    }

    //文件分区处理器-处理分区
    @Bean
    public PartitionHandler userPartitionHandler() {
        TaskExecutorPartitionHandler handler = new TaskExecutorPartitionHandler();
        handler.setGridSize(5);
        handler.setTaskExecutor(new SimpleAsyncTaskExecutor());
        handler.setStep(workStep());
        try {
            handler.afterPropertiesSet();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return handler;
    }
    
    //每个从分区操作步骤
    @Bean
    public Step workStep() {
        return stepBuilderFactory.get("workStep")
                .<User, User>chunk(10)
                .reader(flatItemReader(null))
                .writer(itemWriter())
                .build();
    }

    //主分区操作步骤
    @Bean
    public Step masterStep() {
        return stepBuilderFactory.get("masterStep")
                .partitioner(workStep().getName(),userPartitioner())
                .partitionHandler(userPartitionHandler())
                .build();
    }


    @Bean
    public Job partJob(){
        return jobBuilderFactory.get("part-step-job")
                .start(masterStep())
                .build();
    }
    public static void main(String[] args) {
        SpringApplication.run(PartStepJob.class, args);
    }
}
```

结果：

![image-20240205150111021](https://s2.loli.net/2024/02/05/7sznTOPWcdYmGH5.png)

核心：

1>文件分区器：userPartitioner()， 分别加载5个文件进入到程序

2>文件分区处理器：userPartitionHandler() ，指定要分几个区，由谁来处理

3>分区从步骤：workStep() 指定读逻辑与写逻辑

4>分区文件读取：flatItemReader()，需要传入Resource对象，这个对象在userPartitioner()已经标记为file

5>分区主步骤：masterStep() ，指定分区名称与分区器，指定分区处理器





