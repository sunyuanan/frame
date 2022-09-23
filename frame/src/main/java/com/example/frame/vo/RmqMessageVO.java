package com.example.frame.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * @title：
 * @author: sya
 * @date: 2022年08月02日 9:59
 * @description:
 */
@Data
public class RmqMessageVO implements Serializable {

    private Object data;
    private String timestamp;

}


