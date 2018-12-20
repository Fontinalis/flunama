package com.example.flunamaexample;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.mapbox.mapboxsdk.Mapbox;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Mapbox.getInstance(this, "pk.eyJ1IjoiZm9udGluYWxpcyIsImEiOiJjamo3N3QxZzkwcGZkM3Jzd3R0OHd3eG9jIn0.MDmSPZyfbQ7NP0toOzSnyg");
    GeneratedPluginRegistrant.registerWith(this);
  }
}
