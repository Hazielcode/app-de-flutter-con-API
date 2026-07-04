import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'models/developer.dart';
import 'shared_styles.dart';

class EditProductPage extends StatefulWidget {
  final Developer product; // Keeping the name 'product' to minimize routing logic refactoring

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  static const _roles = [
    'Mobile Lead',
    'Mobile Developer',
    'AI Engineer',
    'Backend Architect',
    'Backend Developer',
    'DevOps Manager',
    'DevOps Engineer',
  ];

  late TextEditingController _nameController;
  late TextEditingController _skillsController;
  late TextEditingController _salaryController;
  late TextEditingController _experienceController;
  late TextEditingController _bioController;

  late String _selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _skillsController = TextEditingController(text: widget.product.skills);
    _salaryController = TextEditingController(text: widget.product.salary.toString());
    _experienceController = TextEditingController(text: widget.product.experienceYears.toString());
    _bioController = TextEditingController(text: widget.product.bio);

    _selectedRole = widget.product.role;
    if (!_roles.contains(_selectedRole)) {
      _selectedRole = _roles[1];
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skillsController.dispose();
    _salaryController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _showDialog(String title, String content, {VoidCallback? onOk}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onOk != null) onOk();
            },
            child: const Text('OK', style: TextStyle(color: GoogleColors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _updateDeveloper() async {
    final name = _nameController.text.trim();
    final skills = _skillsController.text.trim();
    final salaryStr = _salaryController.text.trim();
    final expStr = _experienceController.text.trim();
    final bio = _bioController.text.trim();

    if (name.isEmpty || skills.isEmpty || salaryStr.isEmpty || expStr.isEmpty) {
      _showDialog('Campos incompletos', 'Por favor, complete todos los campos de texto requeridos.');
      return;
    }

    final salary = double.tryParse(salaryStr);
    if (salary == null || salary <= 0) {
      _showDialog('Salario incorrecto', 'Por favor, ingrese un número decimal positivo para el salario.');
      return;
    }

    final exp = int.tryParse(expStr);
    if (exp == null || exp < 0) {
      _showDialog('Años incorrectos', 'Por favor, ingrese un número entero de años de experiencia.');
      return;
    }

    final updatedDev = widget.product.copyWith(
      name: name,
      role: _selectedRole,
      experienceYears: exp,
      skills: skills,
      salary: salary,
      bio: bio.isEmpty ? 'Sin descripción profesional.' : bio,
    );

    try {
      await DatabaseHelper.instance.updateDeveloper(updatedDev);
      _showDialog(
        'Actualizado',
        'El perfil técnico se ha modificado exitosamente.',
        onOk: () => Navigator.pop(context, true),
      );
    } catch (e) {
      _showDialog('Error al actualizar', 'Hubo un error inesperado al modificar el perfil: $e');
    }
  }

  void _confirmDeleteDeveloper() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text('¿Está seguro de que desea retirar a "${widget.product.name}" del directorio activo?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: GoogleColors.grey700)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteDeveloper();
            },
            child: const Text('Retirar', style: TextStyle(color: GoogleColors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _deleteDeveloper() async {
    try {
      await DatabaseHelper.instance.deleteDeveloper(widget.product.id!);
      _showDialog(
        'Eliminado',
        'El programador ha sido retirado del directorio activo.',
        onOk: () => Navigator.pop(context, true),
      );
    } catch (e) {
      _showDialog('Error al eliminar', 'Hubo un error inesperado al retirar del directorio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GoogleColors.grey100,
      appBar: AppBar(
        title: const Text(
          'Modificar Perfil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: GoogleColors.grey200, height: 1.0),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Editar Perfil Técnico',
              style: TextStyle(
                color: GoogleColors.grey900,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Actualice la información profesional o retire el perfil de la red.',
              style: TextStyle(color: GoogleColors.grey700, fontSize: 13),
            ),
            const SizedBox(height: 24),
            GoogleTextField(
              placeholder: 'Nombre del Ingeniero',
              icon: Icons.badge_outlined,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                labelText: 'Rol / Especialidad',
                labelStyle: const TextStyle(color: GoogleColors.grey700),
                prefixIcon: const Icon(Icons.code, color: GoogleColors.blue),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: GoogleColors.grey200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: GoogleColors.grey200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: GoogleColors.blue, width: 2),
                ),
              ),
              items: _roles
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role, style: const TextStyle(color: GoogleColors.grey900)),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedRole = val;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            GoogleTextField(
              placeholder: 'Años de Experiencia',
              icon: Icons.timeline,
              keyboardType: TextInputType.number,
              controller: _experienceController,
            ),
            const SizedBox(height: 16),
            GoogleTextField(
              placeholder: 'Tecnologías y Skills',
              icon: Icons.computer_outlined,
              controller: _skillsController,
            ),
            const SizedBox(height: 16),
            GoogleTextField(
              placeholder: 'Tarifa Mensual (S/)',
              icon: Icons.payments_outlined,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: _salaryController,
            ),
            const SizedBox(height: 16),
            GoogleTextField(
              placeholder: 'Bio y Ficha de Proyectos',
              icon: Icons.speaker_notes_outlined,
              maxLines: 3,
              controller: _bioController,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: GoogleButton(
                text: 'Actualizar Datos',
                icon: Icons.done,
                onPressed: _updateDeveloper,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: GoogleButton(
                text: 'Retirar Ingeniero',
                icon: Icons.delete_outline,
                color: GoogleColors.red,
                outline: true,
                onPressed: _confirmDeleteDeveloper,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
