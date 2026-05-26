import 'package:flutter/material.dart';

enum ServiceStatus { ok, soon, urgent }

enum ReminderType { oilCheck, oilChange, inspection, lpgInspection }

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

class ReminderTask {
  const ReminderTask({
    required this.id,
    required this.vehicleName,
    required this.vehiclePlate,
    required this.type,
    required this.dueDate,
    required this.status,
    this.dueMileage,
    this.isCompleted = false,
    this.completedAt,
  });

  final String id;
  final String vehicleName;
  final String vehiclePlate;
  final ReminderType type;
  final DateTime dueDate;
  final int? dueMileage;
  final ServiceStatus status;
  final bool isCompleted;
  final DateTime? completedAt;

  ReminderTask copyWith({
    String? id,
    String? vehicleName,
    String? vehiclePlate,
    ReminderType? type,
    DateTime? dueDate,
    int? dueMileage,
    ServiceStatus? status,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return ReminderTask(
      id: id ?? this.id,
      vehicleName: vehicleName ?? this.vehicleName,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      type: type ?? this.type,
      dueDate: dueDate ?? this.dueDate,
      dueMileage: dueMileage ?? this.dueMileage,
      status: status ?? this.status,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

String reminderTypeLabel(ReminderType type) {
  switch (type) {
    case ReminderType.oilCheck:
      return 'Kontrola poziomu oleju';
    case ReminderType.oilChange:
      return 'Wymiana oleju';
    case ReminderType.inspection:
      return 'Badanie okresowe';
    case ReminderType.lpgInspection:
      return 'Badanie LPG';
  }
}
