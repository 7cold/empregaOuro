import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/meus_interesses_ui.dart';
import 'package:empregaOuro/widgets/profile/item_alert_enterprise_vaga.dart';
import 'package:empregaOuro/widgets/profile/item_alert_school.dart';
import 'package:empregaOuro/widgets/profile/item_enterprise.dart';
import 'package:empregaOuro/widgets/profile/item_school.dart';
import 'package:empregaOuro/widgets/profile/item_work.dart';
import 'package:empregaOuro/widgets/profile/item_alert_work.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileUi extends StatelessWidget {
  UserController c = Get.find();
  @override
  Widget build(BuildContext context) {
    print(c.interesse);
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
                        Text(
                          c.userData['nome'],
                          style: fontBold16Dark,
                        ),
                        SizedBox(height: 4),
                        Text(
                          c.userData['email'],
                          style: fontRegular16Grey,
                        ),
                        SizedBox(height: 4),
                        c.userData.value['tipo'] == "user"
                            ? SizedBox()
                            : Text(
                                c.userData['setor'],
                                style: fontRegular16Grey,
                              ),
                        SizedBox(height: 4),
                        c.userData.value['tipo'] == "user"
                            ? Text(
                                '${formatDate(c.userData['dataNasc'].toDate(), [
                                  dd,
                                  '/',
                                  mm,
                                  '/',
                                  yyyy,
                                ])}',
                                style: fontRegular16Grey,
                              )
                            : SizedBox(),
                        c.userData.value['tipo'] == "user"
                            ? Row(
                                children: [
                                  Text(
                                    "Disponibilidade: ",
                                    style: fontRegular16Grey,
                                  ),
                                  Transform.scale(
                                    scale: 0.7,
                                    child: Obx(
                                      () => CupertinoSwitch(
                                        value: c.userData['status'],
                                        onChanged: (bool value) {
                                          c.changeStatus(value);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                        Text(
                          c.userData['enderecoBairro'] +
                              " - " +
                              c.userData['enderecoCidade'],
                          style: fontRegular16Grey,
                        ),
                        SizedBox(height: 4),
                        Text(
                          c.userData['cel'],
                          style: fontRegular16Grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              c.userData.value['tipo'] == "user"
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(
                        w > 1200 ? w / 4 : 20,
                        0,
                        w > 1200 ? w / 4 : 20,
                        20,
                      ),
                      child: SizedBox(
                        width: Get.width,
                        child: CupertinoButton(
                            color: Color(corSecundaria2),
                            child: Text("Meus Interesses"),
                            onPressed: () {
                              Get.to(MeusInteressesUi());
                            }),
                      ),
                    )
                  : SizedBox(),
              c.userData.value['tipo'] == "user"
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
                                  CupertinoButton(
                                    child: Text("Nova Formação"),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      alertAddItemSchool(context);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(c.firebaseUser.value.uid)
                                    .collection('formacao')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                        children: snapshot.data.documents
                                            .map(
                                              (doc) => ItemSchool(doc: doc),
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
              c.userData.value['tipo'] == "user"
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
                                  CupertinoButton(
                                    child: Text("Nova Exp."),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      alertAddItemWork(context);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(c.firebaseUser.value.uid)
                                    .collection('experiencia')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      children: snapshot.data.documents
                                          .map((doc) => ItemWork(doc: doc))
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
              c.userData.value['tipo'] == "enterprise"
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
                                  CupertinoButton(
                                    child: Text("Nova vaga"),
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      alertAddItemVaga(context);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              StreamBuilder<QuerySnapshot>(
                                stream: Firestore.instance
                                    .collection('users')
                                    .document(c.firebaseUser.value.uid)
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
                                                    .document(
                                                        docUser.documentID)
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
