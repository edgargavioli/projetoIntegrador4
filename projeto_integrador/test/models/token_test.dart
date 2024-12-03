import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_integrador/models/token.dart';

void main() {
  group('Token', () {
    late Token token;

    setUp(() {
      // Configuração antes de cada teste
      // Configurando o token para expirar em 10 segundos a partir de agora
      token = Token(token: 'abc123', expiration: DateTime.now().millisecondsSinceEpoch + 10000); // 10 segundos para expirar
    });

    test('fromJson deve criar uma instância de Token a partir de um mapa JSON', () {
      final json = {
        'token': 'abc123',
        'expiration': DateTime.now().millisecondsSinceEpoch + 10000,
      };
      final newToken = Token.fromJson(json);

      expect(newToken.token, 'abc123');
      expect(newToken.expiration, json['expiration']);
    });

    test('toJson deve converter uma instância de Token para um mapa JSON', () {
      final json = token.toJson();

      expect(json['token'], token.token);
      expect(json['expiration'], token.expiration);
    });

    test('isExpired deve retornar falso se o token não expirou', () {
      // O token ainda não expirou
      expect(token.isExpired(), isFalse);
    });

    test('isExpired deve retornar verdadeiro se o token expirou', () async {
      // Espera 11 segundos para garantir que o token expire
      await Future.delayed(Duration(seconds: 11));
      expect(token.isExpired(), isTrue);
    });
  });
}
