package org.example;

import java.time.LocalDateTime;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");

        System.out.println(LocalDateTime.now().withHour(8).withMinute(0).withSecond(0).toString());
        System.out.println(LocalDateTime.now().withHour(18).withMinute(0).withSecond(0).toString());
        System.out.println(LocalDateTime.now());
    }
}