package com.example.frame.common.utils;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * @author
 */
public class StringUtil {
    public StringUtil() {
    }

    public static String nullToEmpty(String value) {
        return value != null && !"null".equals(value) && !"".equals(value.trim()) ? value : "";
    }

    public static String nullToEmpty(String value, String defValue) {
        return value != null && !"null".equals(value) && !"".equals(value.trim()) ? value : defValue;
    }

    public static Object nullToEmpty(Object value) {
        return isNullorEmpty(value) ? "" : value;
    }

    public static Object nullToEmpty(Object value, Object defValue) {
        return isNullorEmpty(value) ? defValue : value;
    }

    public static boolean isNullorEmpty(String value) {
        return value == null || "null".equals(value) || "".equals(value.trim());
    }

    public static boolean isNullorEmpty(Object value) {
        return value == null
                || "".equals(value.toString().trim())
                || "null".equals(value.toString().trim());
    }

    public static List<Integer> arrayToList(String str, String charReg) {
        if (!isNullorEmpty(str)) {
            String[] arrayStr = str.split(charReg);
            List<Integer> tempList = new ArrayList();
            String[] var4 = arrayStr;
            int var5 = arrayStr.length;

            for (int var6 = 0; var6 < var5; ++var6) {
                String tt = var4[var6];
                if (!isNullorEmpty(tt)) {
                    tempList.add(Integer.valueOf(tt));
                }
            }

            return tempList;
        } else {
            return null;
        }
    }

    public void getFileName(File f) {
        File[] files = f.listFiles();

        for (int i = 0; i < files.length; ++i) {
            boolean isHidden = files[i].isHidden();
            if (files[i].isDirectory() && !isHidden) {
                this.getFileName(files[i]);
            }
        }
    }

    private static final String COMPILE = "[0-9]*";

    public static boolean isNumeric(String str) {
        Pattern pattern = Pattern.compile(COMPILE);
        return pattern.matcher(str).matches();
    }

    public static String delLRChar(String str) {
        return isNullorEmpty(str) ? "" : str.substring(1, str.length() - 1);
    }

    public static String forSearchExchange(String srcName, String tag) {
        srcName = srcName.trim().replaceAll(";", "");
        String newName = "";

        for (int i = 0; i < srcName.length(); ++i) {
            newName = newName.concat(tag).concat(srcName.substring(i, i + 1));
        }

        newName = newName.concat(tag);
        return newName;
    }

    public static String addBR_String(String str) {
        if (str != null && !"".equals(str.trim())) {
            String temp = str.replaceAll("\r\n", "<br>");
            return temp;
        } else {
            return "";
        }
    }

    public static String addBR_Object(Object str) {
        if (str != null && !"".equals(((String) str).trim())) {
            String temp = ((String) str).replaceAll("\r\n", "<br>");
            return temp;
        } else {
            return "";
        }
    }

    public static boolean isLetter(char c) {
        int k = 128;
        return c / k == 0;
    }

    public static int length(String s) {
        if (s == null) {
            return 0;
        } else {
            char[] c = s.toCharArray();
            int len = 0;

            for (int i = 0; i < c.length; ++i) {
                ++len;
                if (!isLetter(c[i])) {
                    ++len;
                }
            }

            return len;
        }
    }

    public static String mySubstring(String origin, int len) {
        if (origin != null && !"".equals(origin) && len >= 1) {
            byte[] strByte = new byte[len];
            if (len > length(origin)) {
                return origin;
            } else {
                System.arraycopy(origin.getBytes(), 0, strByte, 0, len);
                int count = 0;

                for (int i = 0; i < len; ++i) {
                    int value = strByte[i];
                    if (value < 0) {
                        ++count;
                    }
                }

                if (count % 2 != 0) {
                    int var10000;
                    if (len == 1) {
                        ++len;
                        var10000 = len;
                    } else {
                        --len;
                        var10000 = len;
                    }

                    len = var10000;
                }

                return new String(strByte, 0, len);
            }
        } else {
            return "";
        }
    }

    public static String myPercent(int y, int z) {
        String baifenbi = "";
        double baiy = (double) y * 1.0D;
        double baiz = (double) z * 1.0D;
        double fen = baiy / baiz;
        DecimalFormat df1 = new DecimalFormat("##.00%");
        baifenbi = df1.format(fen);
        return baifenbi;
    }

    public static String getURLWEB(String url) {
        url = url.substring(7);
        if (url.lastIndexOf("/") != -1) {
            url = url.substring(url.indexOf("."), url.indexOf("/"));
        } else {
            url = url.substring(url.indexOf("."));
        }

        return url;
    }

    public static String StringFilter(String str) {
        if (isNullorEmpty(str)) {
            return "";
        } else {
            String regEx = "[`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";
            Pattern p = Pattern.compile(regEx);
            Matcher m = p.matcher(str);
            return m.replaceAll("").trim();
        }
    }
}
