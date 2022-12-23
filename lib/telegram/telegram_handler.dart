import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:telegram_wol/config/config_handler.dart';
import 'package:telegram_wol/models/device.dart';
import 'package:telegram_wol/wol/wol_handler.dart';
import 'package:wake_on_lan/wake_on_lan.dart';

class TelegramHandler {
  final String _telegramToken;
  final ConfigHandler _configHandler;

  final _wakeCommand =
      BotCommand(command: "wake", description: "Wake a device");

  TelegramHandler(this._telegramToken, this._configHandler);

  Future<void> boot() async {
    final username = (await Telegram(_telegramToken).getMe()).username;
    var teledart = TeleDart(_telegramToken, Event(username!));

    teledart.start();
    teledart.setMyCommands([_wakeCommand]);
    teledart
        .onCommand(_wakeCommand.command)
        .listen((TeleDartMessage message) async {
      final devices = _configHandler.devices;
      final deviceNames =
          _configHandler.devices.map((device) => device.name).toList();

      if (devices.isEmpty) {
        message.reply("No devices found in the config file");
        return;
      } else if (devices.length == 1) {
        final device = devices.first;
        await _wakeDevice(device, (replyMessage) => message.reply(replyMessage));
        return;
      }

      final List<KeyboardButton> keyboards = deviceNames
          .map((deviceName) => KeyboardButton(text: deviceName))
          .toList();

      await message.reply("Select a Device to wake up",
          reply_markup: ReplyKeyboardMarkup(
              keyboard: [keyboards], one_time_keyboard: true, selective: true));
    });

    teledart.onMessage().listen((TeleDartMessage message) async {
      final devices = _configHandler.devices;

      // check if device exists
      for(final device in devices) {
        if(device.name == message.text) {
          await _wakeDevice(device, (replyMessage) => message.reply(replyMessage));
        }
      }
    });
  }

  Future<void> _wakeDevice(Device device, Future<Message> Function(String) replyMessages) async {
    await replyMessages("Waking ${device.name}...");

    final IPv4Address? ipV4 = WOLHandler.validateIPv4(device.ip);
    if (ipV4 == null) {
      await replyMessages("The IPv4 is in an invalid format. Aborting");
      return;
    }
    final MACAddress? mac = WOLHandler.validateMac(device.mac);
    if (mac == null) {
      await replyMessages("The MAC is in an invalid format. Aborting");
      return;
    }

    WOLHandler.wake(ipV4, mac)
        .then((value) => replyMessages("WOL package sent"));
  }
}
