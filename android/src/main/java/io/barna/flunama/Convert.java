package io.barna.flunama;

import android.content.Context;

import java.util.Map;
import java.util.List;

import com.mapbox.mapboxsdk.Mapbox;
import com.mapbox.mapboxsdk.camera.CameraPosition;
import com.mapbox.mapboxsdk.geometry.LatLng;

class Convert {
    static void interpretMapboxMapOptions(Context context, Object o, MapBoxBuilder builder) {
        final Map<?, ?> data = toMap(o);

        final Object styleURL = data.get("styleURL");
        if (styleURL != null) {
            builder.options.styleUrl((String) styleURL);
        }

        final Object centerCoordinate = data.get("centerCoordinate");
        if (centerCoordinate != null) {
            builder.options.camera(new CameraPosition.Builder().target(toLatLng(centerCoordinate)).build());
        }

        final Object zoomLevel = data.get("zoomLevel");
        if (zoomLevel != null) {
            builder.options.camera(new CameraPosition.Builder().zoom(((Number) zoomLevel).doubleValue()).build());
        }

        final Object accessToken = data.get("accessToken");
        if (accessToken != null) {
            Mapbox.getInstance(context, (String) accessToken);
        }
    }

    static Map<?, ?> toMap(Object o) {
        return (Map<?, ?>) o;
    }

    static LatLng toLatLng(Object o) {
        if (o == null) {
            return null;
        }
        final List<?> data = (List<?>) o;
        return new LatLng(((Number) data.get(0)).doubleValue(), ((Number) data.get(1)).doubleValue());
    }
}