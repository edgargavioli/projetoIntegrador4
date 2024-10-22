import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_notification.dart';
import 'package:projeto_integrador/main.dart';
import 'package:projeto_integrador/models/item_notification.dart';
import 'package:projeto_integrador/services/item_service.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<ItemNotification> itens = [];

  @override
  void initState() {
    super.initState();
    carregarNotificacoes();
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void carregarNotificacoes() async {
    try {
      List<ItemNotification> fetchedItems =
          await ItemService.fetchItemsNotifications();

      if (fetchedItems.length > itens.length) {
        await showNotification(
          'Novos alertas de manutenção',
          'Você possui novos alertas de manutenção de itens',
        );
      }

      fetchedItems.sort((a, b) {
        if (a.proxima_qualificacao == null) return 1;
        if (b.proxima_qualificacao == null) return -1;
        return a.proxima_qualificacao!.compareTo(b.proxima_qualificacao!);
      });

      setState(() {
        itens = fetchedItems;
      });
    } catch (error) {
      print("Erro ao carregar notificações: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Text(
              "Avisos",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 36,
                  fontWeight: FontWeight.w600),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xFFCAC4D0),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: itens.length,
                itemBuilder: (context, index) {
                  final notificacao = itens[index];
                  String formattedDate = '';
                  String diasRestantes = '';

                  if (notificacao.proxima_qualificacao != null) {
                    DateTime proximaData =
                        notificacao.proxima_qualificacao!.toLocal();
                    formattedDate =
                        DateFormat('dd/MM/yyyy').format(proximaData);

                    final hoje = DateTime.now();
                    if (formattedDate ==
                        DateFormat('dd/MM/yyyy').format(hoje)) {
                      diasRestantes = 'Hoje';
                    } else {
                      final diferencaDias =
                          (proximaData.difference(hoje).inDays) + 1;
                      if (diferencaDias == 1) {
                        diasRestantes = '1 dia';
                      } else if (diferencaDias == 0) {
                        diasRestantes = 'Ontem';
                      } else {
                        diasRestantes = diferencaDias >= 0
                            ? '$diferencaDias dias'
                            : 'Vencida';
                      }
                    }
                  }

                  return CustomNotification(
                    title: 'Manutenção do Item: ${notificacao.descricao}',
                    message: notificacao.proxima_qualificacao != null
                        ? 'Agendada para $formattedDate ($diasRestantes)'
                        : 'Data não definida',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
