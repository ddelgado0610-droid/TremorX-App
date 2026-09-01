import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final int batteryLevel;

  const BatteryIndicator({
    super.key,
    required this.batteryLevel,
  });

  @override
  Widget build(BuildContext context) {
    double batteryValue = batteryLevel / 100;

    IconData batteryIcon;

    if (batteryLevel >= 80) {
      batteryIcon = Icons.battery_full;
    } else if (batteryLevel >= 50) {
      batteryIcon = Icons.battery_5_bar;
    } else if (batteryLevel >= 20) {
      batteryIcon = Icons.battery_3_bar;
    } else {
      batteryIcon = Icons.battery_alert;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  batteryIcon,
                  size: 30,
                ),

                const SizedBox(width: 10),

                const Text(
                  "Battery",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const Spacer(),

                Text(
                  "$batteryLevel%",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: batteryValue,
            ),
          ],
        ),
      ),
    );
  }
}
