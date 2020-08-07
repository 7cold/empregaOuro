import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/widgets/profile/item_enterprise.dart';
import 'package:empregaOuro/widgets/profile/item_school.dart';
import 'package:empregaOuro/widgets/profile/item_work.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ProfileDetailUi extends StatelessWidget {
  final DocumentSnapshot doc;

  UserController c = Get.find();

  ProfileDetailUi({Key key, this.doc}) : super(key: key);

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var celFormatado = 55.toString() +
        doc.data['cel']
            .toString()
            .replaceAll(' ', "")
            .replaceAll("(", "")
            .replaceAll(")", "")
            .replaceAll("-", "");
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: BackButtonCustom(
                  function: () => Get.back(),
                ),
              ),
              SizedBox(height: 15),
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
                          "Dados",
                          style: fontHeavy20Dark,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              doc.data['nome'],
                              style: fontBold18Dark,
                            ),
                            doc.data['status'] == true
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
                        SizedBox(height: 4),
                        Text(
                          doc.data['email'],
                          style: fontRegular16Grey,
                        ),
                        SizedBox(height: 4),
                        doc.data['tipo'] == "user"
                            ? SizedBox()
                            : Text(
                                doc.data['setor'],
                                style: fontRegular16Grey,
                              ),
                        SizedBox(height: 4),
                        doc.data['tipo'] == "user"
                            ? Text(
                                '${formatDate(doc.data['dataNasc'].toDate(), [
                                  dd,
                                  '/',
                                  mm,
                                  '/',
                                  yyyy,
                                ])}',
                                style: fontRegular16Grey,
                              )
                            : SizedBox(),
                        Text(
                          doc.data['enderecoBairro'] +
                              " - " +
                              doc.data['enderecoCidade'],
                          style: fontRegular16Grey,
                        ),
                        SizedBox(height: 4),
                        Text(
                          doc.data['cel'],
                          style: fontRegular16Grey,
                        ),
                        SizedBox(height: 20),
                        CupertinoButton(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: CupertinoColors.systemGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Ionicons.logo_whatsapp),
                              SizedBox(width: 10),
                              Text("Enviar uma mensagem"),
                            ],
                          ),
                          onPressed: () {
                            GetPlatform.isWeb || GetPlatform.isIOS == true
                                ? _launchURL(
                                    "https://wa.me/$celFormatado?text=")
                                : FlutterOpenWhatsapp.sendSingleMessage(
                                    celFormatado, "");
                          },
                        ),
                        SizedBox(height: 10),
                        CupertinoButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Color(corSecundaria2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Ionicons.ios_phone_portrait),
                                SizedBox(width: 10),
                                Text("Ligar"),
                              ],
                            ),
                            onPressed: () {
                              launch("tel://+$celFormatado");
                            })
                      ],
                    ),
                  ),
                ),
              ),
              doc.data['tipo'] == "user"
                  ? Padding(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Formação",
                                    style: fontHeavy20Dark,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(doc.documentID)
                                    .collection('formacao')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data.documents
                                            .map(
                                              (doc) => ItemSchool(
                                                doc: doc,
                                                showButton: false,
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
                    )
                  : SizedBox(),
              doc.data['tipo'] == "user"
                  ? Padding(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Experiências",
                                    style: fontHeavy20Dark,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(doc.documentID)
                                    .collection('experiencia')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data.documents
                                          .map((doc) => ItemWork(
                                                doc: doc,
                                                showButton: false,
                                              ))
                                          .toList(),
                                    );
                                  } else {
                                    return Text("Nenhum");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              doc.data['tipo'] == "enterprise"
                  ? Padding(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Vagas Oferecidas",
                                    style: fontHeavy20Dark,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(doc.documentID)
                                    .collection('vagas')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data.documents
                                          .map(
                                            (docUser) => StreamBuilder<
                                                    DocumentSnapshot>(
                                                stream: Firestore.instance
                                                    .collection("setores")
                                                    .document(
                                                        docUser.data['setor'])
                                                    .collection("vagas")
                                                    .document(doc.documentID)
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  return !snapshot.hasData
                                                      ? CupertinoActivityIndicator()
                                                      : ItemEnterpriseVaga(
                                                          docUser: docUser,
                                                          docVaga:
                                                              snapshot.data,
                                                        );
                                                }),
                                          )
                                          .toList(),
                                    );
                                  } else {
                                    return Text("Nenhum");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
