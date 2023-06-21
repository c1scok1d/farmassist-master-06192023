import 'dart:async';
import 'dart:io' show Platform;

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:farmassist/ui/devices/cubit/devices_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wifi_scan/wifi_scan.dart';

// class AddDeviceScreen extends StatefulWidget {
//   const AddDeviceScreen({super.key});

//   @override
//   State<AddDeviceScreen> createState() => _AddDeviceScreenState();
// }

// class _AddDeviceScreenState extends State<AddDeviceScreen> {
//   late StreamSubscription bleSubscription;
//   DiscoveredDevice? espDevice;
//   final flutterReactiveBle = FlutterReactiveBle();

//   @override
//   void initState() {
//     super.initState();
//     scan();
//   }

//   final deviceGATTserviceUUID = Uuid.parse('021A9004-0382-4AEA-BFF4-6B3F1C5ADFB4');
//   final deviceGATTInfoCharUUID = Uuid.parse('021AFF53-0382-4AEA-BFF4-6B3F1C5ADFB4');
//   final deviceGATTCustomDataCharUUID = Uuid.parse('021AFF55-0382-4AEA-BFF4-6B3F1C5ADFB4');
//   final deviceGATTProvConfigCharUUID = Uuid.parse('021AFF52-0382-4AEA-BFF4-6B3F1C5ADFB4');

//   void scan() async {
//     final locationPermission = await Permission.locationWhenInUse.request();
//     final bluetoothScanPermission = await Permission.bluetoothScan.request();
//     final bluetoothConnectPermission = await Permission.bluetoothConnect.request();

//     if ([locationPermission, bluetoothConnectPermission, bluetoothScanPermission]
//         .any((permission) => permission != PermissionStatus.granted)) return;
//     final l = loc.Location();
//     final locationOn = await l.serviceEnabled();
//     if (locationOn == false) l.requestService();
//     bleSubscription = flutterReactiveBle.scanForDevices(
//         withServices: [deviceGATTserviceUUID], scanMode: ScanMode.lowLatency).listen(
//       (device) async {
//         await bleSubscription.cancel();
//         espDevice = device;
//       },
//       onError: (e) {},
//     );
//   }

//   // void connectToDevice() {
//   //   if (isConnecting) {
//   //     return;
//   //   }

//   //   isConnecting = true;
//   //   StreamSubscription<ConnectionStateUpdate>? connectionStateStream;
//   //   connectionStateStream =
//   //       flutterReactiveBle.connectToDevice(id: espDevice!.id).listen((event) async {
//   //     if (event.connectionState == DeviceConnectionState.connected) {
//   //       isConnecting = false;
//   //       final infoCharacteristic = QualifiedCharacteristic(
//   //           serviceId: deviceGATTserviceUUID,
//   //           characteristicId: deviceGATTInfoCharUUID,
//   //           deviceId: espDevice!.id);
//   //       await flutterReactiveBle.writeCharacteristicWithResponse(infoCharacteristic,
//   //           value: Uint8List.fromList('ESP'.codeUnits));
//   //       final info = await flutterReactiveBle.readCharacteristic(infoCharacteristic);
//   //       if (kDebugMode) {
//   //         print(String.fromCharCodes(info));
//   //       }
//   //       final provConfigCharacteristic = QualifiedCharacteristic(
//   //           serviceId: deviceGATTserviceUUID,
//   //           characteristicId: deviceGATTProvConfigCharUUID,
//   //           deviceId: espDevice!.id);

//   //       await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
//   //           value: startOfConfig);
//   //       final readconfChar = await flutterReactiveBle.readCharacteristic(provConfigCharacteristic);

//   //       await Future.delayed(const Duration(seconds: 1));

//   //       final customDataCharacteristic = QualifiedCharacteristic(
//   //           serviceId: deviceGATTserviceUUID,
//   //           characteristicId: deviceGATTCustomDataCharUUID,
//   //           deviceId: espDevice!.id);

//   //       //String name = "testDevice", location = "testLocation";
//   //       await flutterReactiveBle.writeCharacteristicWithResponse(customDataCharacteristic,
//   //           value: Uint8List.fromList(
//   //               "{\"name\":\"$_deviceName\",\"location\":\"$_deviceLocation\"}".codeUnits));
//   //       await Future.delayed(const Duration(seconds: 2));
//   //       await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
//   //           value: _getWiFiConfigDataToWrite());
//   //       final readconfChar2 = await flutterReactiveBle.readCharacteristic(provConfigCharacteristic);

//   //       await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
//   //           value: applyConfigData);
//   //       await Future.delayed(const Duration(seconds: 1));
//   //     }
//   //   }, onDone: () {
//   //     if (kDebugMode) {
//   //       print('connected');
//   //     }
//   //   }, onError: (e) {
//   //     if (kDebugMode) {
//   //       print(e.toString());
//   //     }
//   //     isConnecting = false;
//   //   });
//   // }

