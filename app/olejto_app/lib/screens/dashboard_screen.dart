import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/vehicle_models.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  final List<VehicleOverview> _vehicles = [
    const VehicleOverview(
      name: 'BMW E90',
      plate: 'WA 4821K',
      currentMileage: 214350,
      kilometersLeft: 980,
      oilHealth: 0.62,
      status: ServiceStatus.soon,
    ),
    const VehicleOverview(
      name: 'Skoda Octavia',
      plate: 'WPR 9A21',
      currentMileage: 128040,
      kilometersLeft: 2410,
      oilHealth: 0.81,
      status: ServiceStatus.ok,
    ),
  ];

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

  String _statusLabel(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.ok:
        return 'OK';
      case ServiceStatus.soon:
        return 'Wkrotce';
      case ServiceStatus.urgent:
        return 'Pilne';
    }
  }

  List<ReminderItem> _buildReminders() {
    if (_vehicles.isEmpty) {
      return const [
        ReminderItem(
          title: 'Dodaj pierwsze auto',
          subtitle: 'Powiadomienia pojawia sie po dodaniu pojazdu',
          status: ServiceStatus.ok,
          icon: Icons.info_outline,
        ),
      ];
    }

    final sorted = [..._vehicles]..sort((a, b) => a.kilometersLeft.compareTo(b.kilometersLeft));
    return sorted.take(3).map((vehicle) {
      return ReminderItem(
        title: '${vehicle.name}: wymiana oleju',
        subtitle: 'Za okolo ${vehicle.kilometersLeft} km',
        status: vehicle.status,
        icon: Icons.oil_barrel_outlined,
      );
    }).toList();
  }

  Future<void> _openAddVehicleForm() async {
    final vehicle = await Navigator.of(context).push<VehicleOverview>(
      MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
    );

    if (vehicle == null) {
      return;
    }

    setState(() {
      _vehicles.add(vehicle);
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dodano pojazd: ${vehicle.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final soonCount = _vehicles.where((v) => v.status == ServiceStatus.soon).length;
    final urgentCount = _vehicles.where((v) => v.status == ServiceStatus.urgent).length;
    final reminders = _buildReminders();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -70,
            child: _BgBlob(
              size: 260,
              colors: const [Color(0x263DAE78), Color(0x0025A56F)],
            ),
          ),
          Positioned(
            top: 170,
            left: -110,
            child: _BgBlob(
              size: 230,
              colors: const [Color(0x1FD39F2A), Color(0x00D39F2A)],
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                    child: _HeroCard(
                      vehicleCount: _vehicles.length,
                      soonCount: soonCount,
                      urgentCount: urgentCount,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: _QuickActions(onAddVehicle: _openAddVehicleForm),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: _SectionTitle(
                      title: 'Twoje auta',
                      trailing: TextButton(
                        onPressed: () {},
                        child: const Text('Zobacz wszystko'),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                  sliver: _vehicles.isEmpty
                      ? SliverToBoxAdapter(
                          child: _EmptyVehiclesState(onAddPressed: _openAddVehicleForm),
                        )
                      : SliverList.separated(
                          itemBuilder: (context, index) {
                            final vehicle = _vehicles[index];
                            return _VehicleCard(
                              vehicle: vehicle,
                              statusColor: _statusColor(vehicle.status),
                              statusLabel: _statusLabel(vehicle.status),
                            );
                          },
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemCount: _vehicles.length,
                        ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                    child: _SectionTitle(
                      title: 'Nadchodzace przypomnienia',
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.tune),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                  sliver: SliverList.separated(
                    itemBuilder: (context, index) {
                      final item = reminders[index];
                      return _ReminderTile(
                        item: item,
                        statusColor: _statusColor(item.status),
                        statusLabel: _statusLabel(item.status),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemCount: reminders.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddVehicleForm,
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Dodaj auto'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (index) {
          setState(() {
            _navIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Historia'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Ustawienia'),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.vehicleCount,
    required this.soonCount,
    required this.urgentCount,
  });

  final int vehicleCount;
  final int soonCount;
  final int urgentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A6F51), Color(0xFF58A47A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x331F7A58),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0x28FFFFFF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset('assets/logo.png', width: 36, height: 36),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OlejTo',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const Text(
                        'Serwis auta pod kontrola',
                        style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0x24FFFFFF),
                  ),
                  icon: const Icon(Icons.notifications_none, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Profesjonalny dziennik serwisowy\ndla codziennej jazdy',
              style: TextStyle(
                color: Colors.white,
                height: 1.25,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _MetricPill(label: 'Auta', value: '$vehicleCount'),
                const SizedBox(width: 8),
                _MetricPill(label: 'Wkrotce', value: '$soonCount'),
                const SizedBox(width: 8),
                _MetricPill(label: 'Pilne', value: '$urgentCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
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
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Color(0xD9FFFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.onAddVehicle});

  final VoidCallback onAddVehicle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            icon: Icons.add_circle_outline,
            title: 'Dodaj auto',
            subtitle: 'Nowy pojazd',
            onTap: onAddVehicle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionCard(
            icon: Icons.oil_barrel_outlined,
            title: 'Wpis serwis',
            subtitle: 'Nowa wymiana',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionCard(
            icon: Icons.insights_outlined,
            title: 'Raport',
            subtitle: 'Historia',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primaryGreen),
            const SizedBox(height: 8),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.trailing});

  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        trailing,
      ],
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard({
    required this.vehicle,
    required this.statusColor,
    required this.statusLabel,
  });

  final VehicleOverview vehicle;
  final Color statusColor;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProgressBadge(value: vehicle.oilHealth, color: statusColor),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          vehicle.name,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${vehicle.plate}  •  ${vehicle.currentMileage} km',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: vehicle.oilHealth,
                      minHeight: 7,
                      color: statusColor,
                      backgroundColor: const Color(0xFFEAEFEC),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.route_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        'Do wymiany: ${vehicle.kilometersLeft} km',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  const _ProgressBadge({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final clamped = value.clamp(0.0, 1.0);

    return SizedBox(
      width: 62,
      height: 62,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: clamped),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, animatedValue, _) {
          return CustomPaint(
            painter: _ArcPainter(progress: animatedValue, color: color),
            child: Center(
              child: Text(
                '${(clamped * 100).round()}%',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = 7.0;
    final center = size.center(Offset.zero);
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = const Color(0xFFE8EFEB)
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, bgPaint);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({
    required this.item,
    required this.statusColor,
    required this.statusLabel,
  });

  final ReminderItem item;
  final Color statusColor;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: statusColor.withValues(alpha: 0.16),
            child: Icon(item.icon, color: statusColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            statusLabel,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _EmptyVehiclesState extends StatelessWidget {
  const _EmptyVehiclesState({required this.onAddPressed});

  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/logo-full.png', height: 36),
          const SizedBox(height: 10),
          Text(
            'Dodaj pierwsze auto',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Rozpocznij monitoring wymiany oleju i przypomnien serwisowych.',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: const Text('Dodaj pojazd'),
          ),
        ],
      ),
    );
  }
}

class _BgBlob extends StatelessWidget {
  const _BgBlob({required this.size, required this.colors});

  final double size;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
        ),
      ),
    );
  }
}

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _plateController = TextEditingController();
  final _mileageController = TextEditingController();
  final _kilometersLeftController = TextEditingController(text: '1500');

  @override
  void dispose() {
    _nameController.dispose();
    _plateController.dispose();
    _mileageController.dispose();
    _kilometersLeftController.dispose();
    super.dispose();
  }

  ServiceStatus _mapStatus(int kilometersLeft) {
    if (kilometersLeft < 300) {
      return ServiceStatus.urgent;
    }
    if (kilometersLeft <= 1000) {
      return ServiceStatus.soon;
    }
    return ServiceStatus.ok;
  }

  double _mapHealth(int kilometersLeft) {
    final value = kilometersLeft / 3000;
    return value.clamp(0.06, 1.0);
  }

  void _saveVehicle() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final mileage = int.parse(_mileageController.text.trim());
    final kilometersLeft = int.parse(_kilometersLeftController.text.trim());

    final vehicle = VehicleOverview(
      name: _nameController.text.trim(),
      plate: _plateController.text.trim().toUpperCase(),
      currentMileage: mileage,
      kilometersLeft: kilometersLeft,
      oilHealth: _mapHealth(kilometersLeft),
      status: _mapStatus(kilometersLeft),
    );

    Navigator.of(context).pop(vehicle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj auto')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1D7456), Color(0xFF4E9B73)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset('assets/logo.png', width: 46, height: 46),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Dodaj auto i uruchom przypomnienia serwisowe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nazwa auta (np. BMW E90)',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Podaj nazwe pojazdu';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _plateController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Tablica rejestracyjna'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Podaj tablice';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _mileageController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Aktualny przebieg (km)'),
                  validator: (value) {
                    final parsed = int.tryParse(value?.trim() ?? '');
                    if (parsed == null || parsed <= 0) {
                      return 'Podaj poprawny przebieg';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _kilometersLeftController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Ile km do wymiany oleju'),
                  validator: (value) {
                    final parsed = int.tryParse(value?.trim() ?? '');
                    if (parsed == null || parsed < 0) {
                      return 'Podaj poprawna liczbe km';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _saveVehicle,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Zapisz pojazd'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
