import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'models/developer.dart';
import 'shared_styles.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  static const _roles = [
    'Mobile Lead',
    'Mobile Developer',
    'AI Engineer',
    'Backend Architect',
    'Backend Developer',
    'DevOps Manager',
    'DevOps Engineer',
  ];

  final _nameController = TextEditingController();
  final _skillsController = TextEditingController();
  final _salaryController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();

  String _selectedRole = _roles[1]; // Default to 'Mobile Developer'

  @override
  void dispose() {
    _nameController.dispose();
    _skillsController.dispose();
    _salaryController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: GoogleColors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _saveDeveloper() async {
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

    final newDev = Developer(
      name: name,
      role: _selectedRole,
      experienceYears: exp,
      skills: skills,
      salary: salary,
      bio: bio.isEmpty ? 'Sin descripción profesional.' : bio,
    );

    try {
      await DatabaseHelper.instance.insertDeveloper(newDev);

      // Clear controllers
      _nameController.clear();
      _skillsController.clear();
      _salaryController.clear();
      _experienceController.clear();
      _bioController.clear();
      setState(() {
        _selectedRole = _roles[1];
      });

      _showDialog('Éxito', 'El ingeniero ha sido registrado correctamente en la red corporativa.');
    } catch (e) {
      _showDialog('Error al guardar', 'Hubo un error inesperado al registrar el programador: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text(
          'Registrar Ingeniero',
          style: TextStyle(
            color: GoogleColors.grey900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Añada un nuevo perfil de desarrollo al directorio corporativo.',
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
          placeholder: 'Tecnologías y Skills (ej: Flutter, Go, Rust)',
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
            text: 'Guardar Perfil',
            icon: Icons.save_outlined,
            onPressed: _saveDeveloper,
          ),
        ),
      ],
    );
  }
}
