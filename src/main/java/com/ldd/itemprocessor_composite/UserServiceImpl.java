package com.ldd.itemprocessor_composite;


/**
 * @Author ldd
 * @Date 2024/2/5
 */
public class UserServiceImpl {
    public User toUpperCaseTest(User user){
        user.setName(user.getName().toUpperCase());
        return user;
    }
}