import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/base/base_screen.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        ProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => cartManager!..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        title: 'Loja de Bazar do Alfarr',
        // remove o banner de debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        // 'settings' - recebe os argumentos
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginSreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product,
                ),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => const CartScreen(),
              );
            case '/base':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}
