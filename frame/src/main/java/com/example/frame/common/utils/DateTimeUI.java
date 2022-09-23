package com.example.frame.common.utils;

import com.alibaba.druid.util.StringUtils;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author
 */
public class DateTimeUI {
    private static String defaultDateFormat = "yyyy-MM-dd";
    public static String defaultExcelDateFormat = "yyyy-MM-dd KK:mm";
    private static String yearFormat = "yyyy";
    private static String monthFormat = "MM";
    private static String dayDateFormat = "dd";
    private static String mmddDateFormat = "MM-dd";
    private static String displayDateFormat = "dd-MM-yyyy";
    private static String DD_MM_YYYY_PATTERN = "dd/MM/yyyy";
    private static String defaultDateTimeFormat = "yyyy-MM-dd HH:mm:ss";
    private static String defaultUUIDDateTimeFormat = "yyyyMMddHHmmss";
    private static String dateFormatStr =
            "^(0[1-9]|1[0-9]|2[0-9]|3[0-1])/?(0[1-9]|1[0-2])/?(19\\d\\d|2\\d\\d\\d)$";

    public DateTimeUI() {
    }

    public static void main(String[] args) {
        try {
            System.out.println(parse("2011.04.30", "yyyy.MM.dd"));
            System.out.println(parseToLong("2012-01-05"));
            System.out.println(format(new Date(Long.parseLong("1325692800000"))));
        } catch (ParseException var2) {
            var2.printStackTrace();
        }
    }

    public static String getDefDateFormat() {
        return defaultDateFormat;
    }

    public static String getToday() {
        Date today = new Date();
        return format(today);
    }

    public static String getCurrentDateTime() {
        return format(new Date(), defaultDateTimeFormat);
    }

    public static String getCurrentDateTimeUUID() {
        return format(new Date(), defaultUUIDDateTimeFormat);
    }

    public static String getCurrentDateTimeLong() {
        return String.valueOf((new Date()).getTime());
    }


    public static String getCurrentDateTimeSecondLong() {
        long time = (new Date()).getTime() / 1000;
        return String.valueOf(Integer.parseInt(String.valueOf(time)));
    }

    public static String getCurrentDate() {
        return format(new Date(), defaultDateFormat);
    }

    public static String getCurrentYear() {
        return format(new Date(), yearFormat);
    }

    public static String getCurrentMonth() {
        return format(new Date(), monthFormat);
    }

    public static String getCurrentDay() {
        return format(new Date(), dayDateFormat);
    }

    public static String getCurrentMMDD() {
        return format(new Date(), mmddDateFormat);
    }

    public static String getParsDate(Date date) {
        return format(date, defaultDateFormat);
    }

    public static String getTodayWithFormat(String format) {
        Date today = new Date();
        return format(today, format);
    }

    public static String format(Date date) {
        return date == null ? "" : format(date, getDefDateFormat());
    }

    public static String displayFormat(Date date) {
        return date == null ? "" : format(date, DD_MM_YYYY_PATTERN);
    }

    public static String formatMonthYear(Date date) {
        String originalDate = format(date, DD_MM_YYYY_PATTERN);
        String[] s = null;
        String formatDate = null;
        if (originalDate != null && !"".equals(originalDate)) {
            s = originalDate.split("/");
            formatDate = s[1] + "/" + s[2];
        }

        return formatDate;
    }

    public static String addYear(String ODate, int year) {
        String[] s = null;
        String formatDate = null;
        if (ODate != null && !"".equals(ODate)) {
            s = ODate.split("/");
            formatDate = s[0] + "/" + s[1] + "/" + (Integer.parseInt(s[2]) + year);
        }

        return formatDate;
    }

    public static String format(Date date, String format) {
        return date == null ? "" : (new SimpleDateFormat(format)).format(date);
    }

    public static Date parse(String strDate) throws ParseException {
        return StringUtils.isEmpty(strDate) ? null : parse(strDate, getDefDateFormat());
    }

    public static String parseToLong(String strDate) throws ParseException {
        return StringUtils.isEmpty(strDate)
                ? null
                : String.valueOf(parse(strDate, getDefDateFormat()).getTime());
    }

