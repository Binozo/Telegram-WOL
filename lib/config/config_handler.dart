import 'dart:convert';
import 'dart:io';
import 'package:telegram_wol/logger/logger.dart';
import 'package:telegram_wol/models/device.dart';

class ConfigHandler {
  final String _filePath = "devices.json";

  ConfigHandler._privateConstructor();

  static final ConfigHandler _instance = ConfigHandler._privateConstructor();

  factory ConfigHandler() {
    return _instance;
  }

  final List<Device> _devices = List.empty(growable: true);

  void loadConfig() async {
    final file = File(_filePath);
    if(!file.existsSync()) {
      Logger.log("Fatal: Config file doesn't exists");
      exit(-1);
    }
    final input = await file.readAsString();

    // Load file
    late final List<dynamic> jsonData;
    try {
      jsonData = jsonDecode(input);
    } on FormatException catch(e) {
      Logger.log("Warning: Configuration file is corrupt. Repairing...");
      _repairConfigFile();
      loadConfig();
      return;
    }

    // Parse Data to Model
    try {
      for(int i = 0; i < jsonData.length; i++) {
        _devices.add(Device.fromJson(jsonData[i]));
      }
    } catch(e) {
      Logger.log("Warning: Configuration file is invalid. Repairing...");
      _repairConfigFile();
      loadConfig();
      return;
    }

    Logger.log("Successfully loaded Devices");
  }

  void _repairConfigFile() async {
    final file = File(_filePath);
    await file.writeAsString("[]");
  }

  List<Device> get devices => _devices;
}