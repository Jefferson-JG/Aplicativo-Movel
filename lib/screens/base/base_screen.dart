import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_solutions/common/drawer/custon_drawer.dart';
import 'package:tec_solutions/models/page_manager.dart';
import 'package:tec_solutions/models/user_manager.dart';
import 'package:tec_solutions/screens/base/admin_users/admin_users_screen.dart';
import 'package:tec_solutions/screens/base/home/home_screen.dart';
import 'package:tec_solutions/screens/base/login/login_screen.dart';
import 'package:tec_solutions/screens/base/orders/orders_screen.dart';
import 'package:tec_solutions/screens/base/products/products_screen.dart';


class BaseScreen extends StatefulWidget {

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Home4'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                  AdminUsersScreen(),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      title: const Text('Pedidos'),
                    ),
                  ),
                ]
            ],
          );
        },
      ),
    );
  }
}
