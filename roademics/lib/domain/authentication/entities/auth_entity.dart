class AuthUser {
  final String id;
  final String username;
  final String password;
  final List<Role> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuthUser({
    required this.id,
    required this.username,
    required this.password,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['_id']['\$oid'],
      username: json['username'],
      password: json['password'],
      roles:
          (json['roles'] as List).map((role) => Role.fromJson(role)).toList(),
      createdAt: DateTime.parse(json['createdAt']['\$date']),
      updatedAt: DateTime.parse(json['updatedAt']['\$date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id},
      'username': username,
      'password': password,
      'roles': roles.map((role) => role.toJson()).toList(),
      'createdAt': {'\$date': createdAt.toIso8601String()},
      'updatedAt': {'\$date': updatedAt.toIso8601String()},
    };
  }
}

class Role {
  final String id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['_id']['\$oid'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': {'\$oid': id},
      'name': name,
    };
  }
}
