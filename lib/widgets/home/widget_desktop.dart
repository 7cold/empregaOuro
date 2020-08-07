import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empregaOuro/const/colors.dart';
import 'package:empregaOuro/const/fontes.dart';
import 'package:empregaOuro/controller/user_controller.dart';
import 'package:empregaOuro/ui/login_ui.dart';
import 'package:empregaOuro/ui/profile_ui.dart';
import 'package:empregaOuro/ui/search_user.dart';
import 'package:empregaOuro/widgets/home/item_home_enterprise.dart';
import 'package:empregaOuro/widgets/home/item_home_work.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WidgetDesktop extends StatelessWidget {
  UserController c = Get.put(UserController());
  RxString setor = "administrativo".obs;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          color: Color(corDark),
          height: h,
          width: 300,
          child: Obx(
            () => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Perfil
                  c.userData['nome'] != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(ProfileUi());
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            c.userData['nome'],
                                            style: fontBold16White,
                                          ),
                                          Icon(
                                            Ionicons.ios_arrow_forward,
                                            color: Color(corPrincipal),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      c.userData['enderecoBairro'] +
                                          " - " +
                                          c.userData['enderecoCidade'],
                                      style: fontRegular16Light,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      c.userData['cel'],
                                      style: fontRegular16Light,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      c.userData['email'],
                                      style: fontRegular16Light,
                                    ),
                                    SizedBox(height: 30),
                                    InkWell(
                                      onTap: () {
                                        c.logout();
                                        Get.to(LoginUi());
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 2,
                                            ),
                                            child: Icon(
                                              Ionicons.ios_log_out,
                                              color: Color(corPrincipal),
                                              size: 16,
                                            ),
                                          ),
                                          Text(
                                            " logout",
                                            style: fontBold16White,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      : Center(
                          child: CupertinoActivityIndicator(),
                        ),
                  //Areas
                  c.userData['tipo'] == "user"
                      ? Padding(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Areas",
                            style: fontBold16White,
                          ),
                        )
                      : SizedBox(),

                  //Areas
                  c.userData['tipo'] == "user"
                      ? StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('setores')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Wrap(
                                  children: snapshot.data.documents
                                      .map(
                                        (doc) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 4, bottom: 4),
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
                                                    : CupertinoColors
                                                        .systemGrey,
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
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: h,
              width: w,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 0),
                      child: Text("Vagas Disponíveis", style: fontHeavy24Dark),
                    ),
                    Obx(
                      () => Container(
                        height: MediaQuery.of(context).size.height,
                        child: c.userData.value['tipo'] == null
                            ? Center(child: CupertinoActivityIndicator())
                            : c.userData.value['tipo'] == "user"
                                ? Obx(
                                    () => StreamBuilder<QuerySnapshot>(
                                        stream: Firestore.instance
                                            .collection('setores')
                                            .document(setor.value)
                                            .collection("vagas")
                                            .orderBy('data', descending: true)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator());
                                          } else {
                                            return GridView.builder(
                                              physics: BouncingScrollPhysics(),
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  top: 20,
                                                  bottom: 20),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: w > 1700
                                                    ? 4
                                                    : w > 1000
                                                        ? 3
                                                        : w > 750 ? 2 : 1,
                                                mainAxisSpacing: 0,
                                                crossAxisSpacing: 0,
                                                childAspectRatio: w > 1300
                                                    ? 2
                                                    : w > 1000
                                                        ? 1.5
                                                        : w > 550 && w < 750
                                                            ? 3
                                                            : 2,
                                              ),
                                              itemCount: snapshot
                                                  .data.documents.length,
                                              itemBuilder: (context, index) {
                                                return ItemHomeWork(
                                                    doc: snapshot
                                                        .data.documents[index]);
                                              },
                                            );
                                          }
                                        }),
                                  )
                                : GridView(
                                    physics: BouncingScrollPhysics(),
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: w > 1700
                                          ? 4
                                          : w > 1000 ? 3 : w > 750 ? 2 : 1,
                                      mainAxisSpacing: 0,
                                      crossAxisSpacing: 0,
                                      childAspectRatio: w > 1300
                                          ? 2
                                          : w > 1000
                                              ? 1.5
                                              : w > 550 && w < 750 ? 3 : 2,
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
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
