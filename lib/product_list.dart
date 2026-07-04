import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'edit_product.dart';
import 'models/developer.dart';
import 'shared_styles.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Developer> _allDevelopers = [];
  List<Developer> _filteredDevelopers = [];
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDevelopers();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDevelopers() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final developers = await DatabaseHelper.instance.getDevelopers();
      if (!mounted) return;
      setState(() {
        _allDevelopers = developers;
        _filterDevelopers();
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    _filterDevelopers();
  }

  void _filterDevelopers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredDevelopers = List.from(_allDevelopers);
      } else {
        _filteredDevelopers = _allDevelopers.where((dev) {
          final nameMatch = dev.name.toLowerCase().contains(query);
          final roleMatch = dev.role.toLowerCase().contains(query);
          final skillsMatch = dev.skills.toLowerCase().contains(query);
          final bioMatch = dev.bio.toLowerCase().contains(query);
          return nameMatch || roleMatch || skillsMatch || bioMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Directorio de Ingeniería',
                    style: TextStyle(
                      color: GoogleColors.grey900,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Base de datos activa de desarrolladores de software',
                    style: TextStyle(color: GoogleColors.grey700, fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.sync, color: GoogleColors.blue),
              onPressed: _loadDevelopers,
              tooltip: 'Sincronizar directorio',
            ),
          ],
        ),
        const SizedBox(height: 20),
        SearchBar(
          controller: _searchController,
          hintText: 'Buscar por nombre, rol, lenguajes...',
          elevation: WidgetStateProperty.all(0),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          side: WidgetStateProperty.all(const BorderSide(color: GoogleColors.grey200)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 16)),
          leading: const Icon(Icons.search, color: GoogleColors.grey700),
          trailing: _searchController.text.isNotEmpty
              ? [
                  IconButton(
                    icon: const Icon(Icons.clear, color: GoogleColors.grey700),
                    onPressed: () => _searchController.clear(),
                  )
                ]
              : null,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 20),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 48.0),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(GoogleColors.blue),
                strokeWidth: 3,
              ),
            ),
          )
        else if (_filteredDevelopers.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 48.0),
            child: Center(
              child: Text(
                'No se encontraron ingenieros registrados.',
                style: TextStyle(
                  color: GoogleColors.grey700,
                  fontSize: 14,
                ),
              ),
            ),
          )
        else
          ..._filteredDevelopers.map((dev) => _DeveloperTile(
                developer: dev,
                onTap: () async {
                  final result = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProductPage(product: dev), // Using the standard route name to avoid major structural changes
                    ),
                  );
                  if (result == true) {
                    _loadDevelopers();
                  }
                },
              )),
      ],
    );
  }
}

class _DeveloperTile extends StatelessWidget {
  const _DeveloperTile({required this.developer, required this.onTap});

  final Developer developer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color roleColor = GoogleColors.blue;
    switch (developer.role) {
      case 'Mobile Lead':
      case 'Mobile Developer':
        roleColor = GoogleColors.blue;
        break;
      case 'AI Engineer':
        roleColor = Colors.purple;
        break;
      case 'Backend Architect':
      case 'Backend Developer':
        roleColor = GoogleColors.green;
        break;
      case 'DevOps Manager':
      case 'DevOps Engineer':
        roleColor = GoogleColors.yellow;
        break;
      default:
        roleColor = GoogleColors.red;
    }

    return GoogleCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: roleColor.withOpacity(0.1),
            child: Text(
              developer.name.isNotEmpty ? developer.name[0].toUpperCase() : 'D',
              style: TextStyle(
                color: roleColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  developer.name,
                  style: const TextStyle(
                    color: GoogleColors.grey900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: roleColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        developer.role,
                        style: TextStyle(
                          color: roleColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${developer.experienceYears} años exp.',
                      style: const TextStyle(color: GoogleColors.grey700, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Techs: ${developer.skills}',
                  style: const TextStyle(
                    color: GoogleColors.grey700,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'S/ ${developer.salary.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: GoogleColors.grey900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tarifa mensual',
                style: TextStyle(color: GoogleColors.grey700, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
