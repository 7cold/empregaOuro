import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/widgets/profile/item_search_user.dart';
import 'package:empregaOuro/widgets/system/back_button_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(corPrincipal),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BackButtonCustom(
                function: () {
                  Get.back();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                w > 1200 ? w / 4 : 0,
                0,
                w > 1200 ? w / 4 : 0,
                20,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('users')
                      .where("tipo", isEqualTo: "user")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return new Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            return ItemSearchUser(
                                doc: snapshot.data.documents[index]);
                          });
                    }
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
