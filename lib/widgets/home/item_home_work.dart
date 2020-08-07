import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/ui/job_detail_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class ItemHomeWork extends StatelessWidget {
  final DocumentSnapshot doc;

  const ItemHomeWork({Key key, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: CupertinoColors.systemFill,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Get.to(JobDetailUi(doc: doc));
          },
          child: Container(
            padding: EdgeInsets.all(20),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      doc.data['cargo'],
                      style: fontHeavy18Dark,
                    ),
                    Icon(Ionicons.ios_arrow_forward)
                  ],
                ),
                FutureBuilder<DocumentSnapshot>(
                    future: Firestore.instance
                        .collection("users")
                        .document(doc.data['empresaId'])
                        .get(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? CupertinoActivityIndicator()
                          : Text(
                              snapshot.data['nome'],
                              style: fontRegular16Grey,
                            );
                    }),
                Text(
                  "Grau requerido: ${doc.data['grau']}",
                  style: fontRegular16Grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    doc.data['disponivel'] == true
                        ? Row(
                            children: [
                              Text(
                                "Disponível: ",
                                style: fontRegular16Grey,
                              ),
                              Icon(
                                CupertinoIcons.check_mark_circled,
                                color: CupertinoColors.systemGreen,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "Disponível: ",
                                style: fontRegular16Grey,
                              ),
                              Icon(
                                CupertinoIcons.minus_circled,
                                color: CupertinoColors.systemYellow,
                              ),
                            ],
                          ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
