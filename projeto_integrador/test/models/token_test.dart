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

    test('fromJson should create a Token instance from a JSON map', () {
      final json = {
        'token': 'abc123',
        'expiration': DateTime.now().millisecondsSinceEpoch + 10000,
      };
      final newToken = Token.fromJson(json);

      expect(newToken.token, 'abc123');
      expect(newToken.expiration, json['expiration']);
    });

    test('toJson should convert a Token instance to a JSON map', () {
      final json = token.toJson();

      expect(json['token'], token.token);
      expect(json['expiration'], token.expiration);
    });

    test('isExpired should return false if the token has not expired', () {
      // O token ainda não expirou
      expect(token.isExpired(), isFalse);
    });

    test('isExpired should return true if the token has expired', () async {
      // Espera 11 segundos para garantir que o token expire
      await Future.delayed(Duration(seconds: 11));
      expect(token.isExpired(), isTrue);
    });
  });
}
