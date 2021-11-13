// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, unused_import

import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:web_service/models/result_cep.dart';

class ViaCepService {
  static Future<ResultCep> fetchCep({String? cep}) async {
    final Uri uri = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print('BELEZA, VAI RETORNAR RESULTCEP');
      return ResultCep.fromJson(response.body);
    } else {
      print('DEU ERRO NULO');
      throw Exception('Requisição inválida!');
    }
  }
}
