package com.example.frame.common.ipdb;

import com.alibaba.fastjson.annotation.JSONField;

public class AsnInfo {

    public int asn;

    @JSONField(name = "reg")
    public String registry;

    @JSONField(name = "cc")
    public String country;

    @JSONField(name = "net")
    public String netName;

    @JSONField(name = "org")
    public String orgName;
}
