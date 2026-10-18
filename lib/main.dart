import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/viagem_provider.dart';
import 'pages/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ViagemProvider(),
      child: const SmHotelApp(),
    ),
  );
}

class SmHotelApp extends StatelessWidget {
  const SmHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'S&M Hotel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
