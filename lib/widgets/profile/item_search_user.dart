import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/ui/profile_detail_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemSearchUser extends StatelessWidget {
  final DocumentSnapshot doc;

  ItemSearchUser({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: InkWell(
        onTap: () {
          Get.to(ProfileDetailUi(doc: doc));
        },
        child: Material(
          borderRadius: BorderRadius.circular(8),
          elevation: 8,
          color: Colors.transparent,
          shadowColor: CupertinoColors.systemFill,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doc.data['nome'],
                        style: fontHeavy16Dark,
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
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("users")
                          .document(doc.documentID)
                          .collection("formacao")
                          .limit(1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Text("")
                            : Column(
                                children: snapshot.data.documents.map((res) {
                                return Text(
                                  res.data['curso'] +
                                      " - " +
                                      res.data['instituicao'],
                                  style: fontRegular16Grey,
                                );
                              }).toList());
                      }),
                  Text(
                    doc.data['enderecoBairro'] +
                        " - " +
                        doc.data['enderecoCidade'],
                    style: fontRegular16Grey,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection("users")
                              .document(doc.documentID)
                              .collection("formacao")
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? SizedBox()
                                : Container(
                                    height: 26,
                                    width: 94,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Formações",
                                            style: fontRegular16Grey,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color:
                                                    CupertinoColors.systemBlue),
                                            child: Text(
                                              snapshot.data.documents.length
                                                  .toString(),
                                              style: fontRegular14Light,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                      StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection("users")
                              .document(doc.documentID)
                              .collection("experiencia")
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? SizedBox()
                                : Container(
                                    height: 26,
                                    width: 104,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Experiências",
                                            style: fontRegular16Grey,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: CupertinoColors
                                                    .systemGreen),
                                            child: Text(
                                              snapshot.data.documents.length
                                                  .toString(),
                                              style: fontRegular14Light,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
