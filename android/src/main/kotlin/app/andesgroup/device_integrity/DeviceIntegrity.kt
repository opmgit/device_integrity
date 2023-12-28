package app.andesgroup.device_integrity

import android.content.Context
import com.google.android.gms.tasks.Task
import com.google.android.play.core.integrity.IntegrityManagerFactory
import com.google.android.play.core.integrity.StandardIntegrityManager

class DeviceIntegrity(context: Context, cloudProjectNumber: Long) {

    // Create an instance of a manager.
    private val integrityManager: StandardIntegrityManager = IntegrityManagerFactory.createStandard(context)

    // Request the integrity token by providing a nonce.
    val integrityTokenResponse: Task<StandardIntegrityManager.StandardIntegrityTokenProvider> = integrityManager.prepareIntegrityToken(
            StandardIntegrityManager.PrepareIntegrityTokenRequest.builder()
                    .setCloudProjectNumber(cloudProjectNumber)
                    .build())
}