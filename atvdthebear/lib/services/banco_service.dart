import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/usuario.dart';
import '../models/pedido.dart';

class BancoService {
  static Database? _db;

  Future<Database> get _banco async {
    _db ??= await openDatabase(
      join(await getDatabasesPath(), 'thebear.db'),
      version: 1,
      onCreate: (db, v) async {
        await db.execute(
            'CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, email TEXT UNIQUE, senha TEXT)');
        await db.execute(
            'CREATE TABLE pedidos(id INTEGER PRIMARY KEY AUTOINCREMENT, cliente TEXT, prato TEXT, quantidade INTEGER, valor_unitario REAL, status TEXT)');
      },
    );
    return _db!;
  }

  // ---------- Usuários ----------
  Future<bool> cadastrarUsuario(Usuario u) async {
    try {
      final db = await _banco;
      await db.insert('usuarios', u.toMap()..remove('id'));
      return true;
    } catch (e) {
      return false; // e-mail já cadastrado
    }
  }

  Future<Usuario?> login(String email, String senha) async {
    final db = await _banco;
    final r = await db.query('usuarios',
        where: 'email = ? AND senha = ?', whereArgs: [email, senha]);
    return r.isEmpty ? null : Usuario.fromMap(r.first);
  }

  // ---------- Pedidos ----------
  Future<void> inserirPedido(Pedido p) async {
    final db = await _banco;
    await db.insert('pedidos', p.toMap()..remove('id'));
  }

  Future<List<Pedido>> listarPedidos() async {
    final db = await _banco;
    final r = await db.query('pedidos', orderBy: 'id DESC');
    return r.map(Pedido.fromMap).toList();
  }

  Future<void> finalizarPedido(int id) async {
    final db = await _banco;
    await db.update('pedidos', {'status': 'Finalizado'},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> excluirPedido(int id) async {
    final db = await _banco;
    await db.delete('pedidos', where: 'id = ?', whereArgs: [id]);
  }
}
