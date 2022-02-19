import 'dart:async';

import 'package:projeto_carros/api/loripsum_api.dart';

class LoripsumBloc {
  static String? lorin;
  final _streaamController = StreamController<String>();

  Stream<String> get stream => _streaamController.stream;

  fatch() async {
    // String s = lorin! ?? await LoripsumApi.getLoripsum();
    String s = await LoripsumApi.getLoripsum();
    // lorin = s;
    _streaamController.add(s);
  }

  void dispose() {
    _streaamController.close();
  }
}
