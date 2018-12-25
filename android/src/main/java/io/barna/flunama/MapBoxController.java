package io.barna.flunama;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;
import android.view.View;

import com.mapbox.mapboxsdk.geometry.LatLng;
import com.mapbox.mapboxsdk.maps.MapView;
import com.mapbox.mapboxsdk.maps.MapboxMap;
import com.mapbox.mapboxsdk.maps.MapboxMapOptions;
import com.mapbox.mapboxsdk.maps.OnMapReadyCallback;
import com.mapbox.mapboxsdk.camera.CameraPosition;

import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

final class MapBoxController
    implements Application.ActivityLifecycleCallbacks,
        MethodChannel.MethodCallHandler,
        PlatformView,
        OnMapReadyCallback {
    private static final String TAG = "MapBoxController";
    private final int id;
    private final AtomicInteger activityState;
    private final MethodChannel methodChannel;
    private final PluginRegistry.Registrar registrar;
    private MethodChannel.Result mapReadyResult;
    private final int registrarActivityHashCode;
    private final Context context;
    private MapView mapView;
    private boolean disposed = false;
    private MapboxMap mapboxMap;

    MapBoxController(
        int id,
        Context context,
        AtomicInteger activityState,
        PluginRegistry.Registrar registrar,
        MapboxMapOptions options) {
        this.id = id;
        this.context = context;
        this.mapView = new MapView(context, options);
        this.activityState = activityState;
        this.registrar = registrar;
        methodChannel =
            new MethodChannel(registrar.messenger(), "barna.io/mapbox_" + id);
        methodChannel.setMethodCallHandler(this);
        this.registrarActivityHashCode = registrar.activity().hashCode();
    }

    @Override
    public View getView() {
        return mapView;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "setCenterCoordinate:animated":
            {
                this.mapboxMap.setCameraPosition(new CameraPosition.Builder()
                        .target(Convert.toLatLng(call.argument("location")))
                        .build());
                result.success("success");
            }
            case "styleURL:set":
            {
                if (call.argument("styleURL") == null) {
                    result.error("INVALID ARGUMENT", "styleURL is null", call.argument("styleURL"));
                }
                this.mapView.setStyleUrl((String) call.argument("styleURL"));
                result.success("success");
            }
            case "styleURL:get":
            {
                result.success(this.mapboxMap.getStyleUrl());
            }
            default:
                result.notImplemented();
        }
    }


    @Override
    public void dispose() {
        if (disposed) {
            return;
        }
        disposed = true;
        mapView.onDestroy();
        registrar.activity().getApplication().unregisterActivityLifecycleCallbacks(this);
    }

    void init() {
        registrar.activity().getApplication().registerActivityLifecycleCallbacks(this);
        mapView.getMapAsync(this);
    }

    @Override
    public void onMapReady(MapboxMap mapboxMap) {
      this.mapboxMap = mapboxMap;
    }

    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onCreate(savedInstanceState);
    }

    @Override
    public void onActivityStarted(Activity activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onStart();
    }

    @Override
    public void onActivityResumed(Activity activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onResume();
    }

    @Override
    public void onActivityPaused(Activity activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onPause();
    }

    @Override
    public void onActivityStopped(Activity activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onStop();
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onSaveInstanceState(outState);
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (disposed || activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        mapView.onDestroy();
    }

}
