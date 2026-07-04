import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/developer.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Web Fallback Mock Developers List
  static final List<Developer> _mockDevelopers = [
    const Developer(
      id: 1,
      name: 'Samir Haziel Mas',
      role: 'Mobile Lead',
      experienceYears: 3,
      skills: 'Flutter, Dart, SQLite',
      salary: 5800.0,
      bio: 'Especialista en arquitectura móvil limpia y UI reactiva.',
    ),
    const Developer(
      id: 2,
      name: 'Ada Lovelace',
      role: 'AI Engineer',
      experienceYears: 5,
      skills: 'Python, PyTorch, C++',
      salary: 9200.0,
      bio: 'Diseño e implementación de modelos de aprendizaje profundo.',
    ),
    const Developer(
      id: 3,
      name: 'Alan Turing',
      role: 'Backend Architect',
      experienceYears: 8,
      skills: 'Go, Rust, gRPC, PostgreSQL',
      salary: 9800.0,
      bio: 'Optimización de microservicios con alta concurrencia y baja latencia.',
    ),
    const Developer(
      id: 4,
      name: 'Grace Hopper',
      role: 'DevOps Manager',
      experienceYears: 7,
      skills: 'Kubernetes, Docker, AWS, Bash',
      salary: 8900.0,
      bio: 'Automatización de infraestructura como código y pipelines de CI/CD.',
    ),
    const Developer(
      id: 5,
      name: 'Linus Torvalds',
      role: 'Kernel Specialist',
      experienceYears: 12,
      skills: 'C, Assembly, Git, Linux',
      salary: 11000.0,
      bio: 'Líder de desarrollo de sistemas de archivos de alta fiabilidad.',
    ),
  ];
  static int _webIdCounter = 6;

  Future<Database?> get database async {
    if (kIsWeb) return null;
    if (_database != null) return _database!;
    _database = await _initDB('devstore.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE developers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        experienceYears INTEGER NOT NULL,
        skills TEXT NOT NULL,
        salary REAL NOT NULL,
        bio TEXT NOT NULL
      )
    ''');

    for (final dev in _mockDevelopers) {
      await db.insert('developers', dev.toMap());
    }
  }

  // CREATE (Insert)
  Future<int> insertDeveloper(Developer dev) async {
    if (kIsWeb) {
      final newDev = dev.copyWith(id: _webIdCounter++);
      _mockDevelopers.insert(0, newDev);
      return newDev.id!;
    }
    final db = await instance.database;
    return await db!.insert('developers', dev.toMap());
  }

  // READ (All)
  Future<List<Developer>> getDevelopers() async {
    if (kIsWeb) {
      return List.from(_mockDevelopers);
    }
    final db = await instance.database;
    final result = await db!.query('developers', orderBy: 'id DESC');
    return result.map((json) => Developer.fromMap(json)).toList();
  }

  // READ (Single)
  Future<Developer?> getDeveloperById(int id) async {
    if (kIsWeb) {
      try {
        return _mockDevelopers.firstWhere((d) => d.id == id);
      } catch (_) {
        return null;
      }
    }
    final db = await instance.database;
    final maps = await db!.query(
      'developers',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Developer.fromMap(maps.first);
    }
    return null;
  }

  // UPDATE
  Future<int> updateDeveloper(Developer dev) async {
    if (kIsWeb) {
      final index = _mockDevelopers.indexWhere((d) => d.id == dev.id);
      if (index != -1) {
        _mockDevelopers[index] = dev;
        return 1;
      }
      return 0;
    }
    final db = await instance.database;
    return await db!.update(
      'developers',
      dev.toMap(),
      where: 'id = ?',
      whereArgs: [dev.id],
    );
  }

  // DELETE
  Future<int> deleteDeveloper(int id) async {
    if (kIsWeb) {
      final initialLength = _mockDevelopers.length;
      _mockDevelopers.removeWhere((d) => d.id == id);
      return initialLength - _mockDevelopers.length;
    }
    final db = await instance.database;
    return await db!.delete(
      'developers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    if (kIsWeb) return;
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
