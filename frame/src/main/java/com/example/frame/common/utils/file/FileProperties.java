package com.example.frame.common.utils.file;

public class FileProperties extends FilePropertiesBase {

    private static FileProperties inst = null;
    private final String webService = "webservice.";
    private final String ALERT_STARTTIME = "alert.startTime";
    private final String TIMER = "alert.timer";

    public String getWebService(String subName) {
        return getValue(webService.concat(subName));
    }

    public String getAlertStartTime() {
        return getValue(ALERT_STARTTIME);
    }

    public String getAlertTimer() {
        return getValue(TIMER);
    }
}
