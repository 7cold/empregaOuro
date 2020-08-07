import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/data/work_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ItemWork extends StatelessWidget {
  final DocumentSnapshot doc;
  final bool showButton;
  ItemWork({Key key, this.doc, this.showButton = true}) : super(key: key);

  UserController c = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    WorkUser workUser = WorkUser.fromDocument(doc);

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
                        c.removeWork(c.firebaseUser.value.uid, workUser.id);
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
                  workUser.empresa,
                  style: fontBold16Dark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                workUser.cargo,
                style: fontRegular16Dark,
              ),
              SizedBox(height: 4),
              workUser.dataFim.toDate() == DateTime(1950, 01, 01)
                  ? Text(
                      '${formatDate(workUser.dataInicio.toDate(), [
                        dd,
                        '/',
                        mm,
                        '/',
                        yyyy,
                      ])}',
                      style: fontRegular16Grey,
                    )
                  : Text(
                      '${formatDate(workUser.dataInicio.toDate(), [
                            dd,
                            '/',
                            mm,
                            '/',
                            yyyy,
                          ])}' +
                          " - " +
                          '${formatDate(workUser.dataFim.toDate(), [
                            dd,
                            '/',
                            mm,
                            '/',
                            yyyy,
                          ])}',
                      style: fontRegular16Grey,
                    ),
              SizedBox(height: 4),
              showButton == true
                  ? Row(
                      children: [
                        Text('Emprego Atual:', style: fontRegular16Dark),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            value: workUser.atual,
                            onChanged: (bool value) {
                              c.changeWork(
                                  value, c.firebaseUser.value.uid, workUser.id);
                            },
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "Emprego atual: ",
                          style: fontRegular16Grey,
                        ),
                        workUser.atual == true
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
