import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // Login: consulta o endpoint /usuario
  Future<Map<String, dynamic>?> login({
    required String email,
    required String senha,
  }) async {
    final uri = Uri.parse('$baseUrl/usuario')
        .replace(queryParameters: {'email': email, 'senha': senha});

    final response = await http.get(uri).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Erro ao consultar usuários.');
    }

    final List<dynamic> usuarios = jsonDecode(response.body);

    if (usuarios.isEmpty) {
      return null;
    }

    return Map<String, dynamic>.from(usuarios.first);
  }

  // Cadastro: envia os dados para /cadastro-usuario
  Future<Map<String, dynamic>> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final uri = Uri.parse('$baseUrl/cadastro-usuario');

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({'nome': nome, 'email': email, 'senha': senha}),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Não foi possível cadastrar o usuário.');
    }

    return Map<String, dynamic>.from(jsonDecode(response.body));
  }
}
