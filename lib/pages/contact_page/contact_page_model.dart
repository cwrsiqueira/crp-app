import '/componentes/tire_os_anuncios_component/tire_os_anuncios_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'contact_page_widget.dart' show ContactPageWidget;
import 'package:flutter/material.dart';

class ContactPageModel extends FlutterFlowModel<ContactPageWidget> {
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
