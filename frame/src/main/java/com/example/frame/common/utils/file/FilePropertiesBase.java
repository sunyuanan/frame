package com.example.frame.common.utils.file;

import com.example.frame.common.utils.StringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @author
 */

@Component
public class FilePropertiesBase {
    protected static final String TAG_FILE_ROOT_WINDOW = "file.root.window";
    protected static final String TAG_FILE_ROOT_LINUX = "file.root.linux";
    private static final String TAG_TEMP = "dir.temp";
    public static final String TEMP_FINAL_DIR = "temp";


    private static String environment;

    @Value("${spring.profiles.active}")
    public void setEnvironment(String environment) {
        FilePropertiesBase.environment = environment;
    }


    protected FilePropertiesBase() {
    }

    public static String getValue(String propertyName) {
        return PropertiesUtil.getString("file", propertyName);
    }

    public static String getRootPath() {
        String path = getValue(TAG_FILE_ROOT_LINUX);

        if ("dev".equals(environment)) {
            path = getValue(TAG_FILE_ROOT_WINDOW);
        }

        return path.toLowerCase().startsWith("file://") ? path.replace("file://", "") : getBasePath();
    }

    public static String getRootPath(String fileName) {
        return getRootPath().concat(fileName);
    }

    public static String getBasePath() {
        String path = "";

        try {
            path = FilePropertiesBase.class.getResource("/").getPath();
            path = path.substring(0, path.indexOf("WEB-INF"));
            path = path.replaceAll("%20", " ");
            if (path.startsWith("/")) {
                path = path.substring(1);
            }
        } catch (Exception var2) {
            System.out.println(var2.getMessage());
        }

        return path;
    }

    public static String getBasePath(String fileName) {
        return getBasePath().concat(fileName);
    }

    public static String WEB_SERVICE(String webservice) {
        return getValue("webservice.").concat(webservice);
    }

    public static String DIR_TEMP() {
        String path = getValue(TAG_TEMP);
        if (StringUtil.isNullorEmpty(path)) {
            path = getRootPath();
        } else if (path.toLowerCase().startsWith("file://")) {
            path = path.replace("file://", "");
        } else {
            path = getRootPath().concat(path);
        }

        return path.concat("temp/");
    }

    public static String DIR_TEMP(String fileName) {
        String path = getValue(TAG_TEMP);
        if (StringUtil.isNullorEmpty(path)) {
            path = getRootPath();
        } else if (path.toLowerCase().startsWith("file://")) {
            path = path.replace("file://", "");
        } else {
            path = getRootPath().concat(path);
        }

        return path.concat(fileName);
    }

    public static String clearRootPath(String filePath) {
        return filePath.replace(getRootPath(""), "");
    }
}
