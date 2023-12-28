#include "include/device_integrity/device_integrity_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "device_integrity_plugin.h"

void DeviceIntegrityPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  device_integrity::DeviceIntegrityPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
