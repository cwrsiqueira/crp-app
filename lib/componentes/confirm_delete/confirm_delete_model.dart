import '/componentes/tire_os_anuncios_component/tire_os_anuncios_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_delete_widget.dart' show ConfirmDeleteWidget;
import 'package:flutter/material.dart';

class ConfirmDeleteModel extends FlutterFlowModel<ConfirmDeleteWidget> {
  ///  State fields for stateful widgets in this component.

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
