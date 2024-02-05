package com.ldd.itemprocessor_script;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.validation.constraints.NotBlank;

/**
 * @Author ldd
 * @Date 2024/2/5
 */

@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String name;
    private int age;
}