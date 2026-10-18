import 'package:flutter/material.dart';

import '../models/destinos_lista.dart';
import '../widgets/destino_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('S&M Hotel'), centerTitle: true),
      body: ListView.builder(
        itemCount: destinos.length,
        itemBuilder: (context, index) {
          final destino = destinos[index];

          return DestinoCard(destino: destino);
        },
      ),
    );
  }
}
