import 'package:flutter/material.dart';
import 'shared_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController(text: 'Samir Haziel');
  final _lastNameController = TextEditingController(text: 'Mas');
  final _descController = TextEditingController(
    text: 'Ingeniero de Software y Administrador de Red. Líder técnico del equipo de desarrollo.',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perfil Guardado'),
        content: const Text('Los datos de tu perfil corporativo se han actualizado correctamente.'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar', style: TextStyle(color: GoogleColors.blue, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 54,
                backgroundColor: GoogleColors.blue.withOpacity(0.1),
                child: const Icon(
                  Icons.terminal,
                  size: 58,
                  color: GoogleColors.blue,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: GoogleColors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Center(
          child: Text(
            'Perfil de Ingeniero Administrador',
            style: TextStyle(
              color: GoogleColors.grey900,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GoogleTextField(
          placeholder: 'Nombre',
          icon: Icons.person_outline,
          controller: _nameController,
        ),
        const SizedBox(height: 16),
        GoogleTextField(
          placeholder: 'Apellidos',
          icon: Icons.people_outline,
          controller: _lastNameController,
        ),
        const SizedBox(height: 16),
        GoogleTextField(
          placeholder: 'Resumen Profesional / Bio',
          icon: Icons.integration_instructions_outlined,
          maxLines: 3,
          controller: _descController,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: GoogleButton(
            text: 'Guardar Perfil',
            icon: Icons.check_circle_outline,
            onPressed: _showSuccessDialog,
          ),
        ),
      ],
    );
  }
}
