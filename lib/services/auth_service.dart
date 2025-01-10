// lib/services/auth_service.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/utils/http_status.dart';

class AuthService {
  final String baseUrl = "http://localhost:8000";

  // Méthode de hachage des mots de passe
  String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convertit le mot de passe en bytes
    final digest = sha256.convert(bytes); // Applique SHA-256
    return digest.toString(); // Retourne le hachage en chaîne hexadécimale
  }

  // Méthode de connexion
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"email": email, "password": password});

    try {
      final response = await http.post(url, headers: headers, body: body);

      switch (response.statusCode) {
        case HttpStatusCode.ok:
          return json.decode(response.body);
        case HttpStatusCode.badRequest:
          return null;
        default:
          throw Exception("Unknown status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Network error during login: $e");
    }

    // Simule un délai pour imiter un appel réseau
    await Future.delayed(const Duration(seconds: 2));



    return null;
  }
}
