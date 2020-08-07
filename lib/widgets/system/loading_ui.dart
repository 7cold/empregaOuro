import 'package:empregaOuro/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
