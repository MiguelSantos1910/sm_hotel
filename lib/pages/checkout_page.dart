import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/destino.dart';
import '../models/viagem_provider.dart';

class CheckoutPage extends StatelessWidget {
  final Destino destino;

  const CheckoutPage({super.key, required this.destino});

  String formatarReais(num valor) {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final viagem = context.watch<ViagemProvider>();

    final diarias = viagem.diariasDe(destino);
    final pessoas = viagem.pessoasDe(destino);
    final total = viagem.totalDe(destino);
    final usarPix = viagem.pagamentoPixDe(destino);
    final desconto = viagem.descontoPixDe(destino);
    final totalFinal = viagem.totalFinalDe(destino);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Resumo da viagem',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),

          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  destino.imagem,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.blueGrey.shade100,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported, size: 48),
                    );
                  },
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
                      const SizedBox(height: 12),
                      _LinhaResumo(titulo: 'Diárias', valor: '$diarias'),
                      _LinhaResumo(titulo: 'Acompanhantes', valor: '$pessoas'),
                      _LinhaResumo(
                        titulo: 'Valor por diária',
                        valor: formatarReais(destino.valorDiaria),
                      ),
                      _LinhaResumo(
                        titulo: 'Valor por acompanhante',
                        valor: formatarReais(destino.valorPessoa),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Forma de pagamento',
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 8),

          Card(
            child: Column(
              children: [
                RadioListTile<bool>(
                  value: true,
                  groupValue: usarPix,
                  onChanged: (valor) {
                    if (valor != null) {
                      viagem.selecionarPagamento(destino, valor);
                    }
                  },
                  secondary: const Icon(
                    Icons.account_balance,
                    color: Colors.green,
                  ),
                  title: const Text('PIX'),
                  subtitle: const Text('10% de desconto no total'),
                ),
                const Divider(height: 1),
                RadioListTile<bool>(
                  value: false,
                  groupValue: usarPix,
                  onChanged: (valor) {
                    if (valor != null) {
                      viagem.selecionarPagamento(destino, valor);
                    }
                  },
                  secondary: const Icon(Icons.credit_card),
                  title: const Text('Cartão'),
                  subtitle: const Text('Sem desconto'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Detalhamento dos valores',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),

          _LinhaResumo(
            titulo: 'Subtotal da viagem',
            valor: formatarReais(total),
          ),

          _LinhaResumo(
            titulo: 'Desconto PIX',
            valor: desconto > 0
                ? '- ${formatarReais(desconto)}'
                : formatarReais(0),
            corValor: desconto > 0 ? Colors.green : null,
          ),

          const Divider(height: 28),

          _LinhaResumo(
            titulo: 'Total a pagar',
            valor: formatarReais(totalFinal),
            destaque: true,
            corValor: Colors.green.shade700,
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: total > 0
                ? () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Resumo confirmado'),
                        content: Text(
                          'Destino: ${destino.nome}\n'
                          'Pagamento: ${usarPix ? 'PIX' : 'Cartão'}\n'
                          'Total: ${formatarReais(totalFinal)}\n\n'
                          'Esta é uma confirmação demonstrativa. '
                          'Nenhum pagamento foi realizado.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Confirmar viagem'),
          ),

          const SizedBox(height: 12),

          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Voltar aos destinos'),
          ),
        ],
      ),
    );
  }
}

class _LinhaResumo extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool destaque;
  final Color? corValor;

  const _LinhaResumo({
    required this.titulo,
    required this.valor,
    this.destaque = false,
    this.corValor,
  });

  @override
  Widget build(BuildContext context) {
    final estilo = destaque
        ? Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(titulo, style: estilo)),
          const SizedBox(width: 12),
          Text(
            valor,
            style: estilo?.copyWith(color: corValor),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
