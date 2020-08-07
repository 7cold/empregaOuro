import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/profile_ui.dart';
import 'package:empregaOuro/ui/search_user.dart';
import 'package:empregaOuro/widgets/home/item_home_enterprise.dart';
import 'package:empregaOuro/widgets/home/item_home_work.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WidgetMobile extends StatelessWidget {
  UserController c = Get.put(UserController());

  RxString setor = "administrativo".obs;
  @override
  Widget build(BuildContext context) {
    double w = Get.width;

    print(c.userData['nome']);

    return Stack(
      children: [
        SingleChildScrollView(
          child: Obx(
            () => Container(
              height: Get.height,
              child: c.userData.value['tipo'] == "user"
                  ? StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('setores')
                          .document(setor.value)
                          .collection("vagas")
                          .orderBy('data', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CupertinoActivityIndicator());
                        } else {
                          return GridView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 70, bottom: 60),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  w > 1700 ? 4 : w > 1000 ? 3 : w > 750 ? 2 : 1,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: w > 1300
                                  ? 2
                                  : w > 1000 ? 1.5 : w > 550 && w < 750 ? 3 : 2,
                            ),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return ItemHomeWork(
                                  doc: snapshot.data.documents[index]);
                            },
                          );
                        }
                      })
                  : GridView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            w > 1700 ? 4 : w > 1000 ? 3 : w > 750 ? 2 : 1,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: w > 1300
                            ? 2
                            : w > 1000 ? 1.5 : w > 550 && w < 750 ? 3 : 2,
                      ),
                      children: [
                        ItemHomeEnterprise(
                          img: 'assets/illustration/i-2.png',
                          label: "Vagas\nOferecidas",
                          scale: 12,
                          rota: ProfileUi(),
                        ),
                        ItemHomeEnterprise(
                            rota: SearchUserUi(),
                            img: 'assets/illustration/i-3.png',
                            label: "Buscar\nColaborador",
                            scale: 15),
                      ],
                    ),
            ),
          ),
        ),
        Obx(() => c.userData.value['tipo'] == "user"
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: BackdropFilter(
                  filter: new ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream:
                          Firestore.instance.collection('setores').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                              children: snapshot.data.documents
                                  .map(
                                    (doc) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 10, bottom: 10),
                                      child: InkWell(
                                        onTap: () {
                                          setor.value = doc.documentID;
                                          print(setor.value);
                                        },
                                        child: Obx(
                                          () => Chip(
                                            labelStyle: fontRegular16Branco,
                                            backgroundColor: setor.value ==
                                                    doc.documentID
                                                ? Color(corSecundaria2)
                                                : CupertinoColors.systemGrey2,
                                            label: Text(doc.data['nome']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList());
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              )
            : SizedBox())
      ],
    );
  }
}
