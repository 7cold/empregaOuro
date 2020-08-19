import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class JobDetailUi extends StatelessWidget {
  UserController c = Get.put(UserController());
  final DocumentSnapshot doc;
  var controller = new MoneyMaskedTextController(leftSymbol: 'R\$ ');
  JobDetailUi({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.updateValue(doc.data['salario']);
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                w > 1200 ? w / 4 : 20, 0, w > 1200 ? w / 4 : 20, 20),
            child: Column(
              children: [
                SizedBox(height: 10),
                BackButtonCustom(
                  function: () => Get.back(),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dados",
                        style: fontHeavy20Dark,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            doc.data['cargo'],
                            style: fontHeavy16Dark,
                          ),
                          doc.data['disponivel'] == true
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
                      StreamBuilder<DocumentSnapshot>(
                          stream: Firestore.instance
                              .collection("users")
                              .document(doc.data['empresaId'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? CupertinoActivityIndicator()
                                : Text(
                                    snapshot.data['nome'],
                                    style: fontRegular16Grey,
                                  );
                          }),
                      SizedBox(height: 12),
                      Text(
                        '${formatDate(doc.data['data'].toDate(), [
                          dd,
                          '/',
                          mm,
                          '/',
                          yyyy,
                        ])}',
                        style: fontRegular16Grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Grau requerido: " + doc.data['grau'],
                        style: fontRegular16Grey,
                      ),
                      Text(
                        "Expediente: " + doc.data['expediente'],
                        style: fontRegular16Grey,
                      ),
                      Text(
                        "Salário: " + controller.text,
                        style: fontRegular16Grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Benefícios:",
                        style: fontRegular16Grey,
                      ),
                      Wrap(
                          children: doc.data['beneficios']
                              .map<Widget>(
                                (doc) => Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, top: 2, bottom: 2),
                                  child: Chip(
                                    labelStyle: fontRegular16Branco,
                                    backgroundColor:
                                        CupertinoColors.secondaryLabel,
                                    label: Text(doc),
                                  ),
                                ),
                              )
                              .toList()),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => c.interesse.value.contains(doc.documentID)
                            ? SizedBox(
                                width: Get.width,
                                child: CupertinoButton(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: CupertinoColors.systemGreen,
                                  child: c.loading.value != true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(CupertinoIcons.check_mark),
                                            Text("Enviado"),
                                          ],
                                        )
                                      : CupertinoActivityIndicator(),
                                  onPressed: () {
                                    c.removeInteresse(doc);
                                  },
                                ),
                              )
                            : SizedBox(
                                width: Get.width,
                                child: doc.data['disponivel'] == true
                                    ? CupertinoButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: Color(corSecundaria2),
                                        child: c.loading.value != true
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Ionicons
                                                      .ios_notifications),
                                                  SizedBox(width: 10),
                                                  Text("Sinalizar Interesse"),
                                                ],
                                              )
                                            : CupertinoActivityIndicator(),
                                        onPressed: () {
                                          c.createInteresse(doc);
                                        },
                                      )
                                    : CupertinoButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        color: Color(corSecundaria2),
                                        child: c.loading.value != true
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Ionicons
                                                      .ios_notifications),
                                                  SizedBox(width: 10),
                                                  Text("Indisponível"),
                                                ],
                                              )
                                            : CupertinoActivityIndicator(),
                                        onPressed: null,
                                      ),
                              ),
                      )
                    ],
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
