import 'package:flutter/material.dart';
import 'login.dart';
import 'product_list.dart';
import 'profile.dart';
import 'register_product.dart';
import 'shared_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      MenuTab(onTabSelect: (index) {
        setState(() {
          _currentIndex = index;
        });
      }),
      const RegisterProductPage(),
      const ProductListPage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GoogleColors.grey100,
      appBar: AppBar(
        title: const Text(
          'DevPortal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: GoogleColors.grey200, height: 1.0),
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión corporativa',
            icon: const Icon(Icons.power_settings_new, color: GoogleColors.red),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: GoogleColors.grey200)),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          indicatorColor: GoogleColors.blue.withOpacity(0.12),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard, color: GoogleColors.blue),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_add_outlined),
              selectedIcon: Icon(Icons.person_add, color: GoogleColors.blue),
              label: 'Registrar',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people, color: GoogleColors.blue),
              label: 'Directorio',
            ),
            NavigationDestination(
              icon: Icon(Icons.admin_panel_settings_outlined),
              selectedIcon: Icon(Icons.admin_panel_settings, color: GoogleColors.blue),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTab extends StatelessWidget {
  const MenuTab({required this.onTabSelect, super.key});

  final Function(int) onTabSelect;

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem(
        'Añadir Ingeniero',
        'Registrar nuevo perfil técnico en la base de datos de ingeniería',
        Icons.person_add_alt_1_outlined,
        GoogleColors.green,
        onTap: () => onTabSelect(1),
      ),
      _MenuItem(
        'Directorio Activo',
        'Administrar perfiles de desarrollo, skills y salarios en SQLite',
        Icons.terminal_outlined,
        GoogleColors.blue,
        onTap: () => onTabSelect(2),
      ),
      _MenuItem(
        'Ficha de Administrador',
        'Configuraciones y datos profesionales del líder de proyecto',
        Icons.fingerprint_outlined,
        GoogleColors.yellow,
        onTap: () => onTabSelect(3),
      ),
      _MenuItem(
        'Salir de la Red',
        'Cerrar sesión corporativa del portal',
        Icons.logout,
        GoogleColors.red,
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        },
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // Google styled clean header banner
        Card(
          color: GoogleColors.blue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Google Software Engineering',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Gestión activa del equipo de desarrollo de software. Persistencia de datos integrada con SQLite y sincronización de red corporativa.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Accesos Directos',
          style: TextStyle(
            color: GoogleColors.grey900,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map((item) => GoogleCard(
              onTap: item.onTap,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(item.icon, color: item.color, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: GoogleColors.grey900,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: GoogleColors.grey700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: GoogleColors.grey700, size: 14),
                ],
              ),
            )),
      ],
    );
  }
}

class _MenuItem {
  const _MenuItem(this.title, this.subtitle, this.icon, this.color, {required this.onTap});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}
