package com.ldd.itemprocessor_customize;

import org.springframework.batch.item.ItemProcessor;

/**
 * @Author ldd
 * @Date 2024/2/5
 */
public class CustomizeItemProcessor implements ItemProcessor<User, User> {
    @Override
    public User process(User item) throws Exception {
        //id为偶数的直接抛弃
        //返回null时候，读入的item会被抛弃，不会进入itemWriter
        return item.getId() % 2 != 0 ? item : null;
    }
}
