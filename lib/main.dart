import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/ui/index_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeftWithFade,
        transitionDuration: Duration(milliseconds: 200),
        theme: ThemeData(
          primarySwatch: primaria,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: LoginUi());
        home: Root());
  }
}
