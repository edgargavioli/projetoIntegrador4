package com.inventario.imobilizado.utils;

import java.util.Date;
import java.util.concurrent.TimeUnit;

public class DateUtils {
    public static long daysBetween(Date start, Date end) {
        long diffInMillies = Math.abs(end.getTime() - start.getTime());
        return TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
    }
}
