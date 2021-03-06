import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tec_solutions/models/admin_orders_manager.dart';
import 'package:tec_solutions/models/admin_users_manager.dart';
import 'package:tec_solutions/models/cart_manager.dart';
import 'package:tec_solutions/models/home_manager.dart';
import 'package:tec_solutions/models/order.dart';
import 'package:tec_solutions/models/orders_manager.dart';
import 'package:tec_solutions/models/product.dart';
import 'package:tec_solutions/models/product_manager.dart';
import 'package:tec_solutions/models/user.dart';
import 'package:tec_solutions/models/user_manager.dart';
import 'package:tec_solutions/screens/base/address/address_screen.dart';
import 'package:tec_solutions/screens/base/base_screen.dart';
import 'package:tec_solutions/screens/base/cart/cart_screen.dart';
import 'package:tec_solutions/screens/base/checkout/checkout_screen.dart';
import 'package:tec_solutions/screens/base/confirmation/confirmation_screen.dart';
import 'package:tec_solutions/screens/base/edit_product/edit_product_screen.dart';
import 'package:tec_solutions/screens/base/login/login_screen.dart';
import 'package:tec_solutions/screens/base/product/product_screen.dart';
import 'package:tec_solutions/screens/base/select_product/select_product_screen.dart';
import 'package:tec_solutions/screens/base/signup/signup_screen.dart';
import 'package:tec_solutions/services/cepaberto_services.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager..updateUser(userManager),
        ),

        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
          ordersManager..updateUser(userManager.user),
        ),

        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) =>
          adminOrdersManager..updateAdmin(
            adminEnabled: userManager.adminEnabled
          ),
        )

      ],
      child: MaterialApp(
        title: 'TEC SOLUTIONS SA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0
          ),

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
       onGenerateRoute: (settings){
          switch(settings.name){
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen()
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScrenn()
              );
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(
                    settings.arguments as Product
                  )
              );
            case('/cart'):
              return MaterialPageRoute(
                builder: (_) => CartScreen(),
                settings: settings
              );
            case('/address'):
              return MaterialPageRoute(
                  builder: (_) => AddressScreen()
              );
            case('/checkout'):
              return MaterialPageRoute(
                builder: (_) => CheckoutScreen()
              );
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(
                  settings.arguments as Product
                )
              );
            case '/select_product':
              return MaterialPageRoute(
                builder: (_) => SelectProductScreen()
              );
            case '/confirmation':
              return MaterialPageRoute(
                  builder: (_) => ConfirmationScreen(
                    settings.arguments as Order
                  )
              );
            case '/':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
                settings: settings
              );
          }
       },
      ),
    );
  }
}
