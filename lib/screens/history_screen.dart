import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  final List<Map<String, String>> sessions = const [
    {
      "date": "Today",
      "time": "10:30 AM",
      "duration": "25 min",
      "reduction": "72%",
    },
    {
      "date": "Yesterday",
      "time": "3:15 PM",
      "duration": "18 min",
      "reduction": "68%",
    },
    {
      "date": "July 19",
      "time": "11:00 AM",
      "duration": "30 min",
      "reduction": "75%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Therapy History",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          "Recent therapy sessions and device performance",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 20),

        Expanded(
          child: ListView.builder(
            itemCount: sessions.length,

            itemBuilder: (context, index) {
              final session = sessions[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),

                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.history),
                  ),

                  title: Text(
                    session["date"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    "${session["time"]} • ${session["duration"]}",
                  ),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Reduction",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),

                      Text(
                        session["reduction"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}