//   @override
//   void dispose() {
//     bleSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add New Device',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Center(
//         child: espDevice == null
//             ? CircularProgressIndicator()
//             : Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     ListTile(
//                       onTap: () {
//                         context.read<DevicesProvider>().addNewDevice(espDevice!);
//                       },
//                       title: Text(
//                         espDevice!.name,
//                         style: TextStyle(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

class BLESCR extends StatefulWidget {
  const BLESCR({Key? key}) : super(key: key);

  @override
  _BLESCRState createState() => _BLESCRState();
}

class _BLESCRState extends State<BLESCR> {
// Some state management stuff
  bool _foundDeviceWaitingToConnect = false;
  bool _scanStarted = false;
  bool _connected = false;

// Bluetooth related variables
  late DiscoveredDevice _uniqueDevice;
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late QualifiedCharacteristic _rxCharacteristic;

// These are the UUIDs
  final deviceGATTserviceUUID =
      //Uuid.parse('1775244D-6B43-439B-877C-060F2D9BED07');
      Uuid.parse('021A9004-0382-4AEA-BFF4-6B3F1C5ADFB4');
  final deviceGATTInfoCharUUID =
      //Uuid.parse('1775FF53-6B43-439B-877C-060F2D9BED07');
      Uuid.parse('021AFF53-0382-4AEA-BFF4-6B3F1C5ADFB4');
  final deviceGATTCustomDataCharUUID =
      //Uuid.parse('1775FF55-6B43-439B-877C-060F2D9BED07');
      Uuid.parse('021AFF55-0382-4AEA-BFF4-6B3F1C5ADFB4');
  final deviceGATTProvConfigCharUUID =
      //Uuid.parse('1775FF52-6B43-439B-877C-060F2D9BED07');
      Uuid.parse('021AFF52-0382-4AEA-BFF4-6B3F1C5ADFB4');
  final applyConfigData = Uint8List.fromList([0x08, 0x04, 0x72, 0x00]);
  final startOfConfig = Uint8List.fromList([0x52, 0x03, 0xA2, 0x01, 0x00]);

  String _password = "networkPassword";
  String _ssid = "RodlandFarms";
  String _sensorLocation = "bar";
  String _sensorName = "foo";

  //String _hostname = "hostname";

  void _startScan() async {
    // Main scanning logic happens here ⤵️
    setState(() {
      _scanStarted = true;
    });
    _scanStream =
        flutterReactiveBle.scanForDevices(withServices: [deviceGATTserviceUUID]).listen((device) {
      if (device.name.startsWith('RodlandFarms')) {
        setState(() {
          _uniqueDevice = device;
          _foundDeviceWaitingToConnect = true;
          _foundDevice(device.name);
        });
      } else {
        // todo
        // display all bluetooth devices as ios devices do not recognize device name
        // or, find a way for ios device to recognize device name
        // on press of device name:
        // _foundDevice(deviceName);
        if (Uuid.parse(device.id) == this.deviceGATTserviceUUID) {
          setState(() {
            _uniqueDevice = device;
            _foundDeviceWaitingToConnect = true;
            _foundDevice(device.id);
            //_foundDevice(device.name);
          });
        }
      }
    });
    //}
  }

