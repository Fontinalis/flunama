package io.barna.flunama;

import static io.flutter.plugin.common.PluginRegistry.Registrar;

import android.content.Context;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;


public class MapBoxFactory extends PlatformViewFactory {

    private final AtomicInteger mActivityState;
    private final Registrar mPluginRegistrar;
  
    public MapBoxFactory(AtomicInteger state, Registrar registrar) {
        super(StandardMessageCodec.INSTANCE);
        mActivityState = state;
        mPluginRegistrar = registrar;
    }
  
    @Override
    public PlatformView create(Context context, int id, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;
        final MapBoxBuilder builder = new MapBoxBuilder();

        Convert.interpretMapboxMapOptions(context, params.get("options"), builder);

        return builder.build(id, context, mActivityState, mPluginRegistrar);
    }
}