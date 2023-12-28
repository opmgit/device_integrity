package app.andesgroup.device_integrity

import android.content.Context
import com.google.android.gms.tasks.Task
import com.google.android.play.core.integrity.StandardIntegrityManager
import com.google.android.play.core.integrity.StandardIntegrityManager.StandardIntegrityToken
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/** DeviceIntegrityPlugin */
class DeviceIntegrityPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_integrity")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getToken") {
            if (call.argument<Long>("cloud_project_number") != null && call.argument<Long>("hash") != null) {
                var deviceIntegrity = DeviceIntegrity(context, call.argument<Long>("cloud_project_number")!!)
                deviceIntegrity.integrityTokenResponse.addOnSuccessListener { response ->
                    val integrityTokenResponse: Task<StandardIntegrityToken> = response.request(
                            StandardIntegrityManager.StandardIntegrityTokenRequest.builder()
                                    .setRequestHash(call.argument<Long>("hash")!!)
                                    .build())
                    integrityTokenResponse
                            .addOnSuccessListener { response -> result.success(response.token()) }
                            .addOnFailureListener { exception -> result.error("1", exception.message, null) }
                }.addOnFailureListener { exception ->
                    result.error("2", exception.message, null)
                }
            } else {
                result.error("3", "Missing parameters")
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
