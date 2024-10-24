class User {
  final int? id;
  final String nome;
  final String sobrenome;
  final String email;
  final String senha;
  final String tipo_usuario;

  User({
    required this.id,
    required this.nome,
    required this.sobrenome,
    required this.email,
    required this.senha,
    required this.tipo_usuario,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id_usuario'],
      nome: json['nome'],
      sobrenome: json['sobrenome'],
      email: json['email'],
      senha: json['senha'],
      tipo_usuario: json['tipo_usuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'senha': senha,
      'tipo_usuario': tipo_usuario,
    };
  }
}