  void _foundDevice(String deviceName) {
    // We're done scanning, we can cancel it
    _scanStream.cancel();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Device Discovered.'),
          content: Text("Provision device $deviceName"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("YES"),
              onPressed: () {
                scanForWifiNetworks();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("NO"),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("CANCEL"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _connectToDevice() {
    EasyLoading.dismiss();
    // Let's listen to our connection so we can make updates on a state change

    Stream<ConnectionStateUpdate> currentConnectionStream = flutterReactiveBle
        .connectToAdvertisingDevice(
            id: _uniqueDevice.id,
            prescanDuration: const Duration(seconds: 3),
            withServices: [deviceGATTserviceUUID, deviceGATTProvConfigCharUUID]);

    currentConnectionStream.listen((event) async {
      switch (event.connectionState) {
        // We're connected and good to go!
        case DeviceConnectionState.connected:
          {
            _rxCharacteristic = QualifiedCharacteristic(
                serviceId: deviceGATTserviceUUID,
                characteristicId: deviceGATTInfoCharUUID,
                deviceId: event.deviceId);

            // method to get hostname string from device

            final infoCharacteristic = QualifiedCharacteristic(
                serviceId: deviceGATTserviceUUID,
                characteristicId: deviceGATTInfoCharUUID,
                deviceId: event.deviceId);
            await flutterReactiveBle.writeCharacteristicWithResponse(infoCharacteristic,
                value: Uint8List.fromList('ESP'.codeUnits));
            final info = await flutterReactiveBle.readCharacteristic(infoCharacteristic);
            if (kDebugMode) {
              print(String.fromCharCodes(info));
            }
            final provConfigCharacteristic = QualifiedCharacteristic(
                serviceId: deviceGATTserviceUUID,
                characteristicId: deviceGATTProvConfigCharUUID,
                deviceId: event.deviceId);

            await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
                value: startOfConfig);
            final readconfChar =
                await flutterReactiveBle.readCharacteristic(provConfigCharacteristic);
            if (kDebugMode) {
              print(readconfChar);
            }
            await Future.delayed(const Duration(seconds: 1));

            final customDataCharacteristic = QualifiedCharacteristic(
                serviceId: deviceGATTserviceUUID,
                characteristicId: deviceGATTCustomDataCharUUID,
                deviceId: event.deviceId);

            await flutterReactiveBle.writeCharacteristicWithResponse(customDataCharacteristic,
                value: Uint8List.fromList(
                    "{\"name\":\"$_sensorName\",\"location\":\"$_sensorLocation\"}".codeUnits));
            await Future.delayed(const Duration(seconds: 2));
            await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
                value: _getWiFiConfigDataToWrite());
            final readconfChar2 =
                await flutterReactiveBle.readCharacteristic(provConfigCharacteristic);
            if (kDebugMode) {
              print(readconfChar2);
            }

            await flutterReactiveBle.writeCharacteristicWithResponse(provConfigCharacteristic,
                value: applyConfigData);
            await Future.delayed(const Duration(seconds: 1));

            setState(() {
              _foundDeviceWaitingToConnect = false;
              _connected = true;
            });
            break;
          }
        // Can add various state state updates on disconnect
        case DeviceConnectionState.disconnected:
          {
            break;
          }
        default:
      }
    });
  }

  Uint8List _getWiFiConfigDataToWrite() {
    //add actual wifi config. hope u don't mind me seeinf the wifi password. to se if it's connecting to wifi
    final ssid = _ssid.codeUnits;
    final password = _password.codeUnits;
    final startHeader = [0x08, 0x02, 0x62];
    const configStartByte = 0x0A;
    final ssidLength = ssid.length;
    final passwordLength = password.length;
    final payloadSize = [(ssidLength + passwordLength + 0x04)];
    const ssidPasswordSeperatorByte = 0x12;

    final configDataToWrite = Uint8List.fromList(startHeader +
        payloadSize +
        [configStartByte] +
        [ssidLength] +
        ssid +
        [ssidPasswordSeperatorByte] +
        [passwordLength] +
        password);

    return configDataToWrite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Back to dashboard"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(),
      persistentFooterButtons: [
        // We want to enable this button if the scan has NOT started
        // If the scan HAS started, it should be disabled.
        _scanStarted
            // True condition
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // background
                  foregroundColor: Colors.white, // foreground
                ),
                onPressed: () async {},
                child: const Icon(Icons.search),
              )
            // False condition
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // background
                  foregroundColor: Colors.white, // foreground
                ),
                //if bluetooth not enabled:
                // customEnableBT(context)
                // or
                onPressed: () async {
                  final locationPermission = await Permission.locationWhenInUse.request();
                  final bluetoothScanPermission = await Permission.bluetoothScan.request();
                  final bluetoothConnectPermission = await Permission.bluetoothConnect.request();

                  if ([locationPermission, bluetoothConnectPermission, bluetoothScanPermission]
                      .any((permission) => permission != PermissionStatus.granted)) return;

                  final bluetoothEnable = await isBluetoothEnabled();
                  final locationOn = await location.Location().serviceEnabled();
                  if (locationOn == false) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Turn on Location')));
                    Future.delayed(Duration(seconds: 2), () {
                      location.Location().requestService();
                    });
                    return;
                  }
                  if (bluetoothEnable == false) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Turn on Bluetooth')));
                    Future.delayed(Duration(seconds: 2), () {
                      enableBluetooth();
                    });
                    return;
                  }
                  _startScan();
                },
                child: const Icon(Icons.search),
              ),
        _foundDeviceWaitingToConnect
            // True condition
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // background
                  foregroundColor: Colors.white, // foreground
                ),
                onPressed: () => scanForWifiNetworks(),
                child: const Icon(Icons.bluetooth),
              )
            // False condition
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // background
                  foregroundColor: Colors.white, // foreground
                ),
                onPressed: () {},
                child: const Icon(Icons.bluetooth),
              ),
        /*_connected
        // True condition
            ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: _partyTime,
          child: const Icon(Icons.celebration_rounded),
        )
        // False condition
            : ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: () {},
          child: const Icon(Icons.celebration_rounded),
        ), */
      ],
    );
  }

  Future<void> scanForWifiNetworks() async {
    EasyLoading.dismiss();
    if ((await WiFiScan.instance.canStartScan(askPermissions: true)) == CanStartScan.yes) {
      // can safely call scan related functionalities
      final error = await WiFiScan.instance.startScan();
      if (error) {
        if (kDebugMode) {
          print('Error: $error');
        }
      } else {
        if (kDebugMode) {
          print('Scan started');
        }
        final result = await WiFiScan.instance.getScannedResults();
        if (result.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to get Results',
                style: TextStyle(),
              ),
            ),
          );
        } else {
          EasyLoading.dismiss();
          final accessPoints = result;
          if (kDebugMode) {
            print('Scan result: $accessPoints');
          }
          //show access points in a dialog list
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                title: const Text('Select Your Wifi Network'),
                content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: accessPoints.length,
                      itemBuilder: (BuildContext context, int index) {
                        final accessPoint = accessPoints[index];
                        if (accessPoint.ssid != "") {}
                        return ListTile(
                          title: Text(accessPoint.ssid),
                          onTap: () {
                            Navigator.of(context).pop();
                            _ssid = accessPoint.ssid;
                            EasyLoading.show(status: 'Saving WiFi network name...');
                            getWifiPassword(accessPoint);
                          },
                        );
                      },
                    )),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Scan Devices")));
    }
  }

  void getWifiPassword(WiFiAccessPoint accessPoint) {
    EasyLoading.dismiss();
    //show password dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('WiFi Password'),
          content: SizedBox(
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tap to Enter WiFi Password',
                    ),
                    onChanged: (String value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      child: const Text("Save"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        EasyLoading.show(status: 'Sending password...');
                        setUpSensorName();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //String sensorName = "";
  void setUpSensorName() {
    EasyLoading.dismiss();
    //show sensor name dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Plant Name'),
          content: SizedBox(
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tap to enter plant name',
                    ),
                    onChanged: (String value) {
                      _sensorName = value;
                    },
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      child: const Text("Save"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        EasyLoading.show(status: 'Saving sensor name...');
                        setUpSensorLocation();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> isBluetoothEnabled() async {
    final BluetoothState bluetoothState = await FlutterBluetoothSerial.instance.state;
    return bluetoothState == BluetoothState.STATE_ON;
  }

  Future<bool?> enableBluetooth() async {
    if (Platform.isAndroid) {
      // On Android, open Bluetooth settings
      return await FlutterBluetoothSerial.instance.requestEnable();
    } else if (Platform.isIOS) {
      // On iOS, show a dialog prompting the user to enable Bluetooth
      return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Enable Bluetooth"),
                content: const Text("Please enable Bluetooth in the device settings."),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: const Text("Enable"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          ) ??
          false;
    }
    return false;
  }

  void setUpSensorLocation() {
    EasyLoading.dismiss();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Plant Location'),
          content: SizedBox(
            height: 125,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //const Text('Tap to enter plant name'),
                  TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tap to enter plant location',
                    ),
                    onChanged: (String value) {
                      _sensorLocation = value;
                    },
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      child: const Text("Save"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        EasyLoading.show(status: 'Saving sensor location...');
                        _connectToDevice();
                        EasyLoading.dismiss();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void addDeviceToDashboard(String received) {
    EasyLoading.dismiss();
    if (kDebugMode) {
      print("Adding device to dashboard");
    }
    context.read<DevicesProvider>().addNewDevice(received).then((value) async {
      EasyLoading.dismiss();
      if (value.success == true) {
        //EasyLoading.show(status: 'Adding to dashboard...');
        if (kDebugMode) {
          print("Adding to firebase:");
        }
        await FirebaseMessaging.instance.subscribeToTopic("host_$received");
        EasyLoading.showSuccess("Adding device to dashboard...");
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      } else {
        EasyLoading.showError(value.message ?? 'Error adding device');
      }
    }).catchError((error) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error adding device');
    });
  }

  Future<void> enableBT() async {
    BluetoothEnable.enableBluetooth.then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
  }

  Future<void> customEnableBT(BuildContext context) async {
    String dialogTitle = "Bluetooth Permission Required";
    bool displayDialogContent = true;
    String dialogContent = "This app requires Bluetooth to connect to device.";
    String cancelBtnText = "No";
    String acceptBtnText = "Yes";
    double dialogRadius = 10.0;
    bool barrierDismissible = true; //

    BluetoothEnable.customBluetoothRequest(context, dialogTitle, displayDialogContent,
            dialogContent, cancelBtnText, acceptBtnText, dialogRadius, barrierDismissible)
        .then((value) {
      if (value == "true") {
        //_startScan();
      }
      if (kDebugMode) {
        print(value);
      }
    });
  }
}