    public static Timestamp parseDb(String strDate) throws ParseException {
        if (StringUtils.isEmpty(strDate)) {
            return new Timestamp(0L);
        } else {
            Timestamp ts = new Timestamp(parse(strDate).getTime());
            return ts;
        }
    }

    public static Timestamp parseDb(String strDate, String Format) throws ParseException {
        if (StringUtils.isEmpty(strDate)) {
            return null;
        } else {
            Timestamp ts = new Timestamp(parse(strDate, Format).getTime());
            return ts;
        }
    }

    public static Timestamp parseYear(String year) throws ParseException {
        String strDate = year + "-01-01";
        Timestamp ts = parseDb(strDate);
        return ts;
    }

    public static String parseNextIncMonthYear(String effDate, String nextIncDate)
            throws ParseException {
        String[] s = null;
        if (effDate != null && !"".equals(effDate)) {
            s = effDate.split("/");
            if ("1".equals(nextIncDate) && Integer.parseInt(s[1]) == 12) {
                nextIncDate = "13";
            }

            String strDate = "01/" + nextIncDate + "/" + (Integer.parseInt(s[2]) + 1);
            return strDate;
        } else {
            return "";
        }
    }

    public static Timestamp parseMonthYear(String MY) throws ParseException {
        String[] s = null;
        if (MY != null && !"".equals(MY)) {
            s = MY.split("/");
            String strDate = "01/" + s[0] + "/" + s[1];
            Timestamp ts = parseDb(strDate, DD_MM_YYYY_PATTERN);
            return ts;
        } else {
            return new Timestamp(0L);
        }
    }

    public static Date parse(String strDate, String format) throws ParseException {
        return StringUtils.isEmpty(strDate) ? null : (new SimpleDateFormat(format)).parse(strDate);
    }

    public static Date addMonth(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(2, n);
        return cal.getTime();
    }

