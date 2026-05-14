import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calcular_renda_passiva_page_widget.dart'
    show CalcularRendaPassivaPageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CalcularRendaPassivaPageModel
    extends FlutterFlowModel<CalcularRendaPassivaPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [AdMob - Show Interstitial Ad] action in CalcularRendaPassivaPage widget.
  bool? interstitialAdSuccess;
  // State field(s) for inputPrazo widget.
  FocusNode? inputPrazoFocusNode;
  TextEditingController? inputPrazoTextController;
  late MaskTextInputFormatter inputPrazoMask;
  String? Function(BuildContext, String?)? inputPrazoTextControllerValidator;
  String? _inputPrazoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('/^\\d{1,3}\$/').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // State field(s) for InputTaxa widget.
  FocusNode? inputTaxaFocusNode;
  TextEditingController? inputTaxaTextController;
  String? Function(BuildContext, String?)? inputTaxaTextControllerValidator;
  String? _inputTaxaTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('/^\\d{1,3}(\\.\\d{3})*,\\d{2}\$/').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // Stores action output result for [Custom Action - formatarValor] action in InputTaxa widget.
  String? resultValorFormatado;
  // State field(s) for inputVlrInicial widget.
  FocusNode? inputVlrInicialFocusNode;
  TextEditingController? inputVlrInicialTextController;
  String? Function(BuildContext, String?)?
      inputVlrInicialTextControllerValidator;
  String? _inputVlrInicialTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('/^\\d{1,3}(\\.\\d{3})*,\\d{2}\$/').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // Stores action output result for [Custom Action - formatarValor] action in inputVlrInicial widget.
  String? resultValorInicialFormatado;
  // State field(s) for inputVlrRecorrente widget.
  FocusNode? inputVlrRecorrenteFocusNode;
  TextEditingController? inputVlrRecorrenteTextController;
  String? Function(BuildContext, String?)?
      inputVlrRecorrenteTextControllerValidator;
  String? _inputVlrRecorrenteTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('/^\\d{1,3}(\\.\\d{3})*,\\d{2}\$/').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // Stores action output result for [Custom Action - formatarValor] action in inputVlrRecorrente widget.
  String? resultVlrRecorrenteFormatado;
  // State field(s) for inputRendaPassiva widget.
  FocusNode? inputRendaPassivaFocusNode;
  TextEditingController? inputRendaPassivaTextController;
  String? Function(BuildContext, String?)?
      inputRendaPassivaTextControllerValidator;
  String? _inputRendaPassivaTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp('/^\\d{1,3}(\\.\\d{3})*,\\d{2}\$/').hasMatch(val)) {
      return 'Invalid text';
    }
    return null;
  }

  // Stores action output result for [Custom Action - formatarValor] action in inputRendaPassiva widget.
  String? resultRendaPassivaFormatado;

  @override
  void initState(BuildContext context) {
    inputPrazoTextControllerValidator = _inputPrazoTextControllerValidator;
    inputTaxaTextControllerValidator = _inputTaxaTextControllerValidator;
    inputVlrInicialTextControllerValidator =
        _inputVlrInicialTextControllerValidator;
    inputVlrRecorrenteTextControllerValidator =
        _inputVlrRecorrenteTextControllerValidator;
    inputRendaPassivaTextControllerValidator =
        _inputRendaPassivaTextControllerValidator;
  }

  @override
  void dispose() {
    inputPrazoFocusNode?.dispose();
    inputPrazoTextController?.dispose();

    inputTaxaFocusNode?.dispose();
    inputTaxaTextController?.dispose();

    inputVlrInicialFocusNode?.dispose();
    inputVlrInicialTextController?.dispose();

    inputVlrRecorrenteFocusNode?.dispose();
    inputVlrRecorrenteTextController?.dispose();

    inputRendaPassivaFocusNode?.dispose();
    inputRendaPassivaTextController?.dispose();
  }
}
