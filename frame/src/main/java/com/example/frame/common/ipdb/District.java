package com.example.frame.common.ipdb;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class District {

    /**
     * @var Reader
     */
    private Reader reader;

    public District(String name) throws IOException, InvalidDatabaseException {
        this.reader = new Reader(name);
    }

    public District(InputStream in) throws IOException, InvalidDatabaseException {
        this.reader = new Reader(in);
    }

    public boolean reload(String name) {
        try {
            Reader r = new Reader(name);
            this.reader = r;
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    public String[] find(String addr, String language) throws IPFormatException, InvalidDatabaseException {
        return this.reader.find(addr, language);
    }

    public Map<String, String> findMap(String addr, String language) throws IPFormatException, InvalidDatabaseException {
        String[] data = this.reader.find(addr, language);
        if (data == null) {
            return null;
        }

        Map<String, String> m = new HashMap<String, String>();

        String[] fields = this.reader.getSupportFields();

        for (int i = 0, l = data.length; i < l; i++) {
            m.put(fields[i], data[i]);
        }

        return m;
    }

    public DistrictInfo findInfo(String addr, String language) throws IPFormatException, InvalidDatabaseException {

        String[] data = this.reader.find(addr, language);
        if (data == null) {
            return null;
        }

        return new DistrictInfo(data);
    }

    public boolean isIpv4() {
        return this.reader.isIpv4();
    }

    public boolean isIpv6() {
        return this.reader.isIpv6();
    }

    public String fields() {
        return Arrays.toString(this.reader.getSupportFields());
    }

    public String languages() {
        return this.reader.getSupportLanguages();
    }

    public int buildTime() {
        return this.reader.getBuildUTCTime();
    }
}