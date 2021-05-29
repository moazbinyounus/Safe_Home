package com.moazbinyounud.safe_home

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}



//package com.moazbinyounud.safe_home
//
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.app.FlutterApplication
//import io.flutter.plugin.common.PluginRegistry
//import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.GeneratedPluginRegistrant
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
//
//class MainActivity: FlutterActivity(), PluginRegistrantCallback {
//
//    override fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this);
//    }
//
//    override fun registerWith(registry: PluginRegistry?) {
//        io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
//    }
//}