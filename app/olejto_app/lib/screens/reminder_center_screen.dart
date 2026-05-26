import 'package:flutter/material.dart';

import '../models/vehicle_models.dart';
import '../theme/app_theme.dart';

class ReminderCenterScreen extends StatelessWidget {
  const ReminderCenterScreen({
    super.key,
    required this.tasks,
    required this.onComplete,
  });

  final List<ReminderTask> tasks;
  final ValueChanged<String> onComplete;

  Color _statusColor(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.ok:
        return const Color(0xFF1D9B5F);
      case ServiceStatus.soon:
        return AppTheme.accentAmber;
      case ServiceStatus.urgent:
        return const Color(0xFFD64545);
    }
  }

  IconData _typeIcon(ReminderType type) {
    switch (type) {
      case ReminderType.oilCheck:
        return Icons.opacity_outlined;
      case ReminderType.oilChange:
        return Icons.oil_barrel_outlined;
      case ReminderType.inspection:
        return Icons.fact_check_outlined;
      case ReminderType.lpgInspection:
        return Icons.local_gas_station_outlined;
    }
  }

  DateTime _onlyDate(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  String _relativeDate(DateTime dueDate) {
    final now = _onlyDate(DateTime.now());
    final due = _onlyDate(dueDate);
    final delta = due.difference(now).inDays;

    if (delta == 0) {
      return 'Dzisiaj';
    }
    if (delta == 1) {
      return 'Jutro';
    }
    if (delta > 1) {
      return 'Za $delta dni';
    }

    final overdueDays = delta.abs();
    if (overdueDays == 1) {
      return '1 dzien po terminie';
    }
    return '$overdueDays dni po terminie';
  }

  List<ReminderTask> _todayTasks() {
    final today = _onlyDate(DateTime.now());
    return tasks
        .where((task) => !task.isCompleted && _onlyDate(task.dueDate) == today)
        .toList();
  }

  List<ReminderTask> _overdueTasks() {
    final today = _onlyDate(DateTime.now());
    return tasks
        .where((task) => !task.isCompleted && _onlyDate(task.dueDate).isBefore(today))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<ReminderTask> _upcomingTasks() {
    final today = _onlyDate(DateTime.now());
    return tasks
        .where((task) => !task.isCompleted && _onlyDate(task.dueDate).isAfter(today))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<ReminderTask> _completedTasks() {
    return tasks.where((task) => task.isCompleted).toList()
      ..sort((a, b) {
        final aDate = a.completedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bDate = b.completedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bDate.compareTo(aDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    final todayTasks = _todayTasks();
    final overdueTasks = _overdueTasks();
    final upcomingTasks = _upcomingTasks();
    final completedTasks = _completedTasks();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: _ReminderHero(
              todayCount: todayTasks.length,
              overdueCount: overdueTasks.length,
              upcomingCount: upcomingTasks.length,
            ),
          ),
        ),
        const _SectionHeader(
          title: 'Dzisiaj',
          subtitle: 'Najwazniejsze przypomnienia na teraz',
        ),
        _SectionList(
          items: todayTasks,
          emptyMessage: 'Brak przypomnien na dzisiaj',
          statusColor: _statusColor,
          relativeDate: _relativeDate,
          typeIcon: _typeIcon,
          onComplete: onComplete,
        ),
        const _SectionHeader(
          title: 'Po terminie',
          subtitle: 'Rzeczy, ktore warto ogarnac priorytetowo',
        ),
        _SectionList(
          items: overdueTasks,
          emptyMessage: 'Nic nie jest po terminie',
          statusColor: _statusColor,
          relativeDate: _relativeDate,
          typeIcon: _typeIcon,
          onComplete: onComplete,
        ),
        const _SectionHeader(
          title: 'Nadchodzace',
          subtitle: 'Co czeka w kolejnych dniach',
        ),
        _SectionList(
          items: upcomingTasks,
          emptyMessage: 'Brak nadchodzacych przypomnien',
          statusColor: _statusColor,
          relativeDate: _relativeDate,
          typeIcon: _typeIcon,
          onComplete: onComplete,
        ),
        const _SectionHeader(
          title: 'Wykonane',
          subtitle: 'Ostatnio zamkniete zadania',
        ),
        _CompletedSection(items: completedTasks, typeIcon: _typeIcon),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }
}

class _ReminderHero extends StatelessWidget {
  const _ReminderHero({
    required this.todayCount,
    required this.overdueCount,
    required this.upcomingCount,
  });

  final int todayCount;
  final int overdueCount;
  final int upcomingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A6F51), Color(0xFF4F9E74)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/logo.png', width: 34, height: 34),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Reminder Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Skup sie na tym, co dzisiaj trzeba ogarnac.',
            style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 13),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _MetricBox(label: 'Dzisiaj', value: '$todayCount'),
              const SizedBox(width: 8),
              _MetricBox(label: 'Po terminie', value: '$overdueCount'),
              const SizedBox(width: 8),
              _MetricBox(label: 'Nadchodzi', value: '$upcomingCount'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  const _MetricBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0x24FFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Color(0xD9FFFFFF), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionList extends StatelessWidget {
  const _SectionList({
    required this.items,
    required this.emptyMessage,
    required this.statusColor,
    required this.relativeDate,
    required this.typeIcon,
    required this.onComplete,
  });

  final List<ReminderTask> items;
  final String emptyMessage;
  final Color Function(ServiceStatus) statusColor;
  final String Function(DateTime) relativeDate;
  final IconData Function(ReminderType) typeIcon;
  final ValueChanged<String> onComplete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              emptyMessage,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          final task = items[index];
          final color = statusColor(task.status);

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: color.withValues(alpha: 0.16),
                  child: Icon(typeIcon(task.type), color: color),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              reminderTypeLabel(task.type),
                              style: const TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              relativeDate(task.dueDate),
                              style: TextStyle(
                                color: color,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${task.vehicleName}  •  ${task.vehiclePlate}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (task.dueMileage != null) ...[
                            const Icon(Icons.route_outlined, size: 15),
                            const SizedBox(width: 4),
                            Text('Prog: ${task.dueMileage} km'),
                            const SizedBox(width: 12),
                          ],
                          const Icon(Icons.calendar_today_outlined, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '${task.dueDate.day.toString().padLeft(2, '0')}.${task.dueDate.month.toString().padLeft(2, '0')}.${task.dueDate.year}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonalIcon(
                          onPressed: () => onComplete(task.id),
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Oznacz jako wykonane'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemCount: items.length,
      ),
    );
  }
}

class _CompletedSection extends StatelessWidget {
  const _CompletedSection({required this.items, required this.typeIcon});

  final List<ReminderTask> items;
  final IconData Function(ReminderType) typeIcon;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      sliver: SliverList.separated(
        itemBuilder: (context, index) {
          final task = items[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAF8),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(typeIcon(task.type), color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${reminderTypeLabel(task.type)} • ${task.vehicleName}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Icon(Icons.check_circle, color: AppTheme.primaryGreen),
              ],
            ),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemCount: items.length,
      ),
    );
  }
}
