import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isPro = prefs.getBool('ff_isPro') ?? _isPro;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_versiculoHoje')) {
        try {
          _versiculoHoje =
              jsonDecode(prefs.getString('ff_versiculoHoje') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _versiculoUpdatedAt = prefs.containsKey('ff_versiculoUpdatedAt')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_versiculoUpdatedAt')!)
          : _versiculoUpdatedAt;
    });
    _safeInit(() {
      _historicoDeCalculos =
          prefs.getStringList('ff_historicoDeCalculos')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _historicoDeCalculos;
    });
    _safeInit(() {
      _lastAdShowedAt = prefs.containsKey('ff_lastAdShowedAt')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_lastAdShowedAt')!)
          : _lastAdShowedAt;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isPro = false;
  bool get isPro => _isPro;
  set isPro(bool value) {
    _isPro = value;
    prefs.setBool('ff_isPro', value);
  }

  dynamic _versiculoHoje;
  dynamic get versiculoHoje => _versiculoHoje;
  set versiculoHoje(dynamic value) {
    _versiculoHoje = value;
    prefs.setString('ff_versiculoHoje', jsonEncode(value));
  }

  DateTime? _versiculoUpdatedAt =
      DateTime.fromMillisecondsSinceEpoch(1772397120000);
  DateTime? get versiculoUpdatedAt => _versiculoUpdatedAt;
  set versiculoUpdatedAt(DateTime? value) {
    _versiculoUpdatedAt = value;
    value != null
        ? prefs.setInt('ff_versiculoUpdatedAt', value.millisecondsSinceEpoch)
        : prefs.remove('ff_versiculoUpdatedAt');
  }

  List<dynamic> _historicoDeCalculos = [];
  List<dynamic> get historicoDeCalculos => _historicoDeCalculos;
  set historicoDeCalculos(List<dynamic> value) {
    _historicoDeCalculos = value;
    prefs.setStringList(
        'ff_historicoDeCalculos', value.map((x) => jsonEncode(x)).toList());
  }

  void addToHistoricoDeCalculos(dynamic value) {
    historicoDeCalculos.add(value);
    prefs.setStringList('ff_historicoDeCalculos',
        _historicoDeCalculos.map((x) => jsonEncode(x)).toList());
  }

  void removeFromHistoricoDeCalculos(dynamic value) {
    historicoDeCalculos.remove(value);
    prefs.setStringList('ff_historicoDeCalculos',
        _historicoDeCalculos.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromHistoricoDeCalculos(int index) {
    historicoDeCalculos.removeAt(index);
    prefs.setStringList('ff_historicoDeCalculos',
        _historicoDeCalculos.map((x) => jsonEncode(x)).toList());
  }

  void updateHistoricoDeCalculosAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    historicoDeCalculos[index] = updateFn(_historicoDeCalculos[index]);
    prefs.setStringList('ff_historicoDeCalculos',
        _historicoDeCalculos.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInHistoricoDeCalculos(int index, dynamic value) {
    historicoDeCalculos.insert(index, value);
    prefs.setStringList('ff_historicoDeCalculos',
        _historicoDeCalculos.map((x) => jsonEncode(x)).toList());
  }

  bool _showConfirmDelete = false;
  bool get showConfirmDelete => _showConfirmDelete;
  set showConfirmDelete(bool value) {
    _showConfirmDelete = value;
  }

  DateTime? _lastAdShowedAt = DateTime.fromMillisecondsSinceEpoch(10800000);
  DateTime? get lastAdShowedAt => _lastAdShowedAt;
  set lastAdShowedAt(DateTime? value) {
    _lastAdShowedAt = value;
    value != null
        ? prefs.setInt('ff_lastAdShowedAt', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastAdShowedAt');
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}
