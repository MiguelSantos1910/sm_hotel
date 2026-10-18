import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destino.dart';
import '../models/viagem_provider.dart';
import '../pages/checkout_page.dart';

class DestinoCard extends StatelessWidget {
  final Destino destino;

  const DestinoCard({super.key, required this.destino});

  String formatarReais(num valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final viagem = context.watch<ViagemProvider>();

    final diarias = viagem.diariasDe(destino);
    final pessoas = viagem.pessoasDe(destino);
    final total = viagem.totalDe(destino);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              destino.imagem,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blueGrey.shade100,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported, size: 48),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destino.nome,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),

                Text('Diária: ${formatarReais(destino.valorDiaria)}'),
                Text(
                  'Valor por acompanhante: '
                  '${formatarReais(destino.valorPessoa)}',
                ),

                const Divider(height: 24),

                Text(
                  'Diárias selecionadas: $diarias',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => viagem.adicionarDiaria(destino),
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar diária'),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Acompanhantes: $pessoas',
                  style: const TextStyle(fontSize: 16),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => viagem.adicionarPessoa(destino),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Adicionar acompanhante'),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      viagem.calcularTotal(destino);

                      if (viagem.totalDe(destino) <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Adicione pelo menos uma diária ou '
                              'um acompanhante antes de continuar.',
                            ),
                          ),
                        );
                        return;
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CheckoutPage(destino: destino),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Calcular total'),
                  ),
                ),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => viagem.limpar(destino),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Limpar valores'),
                  ),
                ),

                const Divider(height: 24),

                Text(
                  'Último total calculado: ${formatarReais(total)}',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
