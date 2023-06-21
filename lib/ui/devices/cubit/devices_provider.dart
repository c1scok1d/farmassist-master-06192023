import 'package:farmassist/ui/devices/model/get_device_data_response.dart';
import 'package:farmassist/ui/devices/repository/devices_repository.dart';
import 'package:flutter/material.dart';

import '../model/save_device_response.dart';

class DevicesProvider extends ChangeNotifier {
  DevicesProvider() {
    loadDevices();
  }
  final DevicesRepository _repository = DevicesRepository();

  bool _loadingDevices = false;
  bool get loadingDevices => _loadingDevices;
  set loadingDevices(bool value) {
    _loadingDevices = value;
    notifyListeners();
  }

  bool _loadingDeviceData = false;
  bool get loadingDeviceData => _loadingDeviceData;
  set loadingDeviceData(bool value) {
    _loadingDeviceData = value;
    notifyListeners();
  }

  List<Records>? _devicesData;
  List<Records>? get devicesData => _devicesData;
  set devicesData(List<Records>? value) {
    _devicesData = value;
    notifyListeners();
  }

  void loadDevices() async {
    loadingDevices = true;
    try {
      final data = await _repository.getUserDevices();
      if (data.isNotEmpty) {
        devicesData = data;
      } else {
        throw Exception();
      }
    } catch (_) {
      devicesData = devicesData;
    } finally {
      loadingDevices = false;
    }
  }

  Future<SaveDeviceResponse> addNewDevice(espDevice) async {
    final result = await _repository.saveDevice(espDevice.name);
    loadDevices();
    return result;
  }
}
