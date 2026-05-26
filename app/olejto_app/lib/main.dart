import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF1F7A58);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
        scaffoldBackgroundColor: const Color(0xFFF4F7F3),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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

  List<ReminderItem> _buildReminders() {
    if (_vehicles.isEmpty) {
      return const [
        ReminderItem(
          title: 'Dodaj pierwsze auto',
          subtitle: 'Po dodaniu pojazdu przypomnienia pojawia sie tutaj',
          status: ServiceStatus.ok,
          icon: Icons.info_outline,
        ),
      ];
    }

    final sortedVehicles = [..._vehicles]
      ..sort((a, b) => a.kilometersLeft.compareTo(b.kilometersLeft));

    return sortedVehicles.take(3).map((vehicle) {
      return ReminderItem(
        title: '${vehicle.name}: wymiana oleju',
        subtitle: 'Za okolo ${vehicle.kilometersLeft} km',
        status: vehicle.status,
        icon: Icons.oil_barrel_outlined,
      );
    }).toList();
  }

  Color _statusColor(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.ok:
        return const Color(0xFF1D9B5F);
      case ServiceStatus.soon:
        return const Color(0xFFE3A11A);
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

  Future<void> _openAddVehicleForm() async {
    final newVehicle = await Navigator.of(context).push<VehicleOverview>(
      MaterialPageRoute(builder: (_) => const AddVehicleScreen()),
    );

    if (newVehicle == null) {
      return;
    }

    setState(() {
      _vehicles.add(newVehicle);
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dodano pojazd: ${newVehicle.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final soonCount = _vehicles.where((v) => v.status == ServiceStatus.soon).length;
    final urgentCount = _vehicles.where((v) => v.status == ServiceStatus.urgent).length;
    final reminders = _buildReminders();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F7A58), Color(0xFF58A47A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x331F7A58),
                    blurRadius: 22,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0x33FFFFFF),
                        child: Icon(Icons.oil_barrel, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'OlejTo',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Dbaj o serwis bez stresu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Wszystkie auta i przypomnienia w jednym miejscu.',
                    style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _MetricChip(label: 'Auta', value: '${_vehicles.length}'),
                      const SizedBox(width: 8),
                      _MetricChip(label: 'Wkrotce', value: '$soonCount'),
                      const SizedBox(width: 8),
                      _MetricChip(label: 'Pilne', value: '$urgentCount'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Twoje auta',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text('Zobacz wszystko')),
              ],
            ),
            const SizedBox(height: 8),
            if (_vehicles.isEmpty)
              _EmptyVehiclesState(onAddPressed: _openAddVehicleForm)
            else
              for (final vehicle in _vehicles) ...[
                _VehicleCard(
                  vehicle: vehicle,
                  statusColor: _statusColor(vehicle.status),
                  statusLabel: _statusLabel(vehicle.status),
                ),
                const SizedBox(height: 12),
              ],
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Nadchodzace przypomnienia',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in reminders) ...[
              _ReminderTile(
                item: item,
                statusColor: _statusColor(item.status),
                statusLabel: _statusLabel(item.status),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddVehicleForm,
        backgroundColor: const Color(0xFF1F7A58),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Dodaj auto'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Historia'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Ustawienia'),
        ],
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
                Text(
                  'Uzupelnij dane pojazdu',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'To tylko chwila. Potem dostaniesz przypomnienia o serwisie.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nazwa auta (np. BMW E90)',
                    border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    labelText: 'Tablica rejestracyjna',
                    border: OutlineInputBorder(),
                  ),
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
                  decoration: const InputDecoration(
                    labelText: 'Aktualny przebieg (km)',
                    border: OutlineInputBorder(),
                  ),
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
                  decoration: const InputDecoration(
                    labelText: 'Ile km do wymiany oleju',
                    border: OutlineInputBorder(),
                  ),
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
          const Icon(Icons.directions_car_outlined, size: 28),
          const SizedBox(height: 8),
          Text(
            'Nie masz jeszcze pojazdu',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Dodaj pierwsze auto i zacznij monitorowac terminy wymiany.',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: const Text('Dodaj pierwsze auto'),
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0x24FFFFFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              style: const TextStyle(color: Color(0xD9FFFFFF), fontSize: 12),
            ),
          ],
        ),
      ),
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            SizedBox(
              width: 62,
              height: 62,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: vehicle.oilHealth,
                    strokeWidth: 7,
                    backgroundColor: const Color(0xFFEDF2EE),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                  Text(
                    '${(vehicle.oilHealth * 100).round()}%',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
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
                  const SizedBox(height: 4),
                  Text(
                    '${vehicle.plate}  •  ${vehicle.currentMileage} km',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Do wymiany: ${vehicle.kilometersLeft} km',
                    style: const TextStyle(fontWeight: FontWeight.w600),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: statusColor.withValues(alpha: 0.12),
            child: Icon(item.icon, color: statusColor, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
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
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
