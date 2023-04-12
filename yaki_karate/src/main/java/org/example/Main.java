package org.example;

import java.time.*;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello world!");

        System.out.println(OffsetDateTime.now().withHour(8).withMinute(0).withSecond(0).toString());
        System.out.println(OffsetDateTime.now().withHour(18).withMinute(0).withSecond(0).toString());
        System.out.println(LocalDateTime.now());
        System.out.println(LocalDate.now().toString() + "T18:00:00.950Z");
        System.out.println(OffsetDateTime.parse(LocalDate.now().toString() + "T08:00:00.950Z"));
        System.out.println(OffsetDateTime.now());
        System.out.println(java.time.OffsetDateTime.now(ZoneOffset.UTC).withHour(8).toString());
        System.out.println(Instant.now().toString());

    }
}