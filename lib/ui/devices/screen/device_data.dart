import 'package:farmassist/app_theme.dart';
import 'package:farmassist/ui/IoT/telemetry_data_card_item.dart';
import 'package:flutter/material.dart';

import '../model/get_device_data_response.dart';

class DeviceDataScreen extends StatelessWidget {
  const DeviceDataScreen({super.key, required this.deviceData});
  final Records deviceData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          if (deviceData.humidity != null && deviceData.humidity != 0)
            DeviceDataCard(
              value: deviceData.humidity!.toStringAsFixed(1),
              cardItem: TelemetryDataCardItem(
                title: 'Air Humidity',
                description: 'Relative percentage of water vapour present in air',
                unit: '%',
                imagePath: 'assets/images/air_humidity.png',
                color1: const Color(0xFF6F56E8),
                color2: const Color(0xFF79D1FB),
                data: "humidity",
                lowerBoundary: 40.0,
                upperBoundary: 80.0,
                lowerThreshold: 50.0,
                upperThreshold: 70.0,
              ),
            ),
          if (deviceData.temperature != null && deviceData.temperature != 0)
            DeviceDataCard(
              value: deviceData.temperature!.toStringAsFixed(1),
              cardItem: TelemetryDataCardItem(
                title: 'Air Temperature',
                description: 'Weather parameter that measures how hot or cold the air is',
                unit: '°C',
                imagePath: 'assets/images/air_temperature.png',
                color1: const Color(0xFF006400),
                color2: const Color(0xFF1FDF39),
                data: "temperature",
                lowerBoundary: 15.0,
                upperBoundary: 35.0,
                lowerThreshold: 18.0,
                upperThreshold: 28.0,
              ),
            ),
          if (deviceData.moisture != null && deviceData.moisture != 0)
            DeviceDataCard(
              value: deviceData.moisture!.toStringAsFixed(1),
              cardItem: TelemetryDataCardItem(
                title: 'Soil Moisture',
                description: 'Percentage of volumetric water content in soil',
                unit: '%',
                imagePath: 'assets/images/soil_moisture.png',
                color1: const Color(0xFF800000),
                color2: const Color(0xFFD2691E),
                data: "moisture",
                lowerBoundary: 30.0,
                upperBoundary: 60.0,
                lowerThreshold: 40.0,
                upperThreshold: 50.0,
              ),
            ),
        ],
      ),
    );
  }
}

class DeviceDataCard extends StatelessWidget {
  const DeviceDataCard({super.key, required this.cardItem, required this.value});
  final TelemetryDataCardItem cardItem;
  final String value;

  @override
  Widget build(BuildContext context) {
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
                  cardItem.color1,
                  cardItem.color2,
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
                    cardItem.title,
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
                    value + cardItem.unit,
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
                        cardItem.description,
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
                  ),
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
          child: Image.asset(cardItem.imagePath),
        ),
      ],
    );
  }
}
