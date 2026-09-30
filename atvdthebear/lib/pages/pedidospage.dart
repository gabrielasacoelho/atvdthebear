import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});
  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  final cliente = TextEditingController();
  final prato = TextEditingController();
  final quantidade = TextEditingController();
  final valor = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<PedidoViewModel>().carregar());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PedidoViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            TextField(
                controller: cliente,
                decoration: const InputDecoration(labelText: 'Cliente')),
            TextField(
                controller: prato,
                decoration: const InputDecoration(labelText: 'Prato')),
            TextField(
                controller: quantidade,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade')),
            TextField(
                controller: valor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor unitário')),
            ElevatedButton(
              onPressed: () async {
                final q = int.tryParse(quantidade.text);
                final v = double.tryParse(valor.text.replaceAll(',', '.'));
                if (cliente.text.isEmpty || prato.text.isEmpty || q == null || v == null) return;
                await context
                    .read<PedidoViewModel>()
                    .adicionar(cliente.text, prato.text, q, v);
                cliente.clear();
                prato.clear();
                quantidade.clear();
                valor.clear();
              },
              child: const Text('Cadastrar pedido'),
            ),
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: vm.pedidos.length,
            itemBuilder: (context, i) {
              final p = vm.pedidos[i];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cliente: ${p.cliente} | Prato: ${p.prato}'),
                        Text('Quantidade: ${p.quantidade} | Total: ${p.totalFormatado}'),
                        Text('Classificação: ${p.classificacao}'),
                        Text('Status: ${p.status}'),
                        Row(children: [
                          TextButton(
                            onPressed: () =>
                                context.read<PedidoViewModel>().finalizar(p.id!),
                            child: const Text('FINALIZAR'),
                          ),
                          TextButton(
                            onPressed: () =>
                                context.read<PedidoViewModel>().excluir(p.id!),
                            child: const Text('EXCLUIR'),
                          ),
                        ]),
                      ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
