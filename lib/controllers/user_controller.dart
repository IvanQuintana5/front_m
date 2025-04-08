import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front_m/service/auth_service.dart';
import 'package:http/http.dart' as http;

class UserController {
  final AuthService _authService = AuthService();

  //Login
  Future<bool> loginUser(String email, String password, BuildContext context) async {
    try {
      final response = await http.post(Uri.parse('${_authService.baseUrl}/User/Login'),
      headers: {
        'Content-Type': 'application/json; character=UTF8',
      },
      body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final token = data['token'] as String;

        return true;
      } else {
        print('Error login - Ife - Controller: ${response.statusCode} - ${response.body}');
        return false;
      }
      
    } catch (e) {
      print('Error al iniciar sesion - TryCatch - Controller: $e');
      return false;
    }
  }
}