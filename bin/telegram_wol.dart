import 'dart:io';

import 'package:telegram_wol/config/config_handler.dart';
import 'package:telegram_wol/logger/logger.dart';
import 'package:telegram_wol/telegram/telegram_handler.dart';

void main(List<String> arguments) async {
  final String? telegramToken = Platform.environment["telegram-token"];
  if(telegramToken == null || telegramToken.isEmpty) {
    Logger.log("Fatal: Missing telegram-token env variable");
    return;
  }

  final configHandler = ConfigHandler();
  configHandler.loadConfig();
  TelegramHandler(telegramToken, configHandler).boot();
}
