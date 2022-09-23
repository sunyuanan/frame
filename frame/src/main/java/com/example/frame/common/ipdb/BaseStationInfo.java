package com.example.frame.common.ipdb;

/**
 * @author sya
 */
public class BaseStationInfo {

    private String[] data;

    public BaseStationInfo(String[] data) {
        this.data = data;
    }

    public String getCountryName() {
        return this.data[0];
    }

    public String getRegionName() {
        return this.data[1];
    }

    public String getCityName() {
        return this.data[2];
    }

    public String getOwnerDomain() {
        return this.data[3];
    }

    public String getIspDomain() {
        return this.data[4];
    }

    public String getBaseStation() {
        return this.data[5];
    }


}
