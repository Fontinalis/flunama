package io.barna.flunama;

import android.content.Context;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import com.mapbox.mapboxsdk.Mapbox;
import com.mapbox.mapboxsdk.annotations.Polyline;
import com.mapbox.mapboxsdk.annotations.PolylineOptions;
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

    static Object LatLngToObject(LatLng latLng) {
        List<Object> out = new ArrayList<Object>();
        out.add(latLng.getLatitude());
        out.add(latLng.getLongitude());
        return out;
    };

    static PolylineOptions toPolylineOptions(Object o) {
        if (o == null) {
            return null;
        }
        final List<?> data = (List<?>) o;
        PolylineOptions po = new PolylineOptions();
        for (int i = 0; i < data.size(); i++) {
            po.add(toLatLng(data.get(i)));
        }
        return po;
    }

    static Object PolylineToObject(Polyline p) {
        Map<String, List<Object>> out = new HashMap<>();
        List<Object> coords = new ArrayList<Object>();
        for (int i = 0; i < p.getPoints().size(); i++) {
            coords.add(LatLngToObject(p.getPoints().get(i)));
        };
        out.put("coordinates", coords);
        return out;
    }
}