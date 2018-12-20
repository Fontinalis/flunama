package io.barna.flunama;

import android.content.Context;
import io.flutter.plugin.common.PluginRegistry;
import java.util.concurrent.atomic.AtomicInteger;
import com.mapbox.mapboxsdk.maps.MapboxMapOptions;

class MapBoxBuilder {
    public final MapboxMapOptions options = new MapboxMapOptions();

    MapBoxController build(
        int id, 
        Context context, 
        AtomicInteger state, 
        PluginRegistry.Registrar registrar) {
        final MapBoxController controller = new MapBoxController(id, context, state, registrar, options);
        controller.init();
        return controller;
    }
}