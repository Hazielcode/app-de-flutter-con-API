import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/developer.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  final _supabase = Supabase.instance.client;

  DatabaseHelper._init();

  // CREATE (Insert) a la API de Supabase
  Future<int> insertDeveloper(Developer dev) async {
    // Como id es serial en Postgres, podemos omitirlo si es null
    final data = dev.toMap();
    if (data['id'] == null) {
      data.remove('id');
    }

    final response = await _supabase
        .from('developers')
        .insert(data)
        .select('id')
        .single();
    return response['id'] as int;
  }

  // READ (All) desde la API de Supabase
  Future<List<Developer>> getDevelopers() async {
    final response = await _supabase
        .from('developers')
        .select()
        .order('id', ascending: false);
    
    // Mapeamos el JSON que nos da la API a nuestra clase Developer
    return response.map((json) => Developer.fromMap(json)).toList();
  }

  // READ (Single) desde la API de Supabase
  Future<Developer?> getDeveloperById(int id) async {
    final response = await _supabase
        .from('developers')
        .select()
        .eq('id', id)
        .maybeSingle();
    
    if (response != null) {
      return Developer.fromMap(response);
    }
    return null;
  }

  // UPDATE (PUT/PATCH a la API)
  Future<int> updateDeveloper(Developer dev) async {
    await _supabase
        .from('developers')
        .update(dev.toMap())
        .eq('id', dev.id!);
    return 1;
  }

  // DELETE a la API
  Future<int> deleteDeveloper(int id) async {
    await _supabase
        .from('developers')
        .delete()
        .eq('id', id);
    return 1;
  }

  // Mantengo este método vacío para no romper la app en lugares
  // donde se llame a close() pensando que era SQLite.
  Future<void> close() async {
    // Supabase no necesita cerrar la conexión manualmente
  }
}
