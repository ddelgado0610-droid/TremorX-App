import 'package:flutter/material.dart';
import '../widgets/status_card.dart';
import '../widgets/battery_indicator.dart';
import 'status_screen.dart';
import 'history_screen.dart'; 
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool therapyActive = false;
  int selectedIndex = 0;

  void toggleTherapy() {
    setState(() {
      therapyActive = !therapyActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TremorX"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: IndexedStack(
          index: selectedIndex,
          children: [
            _buildHomeDashboard(),
            const StatusScreen(),
            const HistoryScreen(),
            const SettingsScreen(),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: "Live",
          ),

          NavigationDestination(
            icon: Icon(Icons.history),
            label: "History",
          ),

          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildHomeDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const StatusCard(
          icon: Icons.bluetooth_connected,
          iconColor: Colors.green,
          title: "Device Status",
          subtitle: "Connected",
        ),

        const SizedBox(height: 15),

        const BatteryIndicator(
          batteryLevel: 85,
        ),

        const SizedBox(height: 15),

        StatusCard(
          icon: Icons.health_and_safety,
          iconColor: Colors.blue,
          title: "Therapy",
          subtitle: therapyActive ? "Active" : "Inactive",
        ),

        const SizedBox(height: 15),

        const StatusCard(
          icon: Icons.show_chart,
          iconColor: Colors.orange,
          title: "Tremor Frequency",
          subtitle: "5.2 Hz",
        ),

        const Spacer(),

        SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: toggleTherapy,

            child: Text(
              therapyActive
                  ? "Stop Therapy"
                  : "Start Therapy",

              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}