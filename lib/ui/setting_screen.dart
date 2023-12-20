import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
          style: TextStyle(
          fontWeight: FontWeight.bold),),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (_, preferences, __) {
          return Consumer<SchedulingProvider>(
            builder: (_, scheduled, __) {
              return SwitchListTile(
                title: const Text('Daily Reminder',
                  style: TextStyle(
                  fontWeight: FontWeight.bold),),
                value: preferences.isDailyReminderActive,
                onChanged: (value) async {
                    scheduled.scheduledReminder(value);
                    preferences.enableDailyReminder(value);
                },
                  secondary: const Icon(Icons.lightbulb_outline)
              );
            },
          );
        },
      ),
    );
  }
}