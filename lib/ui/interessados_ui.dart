import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/ui/profile_detail_ui.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InteressadosUi extends StatelessWidget {
  final QuerySnapshot snapshot;
  InteressadosUi({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BackButtonCustom(
                function: () => Get.back(),
              ),
            ),
            Column(
                children:
                    snapshot.documents.map((doc) => _User(doc: doc)).toList()),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element
class _User extends StatelessWidget {
  final DocumentSnapshot doc;

  const _User({Key key, this.doc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return FutureBuilder<DocumentSnapshot>(
      future:
          Firestore.instance.collection('users').document(doc.documentID).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              w > 1200 ? w / 4 : 20,
              0,
              w > 1200 ? w / 4 : 20,
              8,
            ),
            child: InkWell(
              onTap: () {
                Get.to(ProfileDetailUi(
                  doc: snapshot.data,
                ));
              },
              child: Material(
                borderRadius: BorderRadius.circular(8),
                shadowColor: CupertinoColors.systemFill,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data['nome'],
                              style: fontRegular16Grey,
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              color: CupertinoColors.systemGrey,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
