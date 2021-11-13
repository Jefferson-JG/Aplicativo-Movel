import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_solutions/common/drawer/custon_drawer.dart';
import 'package:tec_solutions/common/drawer/empty_card.dart';
import 'package:tec_solutions/common/drawer/login_card.dart';
import 'package:tec_solutions/common/drawer/order/order_tile.dart';
import 'package:tec_solutions/models/orders_manager.dart';


class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __){
          if(ordersManager.user == null){
            return LoginCard();
          }
          if(ordersManager.orders.isEmpty){
            return EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index){
                return OrderTile(
                  ordersManager.orders.reversed.toList()[index]
                );
              }
          );
        },
      ),
    );
  }
}
