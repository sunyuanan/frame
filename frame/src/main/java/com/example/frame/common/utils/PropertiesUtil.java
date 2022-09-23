package com.example.frame.common.utils;

import java.io.UnsupportedEncodingException;
import java.text.MessageFormat;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class PropertiesUtil {
    private static String encoding = "UTF-8";

    public PropertiesUtil() {
    }

    public static String getString(String bundlePath, String key) {
        return getString(bundlePath, key, (Object[]) null);
    }

    public static String getString(String bundlePath, String key, Object[] args) {
        ResourceBundle bundle = getBundle(bundlePath);

        try {
            String msg = bundle.getString(key);
            if (msg == null) {
                return "";
            } else {
                msg = convertISO(msg);
                return MessageFormat.format(msg, args);
            }
        } catch (MissingResourceException var5) {
            return "";
        }
    }

    private static ResourceBundle getBundle(String bundlePath) {
        Locale locale = Locale.getDefault();
        ResourceBundle bundle = ResourceBundle.getBundle(bundlePath, locale, getClassLoader());
        return bundle;
    }

    protected static ClassLoader getClassLoader() {
        return PropertiesUtil.class.getClassLoader();
    }

    public static String convertISO(String msg) {
        if (msg != null) {
            try {
                return new String(msg.getBytes("iso-8859-1"), getEncoding());
            } catch (UnsupportedEncodingException var2) {
                var2.printStackTrace();
            }
        }

        return "";
    }

    public static String getEncoding() {
        return encoding;
    }

    public static void setEncoding(String encoding) {
        encoding = encoding;
    }
}
