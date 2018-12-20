package io.barna.flunama;

import java.util.Map;

class Convert {
    static void interpretMapboxMapOptions(Object o, MapBoxBuilder builder) {
        final Map<?, ?> data = toMap(o);

        final Object styleURL = data.get("styleURL");
        if (styleURL != null) {
            builder.options.styleUrl((String) styleURL);
        }
    }

    static Map<?, ?> toMap(Object o) {
        return (Map<?, ?>) o;
    }
}