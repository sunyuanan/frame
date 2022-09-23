package com.example.frame;


import com.alibaba.fastjson.JSONObject;
import com.google.common.util.concurrent.ThreadFactoryBuilder;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.*;

/**
 * @author
 */
public class Test {
    private static int num = 100;

    public static void main(String[] args) {




    }


    private static void addThread() {

        ThreadFactory namedThreadFactory = new ThreadFactoryBuilder().setNameFormat("demo-pool-%d").build();
        ExecutorService singleThreadPool = new ThreadPoolExecutor(1, 1,
                0L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<Runnable>(1024), namedThreadFactory, new ThreadPoolExecutor.AbortPolicy());

        singleThreadPool.execute(() -> {
            System.out.println(Thread.currentThread().getName() + "消费");
            num--;
            System.out.println(Thread.currentThread().getName() + "num剩下" + num);
        });
        singleThreadPool.shutdown();

    }


    private static String aaa() {
        CompletableFuture.allOf(
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(5000);
                        System.out.println("5秒的执行完");
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }),
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(3000);
                        System.out.println("3秒的执行完");

                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }),
                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(8000);
                        System.out.println("8秒的执行完");
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                })

        ).join();
        return "ok";
    }


}





