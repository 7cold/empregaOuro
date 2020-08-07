import 'package:empregaOuro/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBackButton extends StatelessWidget {
  final Function function;

  const AppBarBackButton({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: CupertinoColors.systemFill,
        onTap: function,
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(corPrincipal),
          ),
        ),
      ),
    );
  }
}
