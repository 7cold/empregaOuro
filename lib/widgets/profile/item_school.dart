import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/data/school_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemSchool extends StatelessWidget {
  final DocumentSnapshot doc;
  final bool showButton;
  ItemSchool({Key key, this.doc, this.showButton = true}) : super(key: key);

  UserController c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SchoolUser formacao = SchoolUser.fromDocument(doc);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              right: 0,
              child: showButton == true
                  ? IconButton(
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: CupertinoColors.systemGrey2,
                      ),
                      onPressed: () {
                        c.removeFormacao(c.firebaseUser.value.uid, formacao.id);
                      },
                    )
                  : SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  formacao.instituicao,
                  style: fontBold16Dark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                formacao.curso,
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(
                '${formatDate(formacao.dataInicio.toDate(), [
                      dd,
                      '/',
                      mm,
                      '/',
                      yyyy,
                    ])}' +
                    " - "
                        '${formatDate(formacao.dataFim.toDate(), [
                      dd,
                      '/',
                      mm,
                      '/',
                      yyyy,
                    ])}',
                style: fontRegular16Grey,
              ),
              SizedBox(height: 4),
              Text(formacao.grau, style: fontRegular16Grey),
              showButton == true
                  ? Row(
                      children: [
                        Text('Concluído:', style: fontRegular16Grey),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: formacao.concluido,
                            onChanged: (bool value) {
                              c.changeFormacao(
                                  value, c.firebaseUser.value.uid, formacao.id);
                            },
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "Concluído: ",
                          style: fontRegular16Grey,
                        ),
                        formacao.concluido == true
                            ? Icon(
                                CupertinoIcons.check_mark_circled,
                                color: CupertinoColors.systemGreen,
                              )
                            : Icon(
                                CupertinoIcons.minus_circled,
                                color: CupertinoColors.systemYellow,
                              ),
                      ],
                    ),
              SizedBox(height: 4),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
