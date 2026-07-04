class Developer {
  final int? id;
  final String name;
  final String role;
  final int experienceYears;
  final String skills;
  final double salary;
  final String bio;

  const Developer({
    this.id,
    required this.name,
    required this.role,
    required this.experienceYears,
    required this.skills,
    required this.salary,
    required this.bio,
  });

  Developer copyWith({
    int? id,
    String? name,
    String? role,
    int? experienceYears,
    String? skills,
    double? salary,
    String? bio,
  }) {
    return Developer(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      experienceYears: experienceYears ?? this.experienceYears,
      skills: skills ?? this.skills,
      salary: salary ?? this.salary,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'role': role,
      'experienceYears': experienceYears,
      'skills': skills,
      'salary': salary,
      'bio': bio,
    };
  }

  factory Developer.fromMap(Map<String, dynamic> map) {
    return Developer(
      id: map['id'] as int?,
      name: map['name'] as String,
      role: map['role'] as String,
      experienceYears: map['experienceYears'] as int,
      skills: map['skills'] as String,
      salary: (map['salary'] as num).toDouble(),
      bio: map['bio'] as String,
    );
  }
}
