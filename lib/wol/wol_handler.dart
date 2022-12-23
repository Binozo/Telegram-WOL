import 'package:wake_on_lan/wake_on_lan.dart';

class WOLHandler {
  /// Validates an IPv4 Address. Returns [IPv4Address] if successful, otherwise [null]
  static IPv4Address? validateIPv4(String address) {
    if(IPv4Address.validate(address)) {
      return IPv4Address(address);
    }
    return null;
  }

  /// Validates a MAC Address. Returns [MACAddress] if successful, otherwise [null]
  static MACAddress? validateMac(String address) {
    if(MACAddress.validate(address)) {
      return MACAddress(address);
    }
    return null;
  }

  static Future<void> wake(IPv4Address iPv4Address, MACAddress macAddress) async {
    return WakeOnLAN(iPv4Address, macAddress).wake();
  }
}