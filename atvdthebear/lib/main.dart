import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/pedido_viewmodel.dart';
import 'pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => PedidoViewModel()),
      ],
      child: const MaterialApp(
        title: 'The Bear',
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    ),
  );
}
