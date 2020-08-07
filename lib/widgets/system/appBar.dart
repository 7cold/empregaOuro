import 'package:empregaOuro/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

appBarUi(String label, Widget widget, Function function) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Color(corDark),
    elevation: 0,
    toolbarHeight: 60,
    leadingWidth: 65,
    title: Text(label),
    leading: widget,
    automaticallyImplyLeading: true,
  );
}
