import '/componentes/tire_os_anuncios_component/tire_os_anuncios_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calcular_renda_passiva_result_widget.dart'
    show CalcularRendaPassivaResultWidget;
import 'package:flutter/material.dart';

class CalcularRendaPassivaResultModel
    extends FlutterFlowModel<CalcularRendaPassivaResultWidget> {
  ///  Local state fields for this page.

  dynamic results;

  bool showSaveCalc = false;

  ///  State fields for stateful widgets in this page.

  // Model for TireOsAnunciosComponent component.
  late TireOsAnunciosComponentModel tireOsAnunciosComponentModel;

  @override
  void initState(BuildContext context) {
    tireOsAnunciosComponentModel =
        createModel(context, () => TireOsAnunciosComponentModel());
  }

  @override
  void dispose() {
    tireOsAnunciosComponentModel.dispose();
  }
}
