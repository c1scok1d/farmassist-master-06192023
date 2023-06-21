import 'package:farmassist/ui/devices/cubit/devices_provider.dart';
import 'package:farmassist/ui/devices/screen/add_device_Screen.dart';
import 'package:farmassist/ui/widgets/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../app_theme.dart';
import 'device_data.dart';

class DevicesScreen extends TabPage {
  DevicesScreen({required super.key, required super.pageTitle});

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends TabPageState<DevicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DevicesProvider>().loadDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0, elevation: 0),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => BLESCR()));
          },
        ),
        body: Consumer<DevicesProvider>(
          builder: (context, provider, _) {
            if (provider.loadingDevices) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.devicesData!.isEmpty) {
              return Center(
                child: Text(
                  'No Devices',
                  style: TextStyle(),
                ),
              );
            }
            final devices = provider.devicesData;
            return ListView.separated(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              itemCount: devices!.length,
              separatorBuilder: (_, i) => SizedBox(height: 10),
              itemBuilder: (_, index) {
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  tileColor: getColorFromMoisture(devices[index].moisture),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeviceDataScreen(deviceData: devices[index]),
                      ),
                    );
                  },
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [getBatteryIcon(devices[index].batt)],
                  ),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sensor'.padRight(15) + ' : ' + (devices[index].sensor ?? 0).toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: AppTheme.white,
                        ),
                      ),
                   /*   Text(
                        'Moisture'.padRight(14) + ' : ' + (devices[index].moisture ?? 0).toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: AppTheme.white,
                        ),
                      ), */
                      Text(
                        'Location'.padRight(14) + ' : ' + (devices[index].location ?? 0).toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: AppTheme.white,
                        ),
                      ),
                      Text(
                        'Updated ' +
                timeago.format(DateTime.parse(devices![index].updatedAt!)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: AppTheme.white,
                        ),
                      ),
                    ],
                  ),
                );

                // return Card(
                //   child: ListTile(
                //     onTap: () {
                //       context.read<DevicesProvider>().getDeviceData(devices[index]);
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (_) => DeviceDataScreen(),
                //           ));
                //     },
                //     leading: Icon(Icons.devices),
                //     title: Text(devices[index].id.toString()),
                //     subtitle: Text(devices[index].hostname.toString()),
                //     trailing: Text(devices[index].createdAt.toString()),
                //   ),
                // );
              },
            );
          },
        ),
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => BLESCR()));
          },
        ),
        body: Consumer<DevicesProvider>(
          builder: (context, provider, _) {
            if (provider.loadingDevices) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.devicesData!.isEmpty) {
              return Center(
                child: Text(
                  'No Devices',
                  style: TextStyle(),
                ),
              );
            }
            final devices = provider.devicesData;
            return ListView.builder(
              itemCount: devices?.length,
              itemBuilder: (_, index) {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: 16.0,
                        bottom: 18.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(68.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppTheme.grey.withOpacity(0.6),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Sensor'.padRight(15) + ' : ' + (devices?[index].sensor ?? 0).toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  color: AppTheme.white,
                                ),
                              ),
                                 Text(
                                  'Moisture'.padRight(14) + ' : ' + (devices?[index].moisture ?? 0).toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    letterSpacing: 0.0,
                                    color: AppTheme.white,
                                  ),
                                ),
                              Text(
                                'Location'.padRight(14) + ' : ' + (devices?[index].location ?? 0).toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  color: AppTheme.white,
                                ),
                              ),
                              Text(
                                'Updated '.padRight(12) +
                                    ' : ' +
                                timeago.format(DateTime.parse(devices![index].updatedAt!)) + ' ago',
                                    //DateFormat("dd,MMM yyyy")
                                      //  .format(DateTime.parse(devices![index].updatedAt!)),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.0,
                                  color: AppTheme.white,
                                ),
                              ),
                              /*Text(
                                devices?[index].hostName ?? '',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  letterSpacing: 0.0,
                                  color: AppTheme.white,
                                ),
                              ),
                              Text(
                                // devices[index].,
                                'battery level here {level not included in device response}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30,
                                  letterSpacing: 0.0,
                                  color: AppTheme.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: Text(
                                    devices?[index].updatedAt ??
                                        DateFormat('yyyy-MMM-dd hh:mm a').format(DateTime.now()),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4.0,
                      right: 40.0,
                      height: 50,
                      width: 50,
                      child: Image.asset('assets/images/plant_icon.png'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }*/

  Color getColorFromMoisture(num? moisture) {
    if (moisture == null) {
      return Colors.red;
    } else if (moisture > 70) {
      return Colors.green;
    } else if (moisture < 70 && moisture > 40) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget getBatteryIcon(num? batt) {
    if (batt == null) {
      return SizedBox.shrink();
    } else if (batt > 70 && batt > 40) {
      return SvgPicture.asset('assets/svg/battery3.svg');
    } else if (batt < 40) {
      return SvgPicture.asset('assets/svg/battery2.svg');
    } else {
      return SvgPicture.asset('assets/svg/battery1.svg');
    }
  }
}
