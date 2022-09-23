package com.example.frame.common.config;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.example.frame.common.utils.DateTimeUI;
import com.example.frame.common.utils.StringUtil;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;


/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Component
public class MyMetaObjectHandler implements MetaObjectHandler {

    private static final String CREATE_TIME = "createTime";
    private static final String SYNC_TIME = "syncTime";
    private static final String UPDATE_TIME = "updateTime";

    /**
     * @param metaObject
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        operationFill(metaObject, CREATE_TIME);
    }


    /**
     * @param metaObject
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        operationFill(metaObject, UPDATE_TIME);
    }


    private void operationFill(MetaObject metaObject, String updateTime) {
        if (metaObject.hasGetter(updateTime) && StringUtil.isNullorEmpty(this.getFieldValByName(updateTime, metaObject))) {
            this.setFieldValByName(updateTime, DateTimeUI.getCurrentDateTime(), metaObject);
        }

        if (metaObject.hasGetter(SYNC_TIME) && StringUtil.isNullorEmpty(this.getFieldValByName(SYNC_TIME, metaObject))) {
            this.setFieldValByName(SYNC_TIME, DateTimeUI.getCurrentDateTimeLong(), metaObject);
        }
    }
}