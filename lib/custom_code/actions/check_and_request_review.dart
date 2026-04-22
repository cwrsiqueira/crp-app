// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';

Future checkAndRequestReview() async {
  final prefs = await SharedPreferences.getInstance();

  final jaAvaliou = prefs.getBool('avaliacao_pedida') ?? false;
  if (jaAvaliou) return;

  final primeiraAbertura = prefs.getString('primeira_abertura');

  if (primeiraAbertura == null) {
    await prefs.setString(
        'primeira_abertura', DateTime.now().toIso8601String());
    return;
  }

  final dataInicio = DateTime.parse(primeiraAbertura);
  final diasPassados = DateTime.now().difference(dataInicio).inDays;

  if (diasPassados >= 5) {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
      await prefs.setBool('avaliacao_pedida', true);
    }
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
