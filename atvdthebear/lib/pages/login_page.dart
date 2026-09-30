import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import 'cadastro_page.dart';
import 'pedidos_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('The Bear - Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: email,
              decoration: const InputDecoration(labelText: 'E-mail')),
          TextField(
              controller: senha,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Senha')),
          const SizedBox(height: 12),
          if (vm.erro != null)
            Text(vm.erro!, style: const TextStyle(color: Colors.red)),
          ElevatedButton(
            onPressed: () async {
              final ok = await context
                  .read<LoginViewModel>()
                  .entrar(email.text, senha.text);
              if (ok && context.mounted) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const PedidosPage()));
              }
            },
            child: const Text('Entrar'),
          ),
          TextButton(
            onPressed: () {
              context.read<LoginViewModel>().limparErro();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CadastroPage()));
            },
            child: const Text('Não tem conta? Cadastre-se'),
          ),
        ]),
      ),
    );
  }
}