    public static Date addDay(Date date, int n) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(5, n);
        return cal.getTime();
    }

    public static String getLastDayOfMonth(String year, String month) {
        Calendar cal = Calendar.getInstance();
        cal.set(1, Integer.parseInt(year));
        cal.set(5, 1);
        cal.add(2, 1);
        cal.add(5, -1);
        return String.valueOf(cal.get(5));
    }

    public static Date getDate(String year, String month, String day) throws ParseException {
        String result =
                year
                        + "-"
                        + (month.length() == 1 ? "0" + month : month)
                        + "-"
                        + (day.length() == 1 ? "0" + day : day);
        return parse(result);
    }

    public static boolean validateDate(String dateStr) {
        Pattern pattern = Pattern.compile(dateFormatStr);
        Matcher matcher = pattern.matcher(dateStr);
        boolean matchFound = matcher.find();
        return matchFound;
    }

    public static int getAge(String birthDate) {
        int age = 0;
        if (StringUtils.isEmpty(birthDate)) {
            return 0;
        } else {
            try {
                Date dt = parse(birthDate, DD_MM_YYYY_PATTERN);
                Calendar calBirth = Calendar.getInstance();
                calBirth.setTime(dt);
                Date now = new Date();
                Calendar calNow = Calendar.getInstance();
                calNow.setTime(now);
                int birthYear = calBirth.get(1);
                int nowYear = calNow.get(1);
                int birthMonth = calBirth.get(2);
                int nowMonth = calNow.get(2);
                int birthDay = calBirth.get(5);
                int nowDay = calNow.get(5);
                age = nowYear - birthYear;
                if (nowMonth < birthMonth) {
                    --age;
                } else if (nowMonth == birthMonth && nowDay < birthDay) {
                    --age;
                }
            } catch (ParseException var12) {
                var12.printStackTrace();
            }

            return age;
        }
    }

    public static int compare_date(String DATE1, String DATE2, String dateFormat) {
        SimpleDateFormat df = new SimpleDateFormat(dateFormat);

        try {
            Date dt1 = df.parse(DATE1);
            Date dt2 = df.parse(DATE2);
            if (dt1.getTime() > dt2.getTime()) {
                return 1;
            } else {
                return dt1.getTime() < dt2.getTime() ? -1 : 0;
            }
        } catch (Exception var6) {
            var6.printStackTrace();
            return 0;
        }
    }

    public static String getTimeMillis() {
        return System.currentTimeMillis() + "";
    }

    public static Date convertDate4JXL(Date jxlDate) throws ParseException {
        if (jxlDate == null) {
            return null;
        } else {
            TimeZone gmt = TimeZone.getTimeZone("GMT");
            DateFormat dateFormat = new SimpleDateFormat(defaultDateTimeFormat, Locale.getDefault());
            dateFormat.setTimeZone(gmt);
            String str = dateFormat.format(jxlDate);
            TimeZone local = TimeZone.getDefault();
            dateFormat.setTimeZone(local);
            return dateFormat.parse(str);
        }
    }

    public static String convertString4JXL(Date jxlDate) throws ParseException {
        if (jxlDate == null) {
            return null;
        } else {
            TimeZone gmt = TimeZone.getTimeZone("GMT");
            DateFormat dateFormat = new SimpleDateFormat(defaultDateTimeFormat, Locale.getDefault());
            dateFormat.setTimeZone(gmt);
            String str = dateFormat.format(jxlDate);
            TimeZone local = TimeZone.getDefault();
            dateFormat.setTimeZone(local);
            return str;
        }
    }

    public static int daysBetween(String now, String returnDate, String dataFormat)
            throws ParseException {
        if (StringUtil.isNullorEmpty(now) && StringUtil.isNullorEmpty(returnDate)) {
            return 0;
        } else {
            Calendar cNow = Calendar.getInstance();
            Calendar cReturnDate = Calendar.getInstance();
            cNow.setTime(parse(now, dataFormat));
            cReturnDate.setTime(parse(returnDate, dataFormat));
            setTimeToMidnight(cNow);
            setTimeToMidnight(cReturnDate);
            long todayMs = cNow.getTimeInMillis();
            long returnMs = cReturnDate.getTimeInMillis();
            long intervalMs = todayMs - returnMs;
            return millisecondsToDays(intervalMs);
        }
    }

    public static String getCurrentTimeLong() {
        Calendar cNow = Calendar.getInstance();
        long todayMs = cNow.getTimeInMillis();
        return String.valueOf(todayMs);
    }

    public static int daysBetween(Date now, Date returnDate) {
        Calendar cNow = Calendar.getInstance();
        Calendar cReturnDate = Calendar.getInstance();
        cNow.setTime(now);
        cReturnDate.setTime(returnDate);
        setTimeToMidnight(cNow);
        setTimeToMidnight(cReturnDate);
        long todayMs = cNow.getTimeInMillis();
        long returnMs = cReturnDate.getTimeInMillis();
        long intervalMs = todayMs - returnMs;
        return millisecondsToDays(intervalMs);
    }

    private static int millisecondsToDays(long intervalMs) {
        return (int) (intervalMs / 86400000L);
    }

    private static void setTimeToMidnight(Calendar calendar) {
        calendar.set(11, 0);
        calendar.set(12, 0);
        calendar.set(13, 0);
    }

    public static String getBeginTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar c = new GregorianCalendar();
        c.set(11, 0);
        c.set(12, 0);
        c.set(13, 0);
        return sdf.format(c.getTime());
    }

    public static String getEndTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar c = new GregorianCalendar();
        c.set(11, 23);
        c.set(12, 59);
        c.set(13, 59);
        return sdf.format(c.getTime());
    }

    public static String getFileNameDate(String filename) {
        filename = StringUtil.nullToEmpty(filename, "_ -");
        return filename.indexOf("_") != -1 && filename.indexOf("-") != -1
                ? StringUtil.nullToEmpty(
                filename.substring(filename.indexOf("_") + 1, filename.indexOf("-")))
                : "";
    }


    public static Calendar getNextDay() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(5, -1);
        return calendar;
    }

    public static List<Date> findDates(Date dateBegin, Date dateEnd) {
        List rangeDate = new ArrayList();
        rangeDate.add(dateBegin);
        Calendar calendarBegin = Calendar.getInstance();
        calendarBegin.setTime(dateBegin);
        Calendar calEnd = Calendar.getInstance();
        calEnd.setTime(dateEnd);

        while (dateEnd.after(calendarBegin.getTime())) {
            calendarBegin.add(5, 1);
            rangeDate.add(calendarBegin.getTime());
        }

        return rangeDate;
    }
}
