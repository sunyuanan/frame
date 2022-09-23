package com.example.frame.common.utils;

import java.util.Random;
import java.util.UUID;

public class RandomGUID {
    private final long twepoch = 1288834974657L;
    private final long workerIdBits = 5L;
    private final long datacenterIdBits = 5L;
    private final long maxWorkerId = 31L;
    private final long maxDatacenterId = 31L;
    private final long sequenceBits = 12L;
    private final long workerIdShift = 12L;
    private final long datacenterIdShift = 17L;
    private final long timestampLeftShift = 22L;
    private final long sequenceMask = 4095L;
    private long workerId = 0L;
    private long datacenterId = 0L;
    private long sequence = 0L;
    private long lastTimestamp = -1L;
    public static RandomGUID RandomNUMID;
    public static final String RANDOM_CODES = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";

    public static void initWorkId(long workerId, long datacenterId) {
        RandomNUMID = new RandomGUID(workerId, datacenterId);
    }

    public RandomGUID(long workerId, long datacenterId) {
        if (workerId <= 31L && workerId >= 0L) {
            if (datacenterId <= 31L && datacenterId >= 0L) {
                this.workerId = workerId;
                this.datacenterId = datacenterId;
            } else {
                throw new IllegalArgumentException(
                        String.format("datacenter Id can't be greater than %d or less than 0", 31L));
            }
        } else {
            throw new IllegalArgumentException(
                    String.format("worker Id can't be greater than %d or less than 0", 31L));
        }
    }

    public synchronized String nextId() {
        long timestamp = this.timeGen();
        if (timestamp < this.lastTimestamp) {
            throw new RuntimeException(
                    String.format(
                            "Clock moved backwards.  Refusing to generate id for %d milliseconds",
                            this.lastTimestamp - timestamp));
        } else {
            if (this.lastTimestamp == timestamp) {
                this.sequence = this.sequence + 1L & 4095L;
                if (this.sequence == 0L) {
                    timestamp = this.tilNextMillis(this.lastTimestamp);
                }
            } else {
                this.sequence = 0L;
            }

            this.lastTimestamp = timestamp;
            return (timestamp - 1288834974657L << 22
                    | this.datacenterId << 17
                    | this.workerId << 12
                    | this.sequence)
                    + "";
        }
    }

    protected long tilNextMillis(long lastTimestamp) {
        long timestamp;
        for (timestamp = this.timeGen(); timestamp <= lastTimestamp; timestamp = this.timeGen()) {
            ;
        }

        return timestamp;
    }

    protected long timeGen() {
        return System.currentTimeMillis();
    }

    public static String generateRandom(int num, boolean onlyNum) {
        StringBuilder verifyCode = new StringBuilder(num);
        Random rand = new Random(System.currentTimeMillis());
        int rlength = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ".length();
        int i;
        if (onlyNum) {
            for (i = 0; i < num; ++i) {
                verifyCode.append((char) ((int) (Math.random() * 10.0D + 48.0D)));
            }
        } else {
            for (i = 0; i < num; ++i) {
                verifyCode.append("23456789ABCDEFGHJKLMNPQRSTUVWXYZ".charAt(rand.nextInt(rlength - 1)));
            }
        }

        System.out.println(verifyCode.toString());
        return verifyCode.toString();
    }

    public static synchronized String getDateUUID() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString().replaceAll("-", "");
    }

    public static synchronized String getFileUUID() {
        UUID uuid = UUID.randomUUID();
        return DateTimeUI.getCurrentDateTimeUUID() + "-" + uuid.toString().replaceAll("-", "");
    }

    public static void main(String[] args) {
        initWorkId(0L, 0L);
        System.out.println(RandomNUMID.nextId());

        for (int i = 0; i < 1000; ++i) {
            System.out.println(RandomNUMID.nextId());
        }
    }
}
