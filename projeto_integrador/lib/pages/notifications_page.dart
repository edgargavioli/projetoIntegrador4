import 'package:flutter/material.dart';
import 'package:projeto_integrador/components/custom_notification.dart';
import 'package:projeto_integrador/models/item_notification.dart';
import 'package:projeto_integrador/services/item_service.dart';

class NotificationItem {
  final String descricao;
  final int diasRestantes;

  NotificationItem({
    required this.descricao,
    required this.diasRestantes,
  });
}

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
    ItemService.fetchItemsNotificationsPage().then((fetchedItems) {
      setState(() {
        itens = fetchedItems;
      });
    }).catchError((error) {
      print("Erro ao buscar itens: $error");
    });
  }

  List<NotificationItem> verificarNotificacoes() {
    List<NotificationItem> notificacoes = [];
    DateTime agora = DateTime.now();

    for (var item in itens) {
      DateTime? dataProximaManutencao = item.proximaManutencao;
      if (dataProximaManutencao != null) {
        int diasRestantes = dataProximaManutencao.difference(agora).inDays;
        if ([30, 15, 7, 1].contains(diasRestantes)) {
          notificacoes.add(NotificationItem(
            descricao: item.descricao,
            diasRestantes: diasRestantes,
          ));
        }
      }
    }
    return notificacoes;
  }

  @override
  Widget build(BuildContext context) {
    List<NotificationItem> notificacoes = verificarNotificacoes();

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
                itemCount: notificacoes.length,
                itemBuilder: (context, index) {
                  final notificacao = notificacoes[index];
                  return CustomNotification(
                    title:
                        'Manutenção do Item: ${notificacao.descricao}', 
                    message:
                        '${notificacao.diasRestantes} dias restantes para a manutenção',
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
