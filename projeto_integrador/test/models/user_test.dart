import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/user.dart';


void main() {
  group('User', () {
    late User user;

    setUp(() {
      // Configuração antes de cada teste
      user = User(
        id: 1,
        nome: 'João',
        sobrenome: 'Silva',
        email: 'joao.silva@example.com',
        senha: 'senha123',
        tipo_usuario: 'admin',
      );
    });

    test('fromJson deve criar uma instância de User a partir de um mapa JSON', () {
      final json = {
        'id_usuario': 1,
        'nome': 'João',
        'sobrenome': 'Silva',
        'email': 'joao.silva@example.com',
        'senha': 'senha123',
        'tipo_usuario': 'admin',
      };
      final newUser = User.fromJson(json);

      expect(newUser.id, json['id_usuario']);
      expect(newUser.nome, json['nome']);
      expect(newUser.sobrenome, json['sobrenome']);
      expect(newUser.email, json['email']);
      expect(newUser.senha, json['senha']);
      expect(newUser.tipo_usuario, json['tipo_usuario']);
    });

    test('toJson deve converter uma instância de User para um mapa JSON', () {
      final json = user.toJson();

      expect(json['nome'], user.nome);
      expect(json['sobrenome'], user.sobrenome);
      expect(json['email'], user.email);
      expect(json['senha'], user.senha);
      expect(json['tipo_usuario'], user.tipo_usuario);
      expect(json.containsKey('id_usuario'), isFalse); // Verifica se 'id_usuario' não está presente
    });
  });
}
