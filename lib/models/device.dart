class Device {
  final String _ip;
  final String _mac;
  final String _name;

  const Device(this._ip, this._mac, this._name);

  Device.fromJson(Map<String, dynamic> json) : this._ip = json["ip"], this._mac = json["mac"], this._name = json["name"];

  String get name => _name;

  String get mac => _mac;

  String get ip => _ip;
}