import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  // Simulated device data
  double tremorFrequency = 5.2;
  double tremorAmplitude = 1.8;

  double accelerationX = 0.12;
  double accelerationY = -0.08;
  double accelerationZ = 1.02;

  bool deviceConnected = true;
  bool therapyActive = false;

  Timer? simulationTimer;

  final List<double> tremorData = [];

  @override
  void initState() {
    super.initState();
    startSimulation();
  }

  void startSimulation() {
    simulationTimer = Timer.periodic(
      const Duration(milliseconds: 150),
      (timer) {
        if (!mounted) return;

        setState(() {
          // Simulate a changing tremor waveform
          final double time = DateTime.now()
                  .millisecondsSinceEpoch /
              1000;

          final double newValue =
              sin(time * tremorFrequency * 2 * pi) *
                  tremorAmplitude;

          tremorData.add(newValue);

          // Keep only the latest 40 data points
          if (tremorData.length > 40) {
            tremorData.removeAt(0);
          }

          // Simulated sensor values
          accelerationX = newValue / 10;
          accelerationY = cos(
                    time * tremorFrequency * 2 * pi,
                  ) *
              tremorAmplitude /
              10;

          accelerationZ = 1.0 +
              sin(
                    time * tremorFrequency * 2 * pi,
                  ) *
                  tremorAmplitude /
                  20;
        });
      },
    );
  }

  @override
  void dispose() {
    simulationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(4),
      children: [
        const Text(
          "Live Data",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          "Real-time information from TremorX",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 20),

        // Tremor graph
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 180,
              child: CustomPaint(
                painter: TremorGraphPainter(tremorData),
                size: Size.infinite,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        _buildInfoCard(
          Icons.show_chart,
          "Tremor Frequency",
          "${tremorFrequency.toStringAsFixed(1)} Hz",
          Colors.orange,
        ),

        const SizedBox(height: 12),

        _buildInfoCard(
          Icons.speed,
          "Tremor Amplitude",
          tremorAmplitude.toStringAsFixed(2),
          Colors.blue,
        ),

        const SizedBox(height: 12),

        _buildInfoCard(
          therapyActive
              ? Icons.play_circle
              : Icons.pause_circle,
          "Therapy Status",
          therapyActive ? "Active" : "Inactive",
          therapyActive ? Colors.green : Colors.grey,
        ),

        const SizedBox(height: 12),

        _buildInfoCard(
          deviceConnected
              ? Icons.bluetooth_connected
              : Icons.bluetooth_disabled,
          "Device Connection",
          deviceConnected
              ? "Arduino Connected"
              : "Disconnected",
          deviceConnected
              ? Colors.green
              : Colors.red,
        ),

        const SizedBox(height: 20),

        const Text(
          "Sensor Data",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Card(
          child: Column(
            children: [
              _buildSensorRow(
                "Acceleration X",
                "${accelerationX.toStringAsFixed(3)} g",
              ),
              const Divider(),
              _buildSensorRow(
                "Acceleration Y",
                "${accelerationY.toStringAsFixed(3)} g",
              ),
              const Divider(),
              _buildSensorRow(
                "Acceleration Z",
                "${accelerationZ.toStringAsFixed(3)} g",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
          size: 32,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSensorRow(
    String label,
    String value,
  ) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TremorGraphPainter extends CustomPainter {
  final List<double> data;

  TremorGraphPainter(this.data);

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    if (data.length < 2) return;

    final Paint axisPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    final Paint graphPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Horizontal center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axisPaint,
    );

    final Path path = Path();

    for (int i = 0; i < data.length; i++) {
      final double x =
          i * size.width / (data.length - 1);

      final double y =
          size.height / 2 -
              data[i] *
                  size.height /
                  6;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(
      path,
      graphPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant TremorGraphPainter oldDelegate,
  ) {
    return true;
  }
}