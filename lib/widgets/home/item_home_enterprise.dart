import 'package:empregaOuro/const/fontes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemHomeEnterprise extends StatelessWidget {
  final String label;
  final String img;
  final double scale;
  final Widget rota;

  const ItemHomeEnterprise(
      {Key key, this.label, this.img, this.scale, this.rota})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Get.to(rota);
        },
        child: Material(
          elevation: 5,
          shadowColor: CupertinoColors.systemFill,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Positioned(
                  left: 15,
                  bottom: 20,
                  child: Text(
                    label,
                    style: fontBold24Dark,
                  ),
                ),
                Positioned(
                  right: 15,
                  child: Image.asset(
                    img,
                    scale: scale,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
