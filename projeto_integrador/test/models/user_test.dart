import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/user.dart'; // Altere para o caminho correto do seu arquivo

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

    test('fromJson should create a User instance from a JSON map', () {
      final json = {
        'id_usuario': 1,
        'nome': 'João',
        'sobrenome': 'Silva',
        'email': 'joao.silva@example.com',
        'senha': 'senha123',
        'tipo_usuario': 'admin',
      };
      final newUser = User.fromJson(json);

      expect(newUser.id, 1);
      expect(newUser.nome, 'João');
      expect(newUser.sobrenome, 'Silva');
      expect(newUser.email, 'joao.silva@example.com');
      expect(newUser.senha, 'senha123');
      expect(newUser.tipo_usuario, 'admin');
    });

    test('toJson should convert a User instance to a JSON map', () {
      final json = user.toJson();

      expect(json['nome'], user.nome);
      expect(json['sobrenome'], user.sobrenome);
      expect(json['email'], user.email);
      expect(json['senha'], user.senha);
      expect(json['tipo_usuario'], user.tipo_usuario);
    });

    test('toJson should not include the id field', () {
      final json = user.toJson();

      // O campo 'id' não é convertido para o JSON
      expect(json.containsKey('id'), isFalse);
    });
  });
}
