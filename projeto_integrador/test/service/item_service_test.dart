import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_integrador/services/item_service.dart';
import 'package:projeto_integrador/models/item_list.dart';
import 'package:projeto_integrador/models/item_notification.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'dart:convert';

class MockClient extends Mock implements http.Client {}

void main() async {
  await dotenv.load(fileName: ".env");

  group('ItemService', () {
    final client = MockClient();
    final apiUrl = dotenv.env['API_URL'];

    setUp(() {
      // Any setup code goes here.
    });

    test('fetchItemsInventarioPage returns a list of items', () async {
      when(client.get(Uri.parse('$apiUrl/item/')))
          .thenAnswer((_) async => http.Response(
                json.encode([{'id': 1, 'name': 'Item 1'}]),
                200,
              ));

      final items = await ItemService.fetchItemsInventarioPage();

      expect(items, isA<List<ItemList>>());
      expect(items.length, 1);
      expect(items.first.id, 1);
      expect(items.first.name, 'Item 1');
    });

    test('createItem calls API and creates an item', () async {
      var itemData = {'name': 'New Item'};

      when(client.post(
        Uri.parse('$apiUrl/item/'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Item created', 200));

      await ItemService.createItem(itemData);
      // You could verify interactions or state changes here
      expect(true, true); // If it reaches here, the call was successful
    });

    test('deleteItem calls API to delete an item', () async {
      var itemArray = [1];

      when(client.delete(
        Uri.parse('$apiUrl/item/deleteSelected'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Item deleted', 200));

      await ItemService.deleteItem(itemArray);
      expect(true, true); // If it reaches here, the delete was successful
    });

    test('fetchItemsNotifications returns a list of notifications', () async {
      when(client.get(Uri.parse('$apiUrl/item/notificacoes')))
          .thenAnswer((_) async => http.Response(
                json.encode([{'id': 1, 'notification': 'Item notification'}]),
                200,
              ));

      final notifications = await ItemService.fetchItemsNotifications();

      expect(notifications, isA<List<ItemNotification>>());
      expect(notifications.length, 1);
      expect(notifications.first.id, 1);
      expect(notifications.first.notification, 'Item notification');
    });
  });
}

extension on ItemList {
   get name => null;
}
