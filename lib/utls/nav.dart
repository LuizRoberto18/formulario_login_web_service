import 'package:flutter/material.dart';

Future push(context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

pop<T extends Object>(BuildContext context, [T? result]) {
  return Navigator.pop(context);
}
