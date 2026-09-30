import 'package:flutter/foundation.dart';
import '../models/usuario.dart';
import '../services/banco_service.dart';

class LoginViewModel extends ChangeNotifier {
  final BancoService _service = BancoService();
  String? erro;

  Future<bool> entrar(String email, String senha) async {
    final u = await _service.login(email.trim(), senha);
    erro = u == null ? 'E-mail ou senha inválidos.' : null;
    notifyListeners();
    return u != null;
  }

  Future<bool> cadastrar(String nome, String email, String senha) async {
    if (nome.trim().isEmpty || email.trim().isEmpty || senha.isEmpty) {
      erro = 'Preencha todos os campos.';
      notifyListeners();
      return false;
    }
    final ok = await _service.cadastrarUsuario(
        Usuario(nome: nome.trim(), email: email.trim(), senha: senha));
    erro = ok ? null : 'E-mail já cadastrado.';
    notifyListeners();
    return ok;
  }

  void limparErro() {
    erro = null;
  }
}
