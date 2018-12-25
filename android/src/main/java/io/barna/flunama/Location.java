package io.barna.flunama;

import java.util.Map;
import java.util.List;

class Location {
    static double latitude;
    static double longitude;

    public void parse(Object o) {
        final List<?> data = (List<?>) o;
        this.latitude = ((Number) data.get(0)).doubleValue();
        this.latitude = ((Number) data.get(1)).doubleValue();
    }

    static Map<?, ?> toMap(Object o) {
        return (Map<?, ?>) o;
    }
}