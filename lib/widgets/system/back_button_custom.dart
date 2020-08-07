import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  final Function function;

  const BackButtonCustom({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CupertinoButton(
          padding: EdgeInsets.only(left: 20),
          color: CupertinoColors.white,
          child: Row(
            children: [
              Icon(CupertinoIcons.back, color: CupertinoColors.systemGrey),
              Text(
                "Voltar",
                style: TextStyle(color: CupertinoColors.systemGrey),
              ),
            ],
          ),
          onPressed: function),
    );
  }
}
