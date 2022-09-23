package com.example.frame.common.ipdb;

import com.example.frame.common.utils.file.FilePropertiesBase;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * @author
 */
public class City {

    /**
     * @var Reader
     */
    private Reader reader;

    public City() throws IOException, InvalidDatabaseException {
        this.reader = new Reader(FilePropertiesBase.getRootPath() + "ipipfree.ipdb");
    }

    public City(InputStream in) throws IOException, InvalidDatabaseException {
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
        String[] fields = this.reader.getSupportFields();
        Map<String, String> m = new HashMap<String, String>();
        for (int i = 0, l = data.length; i < l; i++) {
            m.put(fields[i], data[i]);
        }

        return m;
    }

    public CityInfo findInfo(String addr, String language) throws IPFormatException, InvalidDatabaseException {

        Map<String, String> data = this.findMap(addr, language);
        if (data == null) {
            return null;
        }

        return new CityInfo(data);
    }

    public CityInfo findCity(String addr, String language) throws IPFormatException, InvalidDatabaseException {

        Map<String, String> data = this.findMap(addr, language);
        if (data == null) {
            return null;
        }

        return new CityInfo(data);
    }

    public int buildTime() {
        return this.reader.getBuildUTCTime();
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
}