import 'package:flutter/material.dart';

Future push(context, Widget page){
  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
    return page;
  }));
}