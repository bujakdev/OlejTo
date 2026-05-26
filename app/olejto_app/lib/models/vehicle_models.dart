import 'package:flutter/material.dart';

enum ServiceStatus { ok, soon, urgent }

class VehicleOverview {
  const VehicleOverview({
    required this.name,
    required this.plate,
    required this.currentMileage,
    required this.kilometersLeft,
    required this.oilHealth,
    required this.status,
  });

  final String name;
  final String plate;
  final int currentMileage;
  final int kilometersLeft;
  final double oilHealth;
  final ServiceStatus status;
}

class ReminderItem {
  const ReminderItem({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final ServiceStatus status;
  final IconData icon;
}
