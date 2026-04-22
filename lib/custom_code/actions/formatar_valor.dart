// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

String formatarValor(String valor) {
  // Remove pontos, vírgulas e zeros à esquerda
  String valorLimpo =
      valor.replaceAll(RegExp(r'[.,]'), '').replaceFirst(RegExp(r'^0+'), '');

  // Convertendo o valor limpo para int
  int valorInt = int.tryParse(valorLimpo) ?? 0;

  // Convertendo o valor para string
  String valorString = valorInt.toString();

  // Se a string tem menos de 3 caracteres, adiciona zeros à esquerda
  if (valorString.length < 3) {
    valorString = valorString.padLeft(3, '0');
  }

  // Adicionando a vírgula para separar as casas decimais
  String parteInteira = valorString.substring(0, valorString.length - 2);
  String parteDecimal = valorString.substring(valorString.length - 2);

  // Usando regex para adicionar pontos nos milhares
  parteInteira = parteInteira.replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (Match match) => '${match[1]}.',
  );

  // Retornando o valor formatado
  return '$parteInteira,$parteDecimal';
}
