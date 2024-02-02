package com.ldd.itemreader_flat_mapper;

import com.ldd.itemreader_flat_mapper.pojo.User2;
import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.validation.BindException;

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
