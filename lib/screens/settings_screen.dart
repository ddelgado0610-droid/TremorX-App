import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text(
          "Settings",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: SwitchListTile(
            title: const Text("Bluetooth"),
            subtitle: const Text(
              "Connect to TremorX device",
            ),
            value: true,
            onChanged: null,
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Device Information"),
            subtitle: Text("TremorX Prototype"),
          ),
        ),
      ],
    );
  }
}
