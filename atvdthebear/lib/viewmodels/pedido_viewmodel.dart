import 'package:flutter/foundation.dart';
import '../models/pedido.dart';
import '../services/banco_service.dart';

class PedidoViewModel extends ChangeNotifier {
  final BancoService _service = BancoService();
  List<Pedido> pedidos = [];

  Future<void> carregar() async {
    pedidos = await _service.listarPedidos();
    notifyListeners();
  }

  Future<void> adicionar(
      String cliente, String prato, int quantidade, double valor) async {
    await _service.inserirPedido(Pedido(
        cliente: cliente,
        prato: prato,
        quantidade: quantidade,
        valorUnitario: valor));
    await carregar();
  }

  Future<void> finalizar(int id) async {
    await _service.finalizarPedido(id);
    await carregar();
  }

  Future<void> excluir(int id) async {
    await _service.excluirPedido(id);
    await carregar();
  }
}
