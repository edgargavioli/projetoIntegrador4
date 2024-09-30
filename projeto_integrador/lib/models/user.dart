class User {
  final String name;
  final String email;
  final String profile;
  final String tipo_user;
  final int id_user;

  User({
    required this.name,
    required this.email,
    required this.profile,
    required this.tipo_user,
    required this.id_user,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      profile: json['profile'],
      tipo_user: json['tipo_user'],
      id_user: json['id_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile': profile,
      'tipo_user': tipo_user,
      'id_user': id_user,
    };
  }
}
