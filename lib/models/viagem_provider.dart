import 'package:flutter/foundation.dart';

import 'destino.dart';

class ViagemProvider extends ChangeNotifier {
  final Map<String, int> _diarias = {};
  final Map<String, int> _pessoas = {};
  final Map<String, int> _totais = {};
  final Map<String, bool> _pagamentoPix = {};

  int diariasDe(Destino destino) => _diarias[destino.nome] ?? 0;

  int pessoasDe(Destino destino) => _pessoas[destino.nome] ?? 0;

  int totalDe(Destino destino) => _totais[destino.nome] ?? 0;

  bool pagamentoPixDe(Destino destino) => _pagamentoPix[destino.nome] ?? false;

  double descontoPixDe(Destino destino) {
    if (!pagamentoPixDe(destino)) return 0;
    return totalDe(destino) * 0.10;
  }

  double totalFinalDe(Destino destino) {
    return totalDe(destino) - descontoPixDe(destino);
  }

  void adicionarDiaria(Destino destino) {
    _diarias[destino.nome] = diariasDe(destino) + 1;
    _totais[destino.nome] = 0;
    _pagamentoPix[destino.nome] = false;
    notifyListeners();
  }

  void adicionarPessoa(Destino destino) {
    _pessoas[destino.nome] = pessoasDe(destino) + 1;
    _totais[destino.nome] = 0;
    _pagamentoPix[destino.nome] = false;
    notifyListeners();
  }

  void calcularTotal(Destino destino) {
    _totais[destino.nome] =
        (diariasDe(destino) * destino.valorDiaria) +
        (pessoasDe(destino) * destino.valorPessoa);

    _pagamentoPix[destino.nome] = false;
    notifyListeners();
  }

  void selecionarPagamento(Destino destino, bool usarPix) {
    _pagamentoPix[destino.nome] = usarPix;
    notifyListeners();
  }

  void limpar(Destino destino) {
    _diarias[destino.nome] = 0;
    _pessoas[destino.nome] = 0;
    _totais[destino.nome] = 0;
    _pagamentoPix[destino.nome] = false;
    notifyListeners();
  }
}
