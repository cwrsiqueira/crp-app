// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalcResultsStruct extends BaseStruct {
  CalcResultsStruct({
    int? prazo,
    double? valorTotalAplicado,
    double? valorInicialAplicado,
    double? valorRecorrenteMensal,
    double? rendimentos,
    double? valorAcumulado,
    double? taxa,
    double? valorRenda,
    String? date,
  })  : _prazo = prazo,
        _valorTotalAplicado = valorTotalAplicado,
        _valorInicialAplicado = valorInicialAplicado,
        _valorRecorrenteMensal = valorRecorrenteMensal,
        _rendimentos = rendimentos,
        _valorAcumulado = valorAcumulado,
        _taxa = taxa,
        _valorRenda = valorRenda,
        _date = date;

  // "prazo" field.
  int? _prazo;
  int get prazo => _prazo ?? 0;
  set prazo(int? val) => _prazo = val;

  void incrementPrazo(int amount) => prazo = prazo + amount;

  bool hasPrazo() => _prazo != null;

  // "valorTotalAplicado" field.
  double? _valorTotalAplicado;
  double get valorTotalAplicado => _valorTotalAplicado ?? 0.0;
  set valorTotalAplicado(double? val) => _valorTotalAplicado = val;

  void incrementValorTotalAplicado(double amount) =>
      valorTotalAplicado = valorTotalAplicado + amount;

  bool hasValorTotalAplicado() => _valorTotalAplicado != null;

  // "valorInicialAplicado" field.
  double? _valorInicialAplicado;
  double get valorInicialAplicado => _valorInicialAplicado ?? 0.0;
  set valorInicialAplicado(double? val) => _valorInicialAplicado = val;

  void incrementValorInicialAplicado(double amount) =>
      valorInicialAplicado = valorInicialAplicado + amount;

  bool hasValorInicialAplicado() => _valorInicialAplicado != null;

  // "valorRecorrenteMensal" field.
  double? _valorRecorrenteMensal;
  double get valorRecorrenteMensal => _valorRecorrenteMensal ?? 0.0;
  set valorRecorrenteMensal(double? val) => _valorRecorrenteMensal = val;

  void incrementValorRecorrenteMensal(double amount) =>
      valorRecorrenteMensal = valorRecorrenteMensal + amount;

  bool hasValorRecorrenteMensal() => _valorRecorrenteMensal != null;

  // "rendimentos" field.
  double? _rendimentos;
  double get rendimentos => _rendimentos ?? 0.0;
  set rendimentos(double? val) => _rendimentos = val;

  void incrementRendimentos(double amount) =>
      rendimentos = rendimentos + amount;

  bool hasRendimentos() => _rendimentos != null;

  // "valorAcumulado" field.
  double? _valorAcumulado;
  double get valorAcumulado => _valorAcumulado ?? 0.0;
  set valorAcumulado(double? val) => _valorAcumulado = val;

  void incrementValorAcumulado(double amount) =>
      valorAcumulado = valorAcumulado + amount;

  bool hasValorAcumulado() => _valorAcumulado != null;

  // "taxa" field.
  double? _taxa;
  double get taxa => _taxa ?? 0.0;
  set taxa(double? val) => _taxa = val;

  void incrementTaxa(double amount) => taxa = taxa + amount;

  bool hasTaxa() => _taxa != null;

  // "valorRenda" field.
  double? _valorRenda;
  double get valorRenda => _valorRenda ?? 0.0;
  set valorRenda(double? val) => _valorRenda = val;

  void incrementValorRenda(double amount) => valorRenda = valorRenda + amount;

  bool hasValorRenda() => _valorRenda != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  static CalcResultsStruct fromMap(Map<String, dynamic> data) =>
      CalcResultsStruct(
        prazo: castToType<int>(data['prazo']),
        valorTotalAplicado: castToType<double>(data['valorTotalAplicado']),
        valorInicialAplicado: castToType<double>(data['valorInicialAplicado']),
        valorRecorrenteMensal:
            castToType<double>(data['valorRecorrenteMensal']),
        rendimentos: castToType<double>(data['rendimentos']),
        valorAcumulado: castToType<double>(data['valorAcumulado']),
        taxa: castToType<double>(data['taxa']),
        valorRenda: castToType<double>(data['valorRenda']),
        date: data['date'] as String?,
      );

  static CalcResultsStruct? maybeFromMap(dynamic data) => data is Map
      ? CalcResultsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'prazo': _prazo,
        'valorTotalAplicado': _valorTotalAplicado,
        'valorInicialAplicado': _valorInicialAplicado,
        'valorRecorrenteMensal': _valorRecorrenteMensal,
        'rendimentos': _rendimentos,
        'valorAcumulado': _valorAcumulado,
        'taxa': _taxa,
        'valorRenda': _valorRenda,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'prazo': serializeParam(
          _prazo,
          ParamType.int,
        ),
        'valorTotalAplicado': serializeParam(
          _valorTotalAplicado,
          ParamType.double,
        ),
        'valorInicialAplicado': serializeParam(
          _valorInicialAplicado,
          ParamType.double,
        ),
        'valorRecorrenteMensal': serializeParam(
          _valorRecorrenteMensal,
          ParamType.double,
        ),
        'rendimentos': serializeParam(
          _rendimentos,
          ParamType.double,
        ),
        'valorAcumulado': serializeParam(
          _valorAcumulado,
          ParamType.double,
        ),
        'taxa': serializeParam(
          _taxa,
          ParamType.double,
        ),
        'valorRenda': serializeParam(
          _valorRenda,
          ParamType.double,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalcResultsStruct fromSerializableMap(Map<String, dynamic> data) =>
      CalcResultsStruct(
        prazo: deserializeParam(
          data['prazo'],
          ParamType.int,
          false,
        ),
        valorTotalAplicado: deserializeParam(
          data['valorTotalAplicado'],
          ParamType.double,
          false,
        ),
        valorInicialAplicado: deserializeParam(
          data['valorInicialAplicado'],
          ParamType.double,
          false,
        ),
        valorRecorrenteMensal: deserializeParam(
          data['valorRecorrenteMensal'],
          ParamType.double,
          false,
        ),
        rendimentos: deserializeParam(
          data['rendimentos'],
          ParamType.double,
          false,
        ),
        valorAcumulado: deserializeParam(
          data['valorAcumulado'],
          ParamType.double,
          false,
        ),
        taxa: deserializeParam(
          data['taxa'],
          ParamType.double,
          false,
        ),
        valorRenda: deserializeParam(
          data['valorRenda'],
          ParamType.double,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalcResultsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalcResultsStruct &&
        prazo == other.prazo &&
        valorTotalAplicado == other.valorTotalAplicado &&
        valorInicialAplicado == other.valorInicialAplicado &&
        valorRecorrenteMensal == other.valorRecorrenteMensal &&
        rendimentos == other.rendimentos &&
        valorAcumulado == other.valorAcumulado &&
        taxa == other.taxa &&
        valorRenda == other.valorRenda &&
        date == other.date;
  }

  @override
  int get hashCode => const ListEquality().hash([
        prazo,
        valorTotalAplicado,
        valorInicialAplicado,
        valorRecorrenteMensal,
        rendimentos,
        valorAcumulado,
        taxa,
        valorRenda,
        date
      ]);
}

CalcResultsStruct createCalcResultsStruct({
  int? prazo,
  double? valorTotalAplicado,
  double? valorInicialAplicado,
  double? valorRecorrenteMensal,
  double? rendimentos,
  double? valorAcumulado,
  double? taxa,
  double? valorRenda,
  String? date,
}) =>
    CalcResultsStruct(
      prazo: prazo,
      valorTotalAplicado: valorTotalAplicado,
      valorInicialAplicado: valorInicialAplicado,
      valorRecorrenteMensal: valorRecorrenteMensal,
      rendimentos: rendimentos,
      valorAcumulado: valorAcumulado,
      taxa: taxa,
      valorRenda: valorRenda,
      date: date,
    );
