import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MeusInteressesUi extends StatelessWidget {
  UserController c = Get.find();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BackButtonCustom(
                function: () => Get.back(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                w > 1200 ? w / 4 : 20,
                0,
                w > 1200 ? w / 4 : 20,
                20,
              ),
              child: Material(
                elevation: 5,
                shadowColor: CupertinoColors.systemFill,
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Meus Interesses",
                        style: fontHeavy20Dark,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('users')
                            .document(c.firebaseUser.value.uid)
                            .collection('interesse')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data.documents
                                    .map(
                                      (doc) => _ItemInteresse(
                                        doc: doc,
                                      ),
                                    )
                                    .toList());
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ItemInteresse extends StatelessWidget {
  var controller = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final DocumentSnapshot doc;

  _ItemInteresse({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection("setores")
            .document(doc.data['setor'])
            .collection("vagas")
            .document(doc.data['vagaId'])
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              controller.updateValue(snapshot.data['salario']);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        snapshot.data['cargo'],
                        style: fontRegular16Grey,
                      ),
                      snapshot.data['disponivel'] == true
                          ? Icon(
                              CupertinoIcons.check_mark_circled,
                              color: CupertinoColors.systemGreen,
                            )
                          : Icon(
                              CupertinoIcons.minus_circled,
                              color: CupertinoColors.systemYellow,
                            )
                    ],
                  ),
                  Text(
                    snapshot.data['empresaNome'],
                    style: fontRegular16Grey,
                  ),
                  Text(
                    controller.text,
                    style: fontRegular16Grey,
                  ),
                  Divider(),
                ],
              );
            } else {
              return CupertinoActivityIndicator();
            }
          } else {
            return CupertinoActivityIndicator();
          }
        });
  }
}
