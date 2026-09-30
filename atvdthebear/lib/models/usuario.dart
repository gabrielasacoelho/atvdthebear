class Usuario {
  final int? id;
  final String nome;
  final String email;
  final String senha;

  Usuario({this.id, required this.nome, required this.email, required this.senha});

  Map<String, dynamic> toMap() =>
      {'id': id, 'nome': nome, 'email': email, 'senha': senha};

  factory Usuario.fromMap(Map<String, dynamic> m) => Usuario(
      id: m['id'], nome: m['nome'], email: m['email'], senha: m['senha']);
}
