import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/data/enterprise_vaga_data.dart';
import 'package:empregaOuro/ui/interessados_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemEnterpriseVaga extends StatelessWidget {
  final DocumentSnapshot docVaga;
  final DocumentSnapshot docUser;
  var controller = new MoneyMaskedTextController(leftSymbol: 'R\$ ');

  UserController c = Get.put(UserController());

  ItemEnterpriseVaga({Key key, this.docVaga, this.docUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnterpriseVagaData vaga = EnterpriseVagaData.fromDocument(docVaga);
    controller.updateValue(vaga.salario);
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: IconButton(
          //     icon: Icon(
          //       CupertinoIcons.delete,
          //       color: CupertinoColors.systemGrey2,
          //     ),
          //     onPressed: () {
          //       c.removeVaga(
          //           c.firebaseUser.value.uid, vaga.id, docUser.data['setor']);
          //     },
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  vaga.cargo,
                  style: fontBold16Dark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${formatDate(vaga.data.toDate(), [
                  dd,
                  '/',
                  mm,
                  '/',
                  yyyy,
                ])}',
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                controller.text,
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                "Grau: " + vaga.grau,
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                "Expediente: " + vaga.expediente,
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                "Atividades: " + vaga.atividades,
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                "Beneficios: ",
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Wrap(
                  children: vaga.beneficios
                      .map(
                        (doc) => Padding(
                          padding: EdgeInsets.only(left: 8, top: 2, bottom: 2),
                          child: Chip(
                            labelStyle: fontRegular16Branco,
                            backgroundColor: CupertinoColors.secondaryLabel,
                            label: Text(doc),
                          ),
                        ),
                      )
                      .toList()),
              Row(
                children: [
                  Text('Disponível: ', style: fontRegular16Grey),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: vaga.disponivel,
                      onChanged: (bool value) {
                        c.changeVaga(value, vaga.id, docUser.data['setor']);
                      },
                    ),
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(c.firebaseUser.value.uid)
                    .collection('vagas')
                    .document(docVaga.documentID)
                    .collection("interesse")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Interessados: " +
                              snapshot.data.documents.length.toString(),
                          style: fontRegular16Grey,
                        ),
                        snapshot.data.documents.length == 0
                            ? SizedBox()
                            : CupertinoButton(
                                padding: EdgeInsets.all(0),
                                child: Text("Visualizar"),
                                onPressed: () {
                                  Get.to(InteressadosUi(
                                    snapshot: snapshot.data,
                                  ));
                                },
                              ),
                      ],
                    );
                    // return Column(
                    //     children: snapshot.data.documents
                    //         .map(
                    //           (doc) => Text(
                    //               snapshot.data.documents.length.toString()),
                    //         )
                    //         .toList());
                  } else {
                    return SizedBox();
                  }
                },
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
